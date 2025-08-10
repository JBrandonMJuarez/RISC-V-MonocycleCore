# RISC-V-SingleCycleCore

It begins with the design specifications from [1], which define a microprocessor architecture that must be composed of the main elements based on the proposed instruction set, but its design and implementation are unrestricted. Subsequently, each of the required units is described with Verilog with the specified functions for the microprocessor, taking into account the instruction set and its distribution, the way each unit is organized, and its connection to other units. Once each unit is complete, they are instantiated in a single file, interconnecting them as specified in the general diagram. During the design of the main file, the simulation is performed once the instantiation of all the units is complete in order to perform behavior tests and identify errors. The algorithm used is bubble sort, as it is an algorithm that uses most of the instruction types in the RISC-V microprocessor set. In the event of modifications, the design is compiled and simulated until the result of the test algorithm is as expected based on the result of the software simulation of the algorithm. Finally, a final synthesis and compilation is performed, from which the design and operating characteristics and parameters for the RISC-V single-cycle microprocessor are obtained.

## RISC-V single-cycle architecture
The design is based on the block diagram in [1] and takes into account the ISA broken down in [2].

<img width="941" height="686" alt="image" src="https://github.com/user-attachments/assets/12ea7bda-ff5e-4ebd-b5ba-020fcef1fffd" />

The architecture of the single-cycle microprocessor is RISC-based and consists of the following main units: program counter (PC), instruction memory, register file, arithmetic logic unit (ALU), data memory, and control unit.

##Design and synthesis of functional units with Verilog
Each of the functional units that make up the microprocessor is created using the Verilog hardware description language in order to abstract the design and behavior of the hardware by encoding algorithms that describe them.

Each unit has the advantage of being able to be implemented as the designer conceives it; there is no single design, however, it must comply with specific characteristics for the architecture while at the same time being able to be improved or adapted according to the needs of the project.
In the Quartus Prime IDE, each functional unit is started separately and, if necessary, its operation is verified by simulating its behavior. At the end of each unit, in a single project, the units are instantiated, i.e., the modules that are designed are declared and the necessary interconnections between them are made.

##Simulation
When the main design is complete, the simulation is performed by configuring the initial load of the .hex format of a test program based on the bubble sort algorithm compiled in the RISC-V assembler simulation software. Figure 3 shows a screenshot of the simulation running.

<img width="1004" height="445" alt="image" src="https://github.com/user-attachments/assets/fd75eec4-81ae-4cd2-81b5-a5717d046c23" />

## References
[1] Patterson, D & Hennessey, J. L.  “Computer Organization and Design. RISC-V Edition”. 5ta Ed. Morgan-Kaufman. 2017

[2] Patterson, D & Watterman, A. “Guía práctica de RISC-V: El Atlas de una Arquitectura Abierta”. 2018

