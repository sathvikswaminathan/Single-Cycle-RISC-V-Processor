module cpu
// IO ports
(
    input wire clk, reset
);

// internal signal declaration
wire [31:0] pc_in, pc_out;
wire [31:0] instr;
wire pc_src, zero, branch;
assign pc_src = branch & zero;

wire [31:0] imm, shifted_imm;
wire [1:0] imm_sel;
assign shifted_imm = imm << 1;

wire [31:0] reg_read_data_1, reg_read_data_2, reg_write_data; 
wire [4:0] rs1, rs2, rd;
wire reg_write_en;
assign rs1 = instr[19:15];
assign rs2 = instr[24:20];
assign rd = instr[11:7];

wire AluSrc;
wire [3:0] ALUControl;
wire [31:0] ALUResult, ALUop2;
wire [1:0] ALUop;

wire MemtoReg, MemRead, MemWrite;
wire [31:0] MemData;

//body
// IF stage
assign pc_in = pc_src ? (pc_out + shifted_imm) : (pc_out + 4);
pc program_counter (.clk(clk), .reset(reset), .pc_in(pc_in), .pc_out(pc_out));
instr_mem rom (.pc(pc_out), .reset(reset), .instr(instr));

// ID stage
control_unit main_control_unit (.opcode(instr[6:0]), .ImmSel(imm_sel), .aluOP(ALUop),
                                .reg_write_en(reg_write_en), .aluSrc(AluSrc), 
                                .MemtoReg(MemtoReg), .MemRead(MemRead),
                                .MemWrite(MemWrite), .branch(branch));
register_file reg_file (.clk(clk), .reset(reset), .reg_read_addr_1(rs1),
                        .reg_read_data_1(reg_read_data_1), .reg_read_addr_2(rs2),
                        .reg_read_data_2(reg_read_data_2), .reg_write_addr(rd),
                        .reg_write_en(reg_write_en), .reg_write_data(reg_write_data));
imm_gen imm_gen (.instr(instr), .imm_sel(imm_sel), .imm(imm));

// EX stage
assign ALUop2 = AluSrc ? imm : reg_read_data_2;
alu_control alu_control_unit (.aluOP(ALUop), .funct3(instr[14:12]), .funct7(instr[30]),
                              .aluControl(ALUControl));
alu alu (.a(reg_read_data_1), .b(ALUop2), .alu_control(ALUControl), 
         .alu_result(ALUResult), .zero_flag(zero));

// MEM stage
data_memory ram (.clk(clk), .reset(reset), .addr(ALUResult), .write_data(reg_read_data_2),
                 .MemRead(MemRead), .MemWrite(MemWrite), .read_data(MemData));

// WB stage
assign reg_write_data = MemtoReg ? MemData : ALUResult;

endmodule
