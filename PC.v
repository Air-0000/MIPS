module PC (
    input clk,
    input rst_n,
    output reg [31:0] pc
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc <= 32'b0; // Reset PC to 0 on reset
        end else begin
            pc <= pc + 4; // Increment PC by 4 on each clock cycle
        end
    end
endmodule