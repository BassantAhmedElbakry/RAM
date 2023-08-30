module RAM #( 
    // Parameters
    parameter ADDRESS = 3,
    parameter DEPTH   = 8 ,
    parameter WIDTH   = 16

) ( 
    // I/O Ports
    input wire clk, rst,
    input wire RdEn, WrEn, 
    input wire [ADDRESS - 1 : 0] Address,
    input wire [WIDTH   - 1 : 0] WrData,
    output reg [WIDTH   - 1 : 0] RdData
);

// memory 8*16 --> 2D array
reg [WIDTH - 1 : 0] memory [DEPTH - 1 : 0]; 
integer i;

// Active Low Asynchronous Reset
always @(posedge clk or negedge rst) begin
    if(!rst) begin
        for (i = 0 ; i < 8 ; i = i + 1 ) begin
            memory[i] <= 16'b0;  
        end
    end
    else begin
        // Write Operation is done only when WrEn is high
        if(WrEn && !RdEn) begin
            memory[Address] <= WrData;
            /*
            case(Address)
            3'b000: memory[0] <= WrData;
            .
            .
            .
            But: memory[Address] <= WrData; is better [More Generic]
            */
        end
        // Read Operation is done only when RdEn is high
        else if(RdEn && !WrEn) begin
            RdData <= memory[Address];
        end        
    end
    
end
    
endmodule
