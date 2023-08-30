# RAM
##                             Verilog Design of 8 x 16 Register File
### Register File Specification:
- A register file consists of 8 registers, each register of 16-bit width. 
<br>- The register file has read data bus(RdData), write data 
bus(WrData) and one address bus (Address) used for both read 
and write operations.
<br>- Each register can be read and written by applying a register 
address to be accessed.
<br>- Only one operation (read or write) can be evaluated at a time. 
<br>- Write Operation is done only when WrEn is high 
<br>- Read operation is done only when RdEn is high. 
<br>- Read and Write operations are done on positive edge of Clock
<br>- All the registers are cleared using Asynchronous active low Reset 
signal

![WhatsApp Image 2023-08-30 at 11 17 41](https://github.com/BassantAhmedElbakry/RAM/assets/104600321/71ea4cb2-a4da-49d1-a50b-f83e6f62ae5b)


