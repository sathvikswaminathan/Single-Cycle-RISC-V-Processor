module alu
// IO ports
(
    input  wire [31:0] a,
    input  wire [31:0] b,
    input  wire [3:0] alu_control,
    output reg [31:0] alu_result,
    output wire zero_flag
);

// ALU control symbolic representation
localparam [3:0]
           AND = 4'b0000,
           OR  = 4'b0001,
           ADD = 4'b0010,
           SUB = 4'b0010,
           SLT = 4'b1000;

// body
always @*
begin
    case(alu_control)

        AND:
            alu_result = a & b;         // BITWISE AND
        
        OR:
            alu_result = a | b;         // BITWISE OR

        ADD:
            alu_result = a + b;         // ADD

        SUB:
            alu_result = a - b;         // SUBTRACT
        
        SLT:
            alu_result = (a < b) ? 32'b1 : 32'b0;   // SET ON LESS THAN
        
        default:
            alu_result = 32'bx;
    
    endcase
end

assign zero_flag = (alu_result == 32'b0) ? 1'b1 : 1'b0;

endmodule
