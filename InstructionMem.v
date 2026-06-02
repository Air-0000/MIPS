module InstructionMem(
    input [31:0] addr,
    output [31:0] instruction
);

reg [31:0] instr_mem [0:255]; // 256 x 32-bit instruction memory

assign instruction = instr_mem[addr[9:2]]; // 4-byte aligned address (256 entries)
// 低两位地址一定为0，所以我们使用addr[9:2]来索引指令内存

// b'100 = d‘4 
// 所以低两位是0～3，指令地址必须是4的倍数

endmodule
