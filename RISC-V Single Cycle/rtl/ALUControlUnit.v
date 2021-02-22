module alu_control
// IO ports
(
    input wire [1:0] aluOP,
    input wire [2:0] funct3,
    input wire       funct7,
    output reg [3:0] aluControl
);

// internal signal declaration
assign funct = {funct7, funct3};

// symbolic state representation
// aluOP
localparam [5:0]
           LOAD_STORE_OP = 2'b00,
           BEQ_OP        = 2'b01, 
           R_OP          = 2'b10;

// funct
localparam [3:0]
           R_ADD = 4'b0000,
           R_SUB = 4'b1000,
           R_AND = 4'b0111,
           R_OR  = 4'b0110;

// body
always @* 
begin
    case(aluOP)

        LOAD_STORE_OP:
            aluControl = 4'b0010;

        BEQ_OP:
            aluControl = 4'b0110;

        R_OP:
            begin
                case(funct)
                
                    R_ADD:
                        aluControl = 4'b0010;

                    R_SUB:
                        aluControl = 4'b0110;

                    R_AND:
                        aluControl = 4'b0000;

                    R_OR:
                        aluControl = 4'b0001;

                    default:
                        aluControl = 4'b0010;
                    
                endcase  
            end
        
        default:
            aluControl = 4'bx;

        endcase
end

endmodule
