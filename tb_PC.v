module tb_PC;

reg clk;
reg rst_n;
wire [31:0] pc;

initial begin
    $dumpfile("tb_PC.vcd");
    $dumpvars(0, uut);
    // 查看波形
    $display("Time=%0t  pc=%h", $time, pc);

end

// Instantiate the PC module
PC uut (
    .clk(clk),
    .rst_n(rst_n),
    .pc(pc)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10 time units period
end

// Test sequence
initial begin
    // Initialize reset
    rst_n = 0;
    #10; // Wait for 10 time units
    rst_n = 1; // Release reset
    #100; // Wait for 100 time units to observe PC increments
    $finish; // End simulation

end
endmodule