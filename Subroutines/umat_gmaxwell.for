subroutine umat(stress,statev,ddsdde,sse,spd,scd, &
    rpl,ddsddt,drplde,drpldt,stran,dstran, &
    time,dtime,temp,dtemp,predef,dpred,materl,ndi,nshr,ntens, &
    nstatv,props,nprops,coords,drot,pnewdt,celent, &
    dfgrd0,dfgrd1,noel,npt,layer,kspt,kstep,kinc)
!
  include 'aba_param.inc'
!
  character*80 cmname
  double precision stress(ntens),statev(nstatv), &
    ddsdde(ntens,ntens),ddsddt(ntens),drplde(ntens), &
    stran(ntens),dstran(ntens),time(2),predef(1),dpred(1), &
    props(nprops),coords(3),drot(3,3), &
    dfgrd0(3,3),dfgrd1(3,3)
!
  double precision stress_dev(6), stran_dev(6), dstran_dev(6),  &
    stress_vol, stran_vol, dstran_vol, XK, XG, xlambd, logA,  &
    stran_n_vol(props(1)), tr_n(props(1)), stran_n_dev(props(1),6)
  integer NB, J, K1, K2
!=======================================================================
!    props(1) - N
!    props(2) - K_0,    props(3) - G_0
!    props(4) - K_i,    props(5) - G_i 
!    props(6) - muv_i,  props(7) - mug_i 
!    ... 
!    props(N*4+4) - T0
!    props(N*4+5) - C1, props(N*4+6) - C2
!    num of constants= 3+ N*4 + 3
!    depvar=N*6
!=======================================================================
  NB = props(1)
  XG = props(2)
  XG = props(3)
  do K2=1,NB
    XK=XK+props(K1*4)
    XG=XG+props(K1*4+1)
  end do
  xlambd=XK-2./3.*XG
!    WLF shift function
  T0 = props(NB*4 + 4)
  C1 = props(NB*4 + 5)
  C2 = props(NB*4 + 6)
  logA = -(C1*(temp - T0))/(C2+(temp-T0))
  at = exp(logA)
! -----------------------------------------------------------
!     Create new jacobian matrix
! -----------------------------------------------------------
  do K1=1,ntens
    do K2=1,ntens
      ddsdde(K2,K1)=0.
    end do
  end do
!
  do K1=1,ndi
    do K2=1,ndi
      ddsdde(K2,K1)=xlambd
    end do
    ddsdde(K1,K1)=xlambd+2.*XG
  end do
  do K1=ndi+1,ntens
    ddsdde(K1,K1)=XG
  end do
! -----------------------------------------------------------
!     recover volumetric and deviatoric stress, strain and dstrain
! -----------------------------------------------------------
  stress_vol=(stress(1)+stress(2)+stress(3))/3.
  stran_vol=(stran(1)+stran(2)+stran(3))/3.
  dstran_vol=(dstran(1)+dstran(2)+dstran(3))/3.  
  
  do j=1,3
    stress_dev(j)=stress(j)-stress_vol
    stress_dev(j+3)=stress(j+3)
!
    stran_dev(j)=stran(j)-stran_vol
    stran_dev(j+3)=stran(j+3)/2.
!
    dstran_dev(j)=dstran(j)-dstran_vol
    dstran_dev(j+3)=dstran(j+3)/2.
  end do 
!
  do K1=1,NB
    stran_n_vol(K1) = (statev((K1-1)*6+1)+statev((K1-1)*6+2)  &
        + statev((K1-1)*6+3))/3.
    tr_n(K1) = (stran_vol-stran_n_vol(K1))*3.
!    
    do K2=1,3
      stran_n_dev(K1,K2)=statev((K1-1)*6+K2) - stran_n_vol(K1)
      stran_n_dev(K1,K2+3)=statev((K1-1)*6+K2+3)/2.
!
    end do 
  end do 
! -----------------------------------------------------------
!     calculate stress
! -----------------------------------------------------------
  do K2=1,ndi
    stress(K2)=   stress(K2) +  3.*XK*dstran_vol +2.*XG*dstran_dev(K2) 
    stress(K2+3)= stress(K2+3)  +  2.0*XG*dstran_dev(K2+3)
!
    do K1=1,NB
      stress(K2) = stress(K2)   &
          - dtime*(props(4*K1)*props(4*K1))/(props(4*K1+2)*at)*tr_n(K1) &
          - dtime*2.0*props(4*K1+1)*props(4*K1+1)/(props(4*K1+3)*at)*  &
          (stran_dev(K2)-stran_n_dev(K1,K2))
!
      stress(K2+3)=stress(K2+3) &
          - dtime*2.0*props(4*K1+1)* props(4*K1+1)/(props(4*K1+3)*at)* &
          (stran_dev(K2+3)-stran_n_dev(K1,K2+3))
    end do   
  end do
! -----------------------------------------------------------
!     store strains in dashpots in state variable array
! -----------------------------------------------------------
  do K1=1,NB
    do K2=1,ndi
      statev((K1-1)*6+K2)=statev((K1-1)*6+K2) &
          + 1.0/3.0*(props(4*K1)/(props(4*K1+2)*at))*tr_n(K1)*dtime &
          + 1.0*props(4*K1+1)/(props(4*K1+3)*at) *dtime* &
          (stran_dev(K2)-  stran_n_dev(K1,K2)) 
      
      statev((K1-1)*6+K2+3)=statev((K1-1)*6+K2+3)  &
          + 2.0*props(4*K1+1)/(props(4*K1+3)*at)*dtime*  &
          (stran_dev(K2+3) - stran_n_dev(K1,K2+3))
! -----------------------------------------------------------
    end do
  end do
  return
end
