module ControlUnit(
    input [5:0] opcode, // 指令的opcode字段
//--------- R型指令特有输入 ---------
    input [5:0] funct,  // R型指令的funct字段
//------
);

// 指令  opcode:6  rs1 rs2 rd shamt funct:6
// R型指令：opcode=0，funct字段决定具体操作
// I型指令：opcode不为0，funct字段无效  
// J型指令：opcode为特定值，funct字段无效

endmodule