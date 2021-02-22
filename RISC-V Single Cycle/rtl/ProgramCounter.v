module pc
// IO ports
(
    input wire clk, reset,
    input wire [31:0] pc_in,
    output reg [31:0] pc_out
);

// body
always @(posedge clk, posedge reset) 
begin
    if(reset)
        pc_out <= 32'b0;
    else
        pc_out <= pc_in;
end

endmodule
