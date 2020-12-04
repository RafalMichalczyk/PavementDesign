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
  double precision xr, trace_strain, volstraininc, devstraininc(6), &  
    trace_stress, volstress, devstress(6), xf, norm_sig, x1, x2, &  
    f1, f2, df11, df22, df12, df21, xjac, sp_norm, xlambd, & 
    devplast(6), tr_sigp, xff, deps_tr, deps_dev(6), &
    trace_stressnew, devstressnew(6) 
!=======================================================================
!     props(1) - bulk modulus
!     props(2) - shear modulus
!     props(3) - yield limit (pure share test)
!     props(4) - alpha parameter (alpha>=0)          
!     props(5) - n parameter
!     props(6) - viscosity parameter
!     the state variables are stored as:
!         state(*,1) = norm of deviatoric stress
!         state(*,2) = trace of the stress
!     depvar = 2 
!     constants = 6
!=======================================================================
  xvol   = props(1)
  xg     = props(2)
  yield  = props(3)
  xalpha = props(4)
  xn     = props(5)
  xmu    = props(6)
  xr     = sqrt(2.)*yield  
  xlambd = xvol-2./3.*xg
! -----------------------------------------------------------
!     Create new jacobian matrix
! -----------------------------------------------------------
  do k1=1,ntens
    do k2=1,ntens
      ddsdde(k2,k1)=0.
    end do
  end do
!
  do k1=1,ndi
    do k2=1,ndi
      ddsdde(k2,k1)=xlambd
    end do
    ddsdde(k1,k1)=xlambd+2.*xg
  end do
  do k1=ndi+1,ntens
    ddsdde(k1,k1)=xg
  end do
! -----------------------------------------------------------
!     recover volumetric and deviatoric stress, strain and dstrain
! -----------------------------------------------------------
  volstraininc=(dstran(1)+dstran(2)+dstran(3))/3.
  do i=1, 3  
    devstraininc(i)=dstran(i)-volstraininc     
    devstraininc(i+3)=dstran(i+3)
  enddo
!
!     deviatoric and volumetric old stress
  trace_stress=stress(1)+stress(2)+stress(3)
  volstress=trace_stress/3.
  do i=1, 3
    devstress(i)=stress(i)-volstress
    devstress(i+3)=stress(i+3)
  enddo                                      
!
!   viscoplastic factor evaluation - newton-raphson method
  xf=statev(1)**xn+xalpha*xr**(xn-1.)*statev(2)-xr**xn
!  --------------------------------------------------------------                   
  if (xf .gt. 0.) then 
!
    norm_sig=sqrt(statev(1)**2+ (sqrt(3.)/3.*statev(2))**2)
    x1=norm_sig
    x2=norm_sig
  i=0
!
  do while (i.lt.10)
    f1=x1**xn+xalpha*xr**(xn-1.)*(statev(2)-3.*x2)- xr**xn
    f2=x1*(1.+(x2*xn*x1**(xn-2.))/(xalpha*xr**(xn-1.)))- statev(1)
    df11=xn*x1**(xn-1.)
    df12=-3.*xalpha*xr**(xn-1.)
    df21=1.+(x2*xn*(xn-1.)*x1**(xn-2.))/(xalpha*xr**(xn-1.))
    df22=(xn*x1**(xn-1.))/(xalpha*xr**(xn-1.))
    xjac=df11*df22-df12*df21
!   
    x1=x1-1./xjac*(f1*df22-f2*df12)
    x2=x2+1./xjac*(f1*df21-f2*df11)
    i=i+1
  enddo
! --------------------------------------------------------------
  sp_norm=x1
  if (sp_norm.lt.0.) sp_norm=0.
  xlambd=x2/(xmu*xalpha*xr**(xn-1.))
!
  do i=1, 6
    devplast(i)=devstress(i)/(1.+xmu*xlambd*xn*sp_norm**(xn-2.))
    deps_dev(i)=xlambd*xn*sp_norm**(xn-2.)*devplast(i)*dtime
  enddo
  deps_tr=3.*xlambd*xalpha*xr**(xn-1.)*dtime                  
!
  else
    do i=1, 6
      deps_dev(i)=0.
    end do
    deps_tr=0.
  endif
! --------------------------------------------------------------
!    update the stress
! --------------------------------------------------------------
  do i=1, 3
    stress(i) = stress(i)+  &
        3.*xvol*(volstraininc-deps_tr/3.)+  &
        2.*xg*(devstraininc(i)-deps_dev(i))
    stress(i+3) = stress(i+3)+  &
        2.*xg*(devstraininc(i+3)-deps_dev(i+3))
  enddo
! --------------------------------------------------------------
!  update the norm of deviatoric stress and the trace of stress
! --------------------------------------------------------------
  trace_stressnew = stress(1)+stress(2)+ stress(3)
  do i=1, 3
    devstressnew(i) = stress(i)-trace_stressnew/3.
    devstressnew(i+3) = stress(i+3)
  end do
  statev(1) = sqrt(devstressnew(1)**2+devstressnew(2)**2+  &
      devstressnew(3)**2+2.*(devstressnew(4)**2+  &
      devstressnew(5)**2+devstressnew(6)**2))
  statev(2) = trace_stressnew     
!
  return
end
