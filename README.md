# RAM
$$color{red}Verilog \space Design \space of \space 8 \space x \space 16 \space Register \space File }$$ 
### Register File Specification:
- A register file consists of 8 registers, each register of 16-bit width. 
- The register file has read data bus(RdData), write data 
bus(WrData) and one address bus (Address) used for both read 
and write operations.
- Each register can be read and written by applying a register 
address to be accessed.
- Only one operation (read or write) can be evaluated at a time. 
- Write Operation is done only when WrEn is high 
- Read operation is done only when RdEn is high. 
- Read and Write operations are done on positive edge of Clock
- All the registers are cleared using Asynchronous active low Reset 
signal

![WhatsApp Image 2023-08-30 at 11 17 41](https://github.com/BassantAhmedElbakry/RAM/assets/104600321/71ea4cb2-a4da-49d1-a50b-f83e6f62ae5b)


