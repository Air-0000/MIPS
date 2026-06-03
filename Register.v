module Register(
    input clk,
    input rst_n,
    input enable_write, // 写使能信号
    input [4:0] write_addr, // 写寄存器地址
    input [31:0] write_data, // 写数据
    input [4:0] read_addr1, // 读寄存器1地址
    input [4:0] read_addr2, // 读寄存器2地址
    output [31:0] read_data1, // 读寄存器1数据
    output [31:0] read_data2  // 读寄存器2数据
);

reg [31:0] registers [0:31]; // 32 x 32-bit寄存器

assign read_data1 = registers[read_addr1];
assign read_data2 = registers[read_addr2];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (integer i = 0; i < 32; i = i + 1) begin
            registers[i] <= 32'b0; // Reset all registers to 0 on reset
        end
    end else begin            // 5位是因为 2^5 = 32 个寄存器
        if (enable_write && write_addr != 5'b0) begin // $zero寄存器始终为0，禁止写入
            registers[write_addr] <= write_data;
        end
    end
end

endmodule