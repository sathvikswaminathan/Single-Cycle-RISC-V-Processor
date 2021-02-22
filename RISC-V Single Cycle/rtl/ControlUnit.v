module control_unit
// IO ports
(
    input wire [6:0] opcode,
    output reg [1:0] ImmSel, aluOP,
    output reg reg_write_en, aluSrc, MemtoReg, MemRead, MemWrite, branch
);

// symbolic opcode representation
localparam [6:0]
           R_OP     = 7'b0110011,
           LOAD_OP  = 7'b0000011,
           STORE_OP = 7'b0100011,
           BEQ_OP   = 7'b1100011;

//body
always @*
begin
    case(opcode)

        R_OP:
            begin
                ImmSel = 2'bxx;
                reg_write_en = 1'b1;
                aluSrc = 1'b0;
                MemtoReg = 1'b0;
                aluOP = 2'b10;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                branch = 1'b0; 
            end

        LOAD_OP:
            begin
                ImmSel = 2'b00;
                reg_write_en = 1'b1;
                aluSrc = 1'b1;
                MemtoReg = 1'b1;
                aluOP = 2'b00;
                MemRead = 1'b1;
                MemWrite = 1'b0;
                branch = 1'b0;                
            end

        STORE_OP:
            begin
                ImmSel = 2'b01;
                reg_write_en = 1'b0;
                aluSrc = 1'b1;
                MemtoReg = 1'b1;
                aluOP = 2'b00;
                MemRead = 1'b0;
                MemWrite = 1'b1;
                branch = 1'b0; 
            end

        BEQ_OP:
            begin
                ImmSel = 2'b10;
                reg_write_en = 1'b0;
                aluSrc = 1'b0;
                MemtoReg = 1'b0;
                aluOP = 2'b01;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                branch = 1'b1;
            end
        
        default:
            begin
                ImmSel = 2'bxx;
                reg_write_en = 1'b1;
                aluSrc = 1'b0;
                MemtoReg = 1'b0;
                aluOP = 2'b10;
                MemRead = 1'b0;
                MemWrite = 1'b0;
                branch = 1'b0; 
            end

    endcase
end

endmodule
