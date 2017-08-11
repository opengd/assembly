# assembly
Some assembly projects and test code

How to run

First set the correct enviroment variables for the assembler, in this case MASM in Visual Studio 2017. 

Open cmd as administrator, and go to folder "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build".

Example: cd C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build

Run the correct script for your system and code.

Example: vcvarsall.bat x86

Now got to the folder where you have put your code and assembler and link.

Example: ml /Cx /coff mandelbrot.asm

This should produce a runable exe file called mandelbrot.exe, and if you run this file it should give you a result like this:

Example: mandelbrot.exe

                                            *
                                           **
                                          *****
                                         *****
                                    *     ****
                                   *** **********
                                    ******************
                                    *****************
                                  *******************
                           *     *********************
                        *  * *   *********************
                        *******  ********************
                        *****************************
                    *  ******************************
                     ********************************
          *****************************************
                     ********************************
                    *  ******************************
                        *****************************
                        *******  ********************
                        *  * *   *********************
                           *     *********************
                                  *******************
                                    *****************
                                    ******************
                                   *** **********
                                    *     ****
                                         *****
                                          *****
                                           **
                                            *


