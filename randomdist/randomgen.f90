module globals
    integer :: intrpt,i
    real :: histogram(100)
end module

program randomgen
    use globals
    implicit none
    real :: rand,s
    external handler

    call signal(2,handler) !for ctrl+c handling
    call random_seed()     !seed the randgen
    open(10,file="/tmp/t1234")
    intrpt=0
    do i=1,100
        histogram(i)=0
    enddo
    call execute_command_line("gnuplot plotme",wait=.false.) !asynchronous start, keep going after open, don't block
    do
        call random_number(rand)
        associate (z=> histogram(ceiling(rand*100.0)))
            z=z+1
        end associate
        if(intrpt.eq.(-1)) then
            exit
        endif
        s=SUM(histogram)
        rewind(10) ! clear file
        write(10,"(100(F8.7,/))") (histogram(i)/s,i=1,100)
        flush(10) ! make sure the file gets written
        call tinysleep(0.0006)
    enddo
    close(10)
end program

subroutine handler
    use globals
    intrpt=-1
end subroutine

subroutine tinysleep(fact)
    integer,parameter:: k = selected_int_kind(5)
    integer(kind=k) :: millis,i
    real :: fact
    i=0
    do while(i.lt.(fact*0.2*huge(millis)))
        i=i+1
    enddo
end subroutine
