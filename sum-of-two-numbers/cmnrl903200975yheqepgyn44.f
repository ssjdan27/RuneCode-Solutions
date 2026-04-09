program main
    implicit none
    integer(8) :: a, b
    read(*, *) a, b
    write(*, '(I0)') a + b
end program main