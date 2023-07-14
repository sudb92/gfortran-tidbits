# gfortran-tidbits
A few example programs that help me remember some helpful gfortran tricks

<h5>sigint.f90</h5>

*  Demonstrates a clean implementation of the pure fortran signal() routine
*  Inspired by the very useful notes at <url>https://sharcnet.ca/help/images/4/42/Fortran_Signal_Handling.pdf</url>
*  Several sources opine with good reason to avoid a call like call signal(2,handler), but I use it to keep my project simple. Please consult the above reference to implement a quick C-interoperable version if you aim for portability, so that a standard name such as SIGINT could replace the number
*  The capability to use modules to set scope allows for clean transfer of control during runtime