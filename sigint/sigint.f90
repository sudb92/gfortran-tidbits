module globals
   integer :: intrpt
end module

subroutine mainloop(ret)
   use globals
   implicit none
   integer :: i,ios,ret
   real :: wtime_r
   character :: cret
   character(20) :: wtime
   external errhandler

   intrpt=0
   ret=0
   cret=achar(13)
   call date_and_time(TIME=wtime)
   call srand(nint(wtime_r))
   call signal(2,errhandler)
   print *,"Starting 20 sec loop.."
   print *,"Use ctrl+c for clean interrupt, wait it out for normal exit"
   do i=0,20
      call date_and_time(TIME=wtime)
      read(wtime,*) wtime_r
      write(*,10,IOSTAT=ios,advance="no") cret," Iter#",i," at time ",wtime_r," rand# ",rand()
10    format(A,A,i5,A,f10.3,A,f8.6)
      if(intrpt.eq.(-1)) then
         intrpt=0
         ret=-1
         return
      endif
      call sleep(1)
   enddo
end subroutine

subroutine errhandler
   use globals
   intrpt = -1
   return
end subroutine

program sigint
   implicit none
   external mainloop
   integer :: ret
   ret=0
   call mainloop(ret)
   if(ret.eq.(-1)) then
      print *,""
      print *,"Ctrl+C interrupt, clean exit via handler.."
   elseif(ret.eq.0) then
      print *,""
      print *,"Normal exit at end of loop"
   endif
end program
