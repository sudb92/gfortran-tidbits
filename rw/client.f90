program readwrite
 implicit none
 integer :: ios,iter,sizer,po,i
 character(16) :: buffer, buffer2, buffer3
 character :: cret
 external :: cleanexit
 character(20) :: ttyname

 ttyname = "/dev/ttyS11"
 call ttyinit(TRIM(ttyname)//char(0))
 open(10,file=ttyname,IOSTAT=ios)
 if(ios.ne.0) then
    print *,"/dev/ttyS11 not opened, ios=",ios
    call exit
 endif

 i=0
 cret=achar(13)
 call signal(2,cleanexit)
 do
!    write(*,"(A)",advance="no") "> "
!    read(*,*) buffer
    if(i.le.10) then
        buffer="x" ! query the server 10 times
    else
        buffer="q" !close the server after 10 tries
    endif
    if(i.eq.4) then
        buffer="m" ! x10 on the rand
    endif

    write(10,*) TRIM(buffer),achar(13),achar(10)
!    inquire(10,SIZE=sizer,POS=po)
!    print *,"size:",sizer," pos:",po
    read(10,*,iostat=ios) buffer2,buffer3
    call sleep(1) ! keep things civilized
    buffer="what bruh"
    write(10,*) TRIM(buffer),achar(13),achar(10)

    if(ios.ne.0) then
       print *,"grr"
       continue
       ios=0
    endif
    print *,TRIM(buffer2),":",TRIM(buffer3),":"
    read(buffer2,*) i
    if(i.eq.(-1)) then
        close(10)
        print *,"Received exit, stopping."
        call exit
    endif
    i=i+1
 enddo
end program

subroutine cleanexit
 implicit none
 close(10)
 print *,""
 print *,"Clean exit via Ctrl+C"
 call exit
end subroutine
