
# uSFI POC Code

This repository contains a proof of concept code for the paper [uSFI: Ultra-Lightweight Software Fault Isolation for IoT-Class Devices](http://web.eecs.umich.edu/~zaweke/publications/usfi.pdf) which was presented at **DATE18**.

The repo contains the following directories:

**Drivers** - Target specific drivers. Only drivers required to run the example applications are included here.

**Led_blink** - Source files for the example application.

**LLVM** - Contains code for the *task-attribute* LLVM pass.

**Scripts** - Python scripts used for compilation.

**uSFI** - source files for uSFI application interface and a target specific system call handler. The system call handler targets stm32f4xx devices.

## Example Application
The example application is a simple hello world application that blinks an LED and at the same time prints a message over the UART port. The application targets the [STM32 NUCLEO-F446RE development board](https://www.st.com/en/evaluation-tools/nucleo-f446re.html). The example application has two modules in addition to a *main* module - *gpio module* and *uart module*. The gpio module has access to PORTA peripheral where the LED is connected, while the uart module has access to the USART2 peripheral. 


## Compiling the Application
To compile the application, use the bash script in the Led_blink folder. The script assumes gcc ARM cross-compiler and LLVM are installed. Before compiling, set the *LLVM_PASS_PATH* variable in the scripts in the *Drivers* directory to the *task-attribute* pass library directory path.

cd Led_blink
./usfi.sh

## Running the Application
To run the application you can simply copy the generated *Led_blink.bin* file to the development board.
