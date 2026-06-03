module DataMem(
    input clk,
    input rst_n,
    input enable_write, // 写使能信号
    input enable_read,  // 读使能信号
    input [31:0] addr,
    input [31:0] write_data,
    output [31:0] read_data
);

reg [31:0] data_mem [0:255]; // 256 x 32-bit数据内存

// 字节序适配
wire [31:0] mem_word = data_mem[addr[9:2]];

`ifdef ENDIAN_LITTLE
    // 小端模式：字节交换 倒过来赋值一遍
    wire [31:0] read_data_wire = {mem_word[7:0],   mem_word[15:8],
                                  mem_word[23:16], mem_word[31:24]};
    wire [31:0] write_data_wire = {write_data[7:0],   write_data[15:8],
                                   write_data[23:16], write_data[31:24]};
`else
    // 大端模式：直接使用
    wire [31:0] read_data_wire  = mem_word;
    wire [31:0] write_data_wire = write_data;
`endif

assign read_data = (enable_read) ? read_data_wire : 32'b0; // 4字节对齐地址

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (integer i = 0; i < 256; i = i + 1) begin
            data_mem[i] <= 32'b0; // Reset data memory to 0 on reset
        end
    end else begin
        if (enable_write) begin
            data_mem[addr[9:2]] <= write_data_wire;
        end
    end

endmodule