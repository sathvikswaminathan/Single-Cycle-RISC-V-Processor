// Imm select and sign extend
module imm_gen
// IO ports
(
    input wire [31:0] instr,
    input wire [1:0] imm_sel,
    output wire [31:0] imm
);

// internal signal representation
reg [11:0] immidiate;
wire [31:0] sign_extended_imm;

localparam [1:0]
           LOAD = 2'b00,
           STORE = 2'b01,
           BEQ = 2'b10; 

// body
assign sign_extended_imm = $signed(immidiate);
//assign sign_extended_imm = { {20{immidiate[11]}}, immidiate };

always @*
begin
    case(imm_sel)

    LOAD:
        immidiate <= instr[31:20];

    STORE:
        immidiate <= {instr[31:25], instr[11:7]};

    BEQ:
        immidiate <= {instr[31], instr[7], instr[30:25], instr[11:8]};

    default:
        immidiate <= 12'bx;

    endcase
end

assign imm = sign_extended_imm;

endmodule
