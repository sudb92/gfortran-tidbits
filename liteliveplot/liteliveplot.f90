module globals
    integer :: intrpt,i,pos
    real :: movarray(20), noise
end module


program movls
    use globals
    implicit none
    external handler, tinysleep
    real :: m, b, est_m, est_b
    real :: x(20) = (/(i, i=0,19)/)
    real :: sumx, sumx2
    real :: n=20
    integer :: twice=0, signum
    character(100) :: command

    sumx = SUM(x)
    sumx2 = SUM(x**2)

    intrpt=0
    pos=1
    signum=-1
    call random_seed()

    open(10,file="output")
    call signal(2,handler) !ctrl+c handling
    call execute_command_line("pqiv -c --hide-info-box --watch-files=on --wait-for-images-to-appear out.png",wait=.false.)
    do
        if(intrpt.eq.(-1)) then
            exit
        endif
        if(pos.eq.20) then
            if(twice.eq.2) then
                call random_number(m)
                signum = signum*(-1) ! flip sign each 40 units so as to not wander off
                m = abs(m)*signum
                twice=0
            endif
            twice=twice+1
        endif
        call random_number(noise)
        movarray=cshift(movarray,1,DIM=1)
        movarray(20) = movarray(19) + 2*m + 1*(noise-0.5)
        write(10,"(20(f0.2,/))") (movarray(i), i=1,20)

        est_m = (n*SUM(x*movarray) - sumx*SUM(movarray))/(n*sumx2-sumx*sumx)
        est_b = (SUM(movarray) - est_m*sumx)/n

        write(command,"(A23,f0.2,A10,f0.2,A10)") "gnuplot -e m=",est_m," -e b=",est_b," plotme"
        call execute_command_line(TRIM(command))

        call tinysleep(0.2) ! pqiv+gnuplot will crash if you make this go too fast
        pos=mod(pos,20)+1
        rewind(10) ! reset output file
    enddo
    close(10)
end program

subroutine handler
    use globals
    intrpt = -1
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
