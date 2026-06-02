module  ProgramCounter(
    input clk,
    input rst_n,
    input branch_decision, // 分支决策信号
    input [31:0] branch_target, // 分支目标地址
    output [31:0] addr // 当前PC地址
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            addr <= 32'b0; // Reset PC to 0 on reset
        end else begin
            if (branch_decision) begin
                addr <= branch_target; 
            end else begin
                addr <= addr + 32'd4; 
            end
        end
    end
endmodule