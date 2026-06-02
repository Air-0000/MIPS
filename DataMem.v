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
`ifdef ENDIAN_LITTLE
    // 小端模式：地址最低位对应最低有效字节
    // 例如，地址0存储数据的最低8位，地址1存储次低8位，以此类推
    // 这里我们假设数据内存是一个简单的寄存器数组来模拟
    // 实际设计中需要考虑地址对齐和内存大小等问题
`else
    // 大端模式：地址最低位对应最高有效字节
    // 例如，地址0存储数据的最高8位，地址1存储次高8位，以此类推
    // 这里我们假设数据内存是一个简单的寄存器数组来模拟
    // 实际设计中需要考虑地址对齐和内存大小等问题
`endif

assign read_data = (enable_read) ? data_mem[addr[9:2]] : 32'b0; // 4字节对齐地址

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        for (integer i = 0; i < 256; i = i + 1) begin
            data_mem[i] <= 32'b0; // Reset data memory to 0 on reset
        end
    end else begin
        if (enable_write) begin
            // 写操作：将write_data写入数据内存（这里我们假设数据内存是一个简单的寄存器数组）
            // 注意：实际设计中需要考虑地址对齐和内存大小等问题
            // 这里我们简单地使用一个寄存器数组来模拟数据内存
            data_mem[addr[9:2]] <= write_data; // 4字节对齐地址
        end
    end

endmodule