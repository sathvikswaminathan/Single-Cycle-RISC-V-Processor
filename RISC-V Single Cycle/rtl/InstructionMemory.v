module instr_mem
// IO ports
(
    input wire [31:0] pc, 
    input wire reset,
    output wire [31:0] instr
);

// internal signal declaration
reg [7:0] rom [(2^32)-1:0];
wire [31:0] rom_output;
integer i;

// programming ROM with instructions
// expected output after 5 cycles: r10 = 17  
initial
begin
    // add r1, r2, r3
    rom[0]  = 8'b10110011;
    rom[1]  = 8'b00000000;
    rom[2]  = 8'b00110001;
    rom[3]  = 8'b00000000;
    // sw r1, 1(r1)
    rom[4]  = 8'b10100011;
    rom[5]  = 8'b10100000;
    rom[6]  = 8'b00010000;
    rom[7]  = 8'b00000000;
    // lw r4, 1(r1)
    rom[8]  = 8'b00000011;
    rom[9]  = 8'b10100010;
    rom[10] = 8'b00010000;
    rom[11] = 8'b00000000;
    // beq r4, r5, 8
    rom[12] = 8'b01100011;
    rom[13] = 8'b10000100;
    rom[14] = 8'b01000010;
    rom[15] = 8'b00000000;
    //
    rom[16] = 8'b00110011;
    rom[17] = 8'b00000101;
    rom[18] = 8'b10010100;
    rom[19] = 8'b00000000;
    // add r10, r9, r8
    rom[20] = 8'b00110011;
    rom[21] = 8'b00000101;
    rom[22] = 8'b10010100;
    rom[23] = 8'b00000000;
end

assign rom_output = {rom[pc+3], rom[pc+2], rom[pc+1], rom[pc]}; 
assign instr = rom_output;

endmodule
