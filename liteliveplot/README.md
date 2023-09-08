liteliveplot
------------

  * A real bare-bones approach to real-time plotting using gnuplot from within a fortran loop. Variants using 'feedgnuplot' may be designed easily for more complex tasks. [f03gl](https://www-stone.ch.cam.ac.uk/pub/f03gl/index.xhtml) and similar routines might become necessary for more demanding tasks.
  * This particular use-case uses rewind() to overwrite on the same file. Also offers a nice illustration of cshift(). (Gotta love this existing as a ready-to-ship function!)
  * pqiv is a generally slept-on image viewer for linux, capable of auto-update-on-change, single keypress for image 'negative' toggle ('n') or removed border, and a few other nifty features
  * This program calls a gnuplot script to turn data into image each iteration, and the pqiv process monitoring the image auto-updates it. Not suited for applications demanding high speeds, but plenty good for say, a front-panel/dial list.
  * As usual, compile using ```gfortran liteliveplot.f90```. Be sure to have ```gnuplot``` and ```pqiv``` installed. 
