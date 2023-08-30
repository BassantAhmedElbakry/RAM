// Scale my time to micro second 
`timescale 1us/1us

module RAM_tb #(
    parameter ADDRESS = 3,
    parameter DEPTH   = 8,
    parameter WIDTH   = 16
) ();

parameter CLK_PERIOD = 10;

// Design TB signals
reg clk_tb,rst_tb;
reg [WIDTH   - 1 : 0] WrData_tb;
reg [ADDRESS - 1 : 0] Address_tb;
reg RdEn_tb, WrEn_tb;
wire [WIDTH - 1 : 0] RdData_tb;

// Instantiate module
RAM Ram (
    .clk(clk_tb),
    .rst(rst_tb),
    .WrData(WrData_tb),
    .Address(Address_tb),
    .RdEn(RdEn_tb),
    .WrEn(WrEn_tb),
    .RdData(RdData_tb)
);

// Generate clock --> 100k Hz --> Tperiod = 10 micro seconds
always #(CLK_PERIOD/2) clk_tb = ~clk_tb;

// Initial Block
initial begin

    $dumpfile ("ram.vcd");
    $dumpvars;
    
    // Intialize
    Initialize();

    // Reset 
    Reset();

    // ************************************* TESTS ************************************* // 
   
   // Test 1 --> Test write and read data 
   // Write Data 0xF3F3 at adrress 000
    Write_Data('hF3F3,'b000);

    // Enable Reading Data 
    RdEn_tb = 1'b1; 

    #(CLK_PERIOD)
    // Reading the Data
    if(RdData_tb == 16'hF3F3) begin
        $display("TEST 1 IS PASSED");
    end
    else begin
        $display("TEST 1 IS FAILED");
    end
    // Test 2 --> Test Enable signal

    // Write and read enable are high together 
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b1; 

    // Write Data 0x33 at address 001
    #(CLK_PERIOD)
    Address_tb = 3'b001;
    WrData_tb  = 16'h33; 

    #(CLK_PERIOD)
    // Reading the Data --> mustn't change because write and read Enable are high together
    if(RdData_tb == 16'hF3F3) begin
        $display("TEST 2 IS PASSED");
    end
    else begin
        $display("TEST 2 IS FAILED");
    end  

    // Test 3 

    // Disable Reading and Enable writing 
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;

    // Write Data 0xFF at address 001
    #(CLK_PERIOD)
    Address_tb = 3'b001;
    WrData_tb  = 16'hFF;     

    // Enable Reading Data and Disable writing
    #(CLK_PERIOD)
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;

    #(CLK_PERIOD)
    // Reading the Data
    if(RdData_tb == 16'hFF) begin
        $display("TEST 3 IS PASSED");
    end
    else begin
        $display("TEST 3 IS FAILED");
    end 

   // Test 4 --> Test rst signal

   Reset();

   #(CLK_PERIOD)
    if(RdData_tb == 16'h0000) begin
        $display("TEST 4 IS PASSED");
    end
    else begin
        $display("TEST 4 IS FAILED");
    end 

    // Test 5 --> Both WrEn & RdEn are low

    // Disable Reading and Enable writing 
    WrEn_tb = 1'b1;
    RdEn_tb = 1'b0;    

    // Write Data 0xF57F at address 101
    #(CLK_PERIOD)
    Address_tb = 3'b101;
    WrData_tb  = 16'hF57F; 

    // Enable Reading Data and Disable writing
    #(CLK_PERIOD)
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b1;      

    // Disable both writing and reading
    #(CLK_PERIOD)
    WrEn_tb = 1'b0;
    RdEn_tb = 1'b0; 

    // Address[001] has data = 0x000
    #(CLK_PERIOD)
    Address_tb = 3'b001;       

    // Data should be the data at Address 101 which = 0xF57F (The last data at Bus before Disable Reading) 
   #(CLK_PERIOD)
    if(RdData_tb == 16'hF57F) begin
        $display("TEST 5 IS PASSED");
    end
    else begin
        $display("TEST 5 IS FAILED");
    end 

    $finish;
    
end
// ************************************* TASKS ************************************* //
task Initialize;
    begin
        // Initial values
        clk_tb = 1'b0;
        rst_tb = 1'b1;
        RdEn_tb = 1'b0;
        WrEn_tb = 1'b0;
        WrData_tb = 16'b0;
        Address_tb = 3'b0;
    end
endtask

task Reset;
    begin
        rst_tb = 1'b0;
        #(CLK_PERIOD)
        rst_tb = 1'b1;
    end
endtask

task Write_Data;
input [WIDTH   - 1 : 0] DATA;
input [ADDRESS - 1 : 0] Address;
    begin
        // Enable Writing
        WrEn_tb    = 1'b1;
        Address_tb = Address;
        WrData_tb  = DATA;
     
        // Disable Writing
        #(CLK_PERIOD)
        WrEn_tb = 1'b0;
    end
endtask
    
endmodule
