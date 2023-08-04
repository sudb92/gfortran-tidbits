program server
   implicit none
   integer :: ios,i
   character :: cret
   character(40) :: resp
   character(8) :: packet
   external cleanexit
   character(20) :: ttyname

   ttyname = "/dev/ttyS10"
   call ttyinit(TRIM(ttyname)//char(0))
   open(10,file=ttyname,IOSTAT=ios)
   call signal(2,cleanexit)
   call srand(342)
   i=0
   cret = achar(13)
   do
!     inquire(10,SIZE=s,POS=p)
!     print *,s,p,"wait"
     read(10,*) packet
!     print *,packet," aa"
     packet=TRIM(packet)
        if(packet.eq."x") then
           write(resp,7) i,rand()
7          format(i0,f8.3)
           write(10,*) TRIM(resp),achar(13),achar(10)
           print *,packet,i,TRIM(resp)
          i=i+1
        endif
        if(packet.eq."m") then
           write(resp,7) i,10*rand()
           write(10,*) TRIM(resp),achar(13),achar(10)
           print *,packet,i,TRIM(resp)
        endif
        if(packet.eq."q") then
            write(resp,7) -1,-1.0
            write(10,*) TRIM(resp),achar(13),achar(10)
            close(10)
            print *,"Received a q, clean exit.."
            call exit
        endif
   enddo
end program

subroutine cleanexit
   implicit none
   close(10)
   print *,""
   print *,"Clean exit via Ctrl+C"
   call exit
end subroutine
