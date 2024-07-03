program estructura
  implicit none

  ! Cálculo de tamaño de núcleo de reproductores
  ! Lafayette - Indiana, 3 de julio del 2024
  ! Basado en Muller, J. 2010.
  ! https://www.produccion-animal.com.ar/produccion_de_camelidos/camelidos_general/156-estategias.pdf
  ! gerardocmamani@gmail.com

  integer :: c_hembras_base
  real :: porcentaje_machos, reemplazo, tasa_reproductiva, prop_machos, i_select_m
  real :: c_machos_base, b_hembras_multi, b_machos_multi
  real :: a_hembras_nucleo, a_machos_nucleo
  real :: un_nucleo(2), un_multi(2), un_base(2)
  integer :: nucleos
  real :: disperso_nucleo(2)
  integer :: iunit, ios, pos
  character(len=256) :: line

  ! Abrir archivo de parámetros
  iunit = 10
  open(unit=iunit, file='parametros.txt', status='old', action='read', iostat=ios)
  if (ios /= 0) then
     print *, "Error al abrir el archivo de parámetros."
     stop
  end if

  ! Leer parámetros desde el archivo
  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) c_hembras_base

  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) porcentaje_machos

  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) reemplazo

  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) tasa_reproductiva

  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) prop_machos

  read(iunit, '(A)') line
  pos = index(line, '=')
  read(line(pos+1:), *) i_select_m

  close(iunit)

  c_machos_base = c_hembras_base * porcentaje_machos
  b_hembras_multi = nint((c_machos_base / reemplazo) / (tasa_reproductiva * prop_machos))
  b_machos_multi = nint(b_hembras_multi * porcentaje_machos)
  a_hembras_nucleo = nint((b_machos_multi / reemplazo) / (tasa_reproductiva * prop_machos * i_select_m))
  a_machos_nucleo = nint(a_hembras_nucleo * porcentaje_machos)

  un_nucleo(1) = a_hembras_nucleo
  un_nucleo(2) = a_machos_nucleo
  un_multi(1) = b_hembras_multi
  un_multi(2) = b_machos_multi
  un_base(1) = c_hembras_base
  un_base(2) = c_machos_base

  print *, " "
  print *, "ESTRATO NUCLEO:"
  print *, "Hembras:", un_nucleo(1)
  print *, "Machos :", un_nucleo(2)
  print *, " "
  print *, "ESTRATO MULTIPLICADOR:"
  print *, "Hembras:", un_multi(1)
  print *, "Machos :", un_multi(2)
  print *, " "
  print *, "ESTRATO BASE:"
  print *, "Hembras:", un_base(1)
  print *, "Machos :", un_base(2)
  print *, " "

  !nucleos = 2
  !disperso_nucleo = un_nucleo / nucleos
  !print *, "Número de hembras en cada núcleo disperso de", nucleos, "núcleos:", disperso_nucleo(1)
  !print *, "Número de machos en cada núcleo disperso de", nucleos, "núcleos:", disperso_nucleo(2)

end program estructura
