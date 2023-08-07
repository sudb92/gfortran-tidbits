randomdist.f90
--------------
  * Use-case for ```associate```
  * Asynchronous command-line call that starts a gnuplot routine simultaneous to the loop
  * Simple histogramming method, use of rewind() and flush() to update the histogram in real-time
  * Compile using ```gfortran randomdist.f90``` as usual
  * Sample output ![image](https://github.com/sudb92/gfortran-tidbits/blob/main/randomdist/out.png)
(Gnuplot could be made to monitor and histgram the output in real-time, but this approach keeps memory-run-off at the output buffer)

