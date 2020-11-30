subroutine dload(f,kstep,kinc,time,noel,npt,layer,kspt, &
      coords,jltyp,sname)
!
  include 'aba_param.inc'
!
  dimension time(2), coords(3)
  character*80 sname
!
!  definition of local variables
  real p_load, v_load, l_span, elem, s_load, elemhalf
!====================================================================
!   USER SUBROUTINE TO MODELL MOVING PRESSURE
!
  p_load=720.E3  !pressure intensity  [Pa]
  v_load=14.0    !load velocity    [m/s]
  l_span=0.165    !length of the load span [m]
  elem=0.05    !element size    [m]
!====================================================================
  elemhalf = elem / 2  
  s_load=v_load*time(2)
!--------------------------------------------------------------------
  f = 0.    !Magnitude of the distributed load
  if (coords(3) + elemhalf .le. s_load) then
!
    if (coords(3) - elemhalf .ge. s_load - l_span) then
      f=p_load
    else if (coords(3) + elemhalf .gt. s_load - l_span) then
      f=p_load * (coords(3) + elemhalf - (s_load - l_span)) / elem
    end if
!        
  else if (coords(3) - elemhalf .lt. s_load) then
    f=p_load*(s_load - (coords(3)-elemhalf))/elem
  end if
!--------------------------------------------------------------------
  return
  end
!
subroutine utracload(alpha,t_user,kstep,kinc,time,noel,npt,  &
       coords,dircos,jltyp,sname)
!
  include 'aba_param.inc'
!
  dimension t_user(3), time(2), coords(3), dircos(3,3)
  character*80 sname
!
!  definition of local variables
  real trac_load, v_load, l_span, elem, s_load, elemhalf
!
!====================================================================
!   USER SUBROUTINE TO MODELL MOVING TRACTION LOAD
!
  trac_load=72.E3   !traction intensity  [Pa]
  v_load=14.0      !load velocity    [m/s]
  l_span=0.165      !length of the load span [m]
  elem=0.05      !element size    [m]
!====================================================================
  elemhalf = elem / 2
  s_load=v_load*time(2)
!--------------------------------------------------------------------
!
  alpha = 0.    !Magnitude of the distributed traction load
  t_user(1)=0.0  !direction X of the distributed traction 
  t_user(2)=0.0  !direction Y of the distributed traction  
  t_user(3)=1.0  !direction Z of the distributed traction
!
  if (coords(3) + elemhalf .le. s_load) then
!
    if (coords(3) - elemhalf .ge. s_load - l_span) then
      alpha=trac_load
    else if (coords(3) + elemhalf .gt. s_load - l_span) then
      alpha=trac_load * (coords(3) + elemhalf -(s_load - l_span)) / elem
    end if
!        
  else if (coords(3) - elemhalf .lt. s_load) then
    alpha=trac_load*(s_load - (coords(3)-elemhalf))/elem
  end if
!-------------------------------------------------------------------- 
  return
end