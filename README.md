# gfortran-tidbits
A few example programs that help me remember some helpful gfortran tricks

<h5>sigint.f90</h5>

*  Demonstrates a clean implementation of the pure fortran signal() routine
*  Inspired by the very useful notes here <url>https://sharcnet.ca/help/images/4/42/Fortran_Signal_Handling.pdf</url>
*  Several sources opine with good reason to avoid a call like call signal(2,handler), but I use it to keep my project simple. Please consult the above reference, or !(this nice github link)[https://github.com/leifdenby/fortran-kill-signal-handler/] to implement a quick C-interoperable version if you aim for portability, so that a standard name such as SIGINT could replace the number
*  The capability to use modules to set scope allows for clean transfer of control during runtime
*  Compile and run the program simply with
```
gfortran sigint.f90; ./a.out 
```
* Tested on GNU Fortran v11.3.0 in Ubuntu 22.04, running Linux 5.19.0.45-generic 64-bit kernel
