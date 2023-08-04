rwserial
--------

  * Allows testing serial communication between a client (/dev/ttyS11) connected to a server (/dev/ttyS10) via a virtual 'socat' command. Could be extended to have two real serial ports
    to communicate with each other
  * Compile the programs running the compile-script 'compileme' 
  * On two separate terminal windows, run the following commands before testing the executables
    (make the virtual 'link' between the ports)  
    ```
    sudo socat PTY,link=/dev/ttyS10 PTY,link=/dev/ttyS11
    ```
    (Keep the above command running. In a new terminal window, provide the user with permissions to read/write to the ports)
    ```
    sudo chmod 777 /dev/ttyS10
    sudo chmod 777 /dev/ttyS11
    ```
  * Following the above, execute
    ```
    ./server
    ./client
    ```
    in order, in two separate terminal windows
  * The server will wait for the client to start, following which it will respond to queries from the client with number data until it receives a q, when it will send -1 before exiting.
  * The client will exit when it receives a -1 from the server.
