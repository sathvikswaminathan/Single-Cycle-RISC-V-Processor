**RISC-V Single Cycle Processor**
==============

Basic implementation of a 32-bit single-cycle processor based on the RV32I Base Integer Instruction Set written in Verilog.


Environment 
------------

```Icarus Verilog```

```GTKWave```

Instruction Set
---------------

The processors currently support a small subset of the RV32I Base Integer Instruction Set. The Instruction Set can easily be expanded by modifying the code.
Instruction   | Type   | Format
------------  | -----  | ---------------------------------------------------------------
ADD           | R-type | ```<0000000><rs2><rs1><000><rd><1100011>``` 
SUB           | R-type | ```<0100000><rs2><rs1><000><rd><1100011>``` 
AND           | R-type | ```<0000000><rs2><rs1><111><rd><1100011>``` 
OR            | R-type | ```<0000000><rs2><rs1><110><rd><1100011>``` 
LW            | I-type | ```<Imm><rs1><010><rd><0000011>``` 
SW            | S-type | ```<Imm[11:5]><rs2><rs1><010><Imm[4:0]><0100011>``` 
BEQ           | SB-type| ```<Imm[12]><Imm[10:5]><rs2><rs1><000><Imm[4:1]><Imm<[11]><1100011>```


Architecture
------------

![](https://github.com/sathvikswaminathan/RISC-V-Single-Cycle-Processor/raw/main/RISC-V%20Single%20Cycle/Architecture.jpg)



Verification
------------

The processor has been verified using a testbench and sample code programmed into instruction memory.

Waveform visualized using GTKWave:

![](https://github.com/sathvikswaminathan/RISC-V-Single-Cycle-Processor/raw/main/RISC-V%20Single%20Cycle/waveform.png)
