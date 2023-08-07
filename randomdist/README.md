randomdist.f90
--------------
  * Use-case for ```associate```
  * No-waiting/non-blocking command-line call that starts a gnuplot routine simultaneous to the loop
  * Simple histogramming method, use of rewind() and flush() to update the histogram in real-time
  * Compile using ```gfortran randomdist.f90``` as usual
  * Sample output image below, satisfying uniformish distribution in [0,1] :) 
  * Demonstates an old-school count-to-huge-number approach to a time-delay to generate smooth plotting (```sleep``` only sleeps for 1 second lowest)
   <img src="https://github.com/sudb92/gfortran-tidbits/blob/main/randomdist/out.png" alt="" width="640"/> 
(Gnuplot could be made to monitor and histgram the output in real-time, but this approach avoids filling up the output buffer too much)

