module data_memory
// IO ports
(
    input wire clk, reset,
    input wire [31:0] addr, 
    input wire [31:0] write_data,
    input wire MemRead, MemWrite,
    output wire [31:0] read_data
);

// internal signal declaration
reg [7:0] ram [(2^32)-1:0];      // byte addressable memory
wire [31:0] read_word;
integer i;

// body
always @(posedge clk, posedge reset)
begin
    if(reset)
        ram[i] <= 8'b0;
    else
        begin
            // write operation
            if(MemWrite)
                begin
                    ram[addr]   <= write_data[7:0];
                    ram[addr+1] <= write_data[15:8];
                    ram[addr+2] <= write_data[23:16];
                    ram[addr+3] <= write_data[31:24];
                end
        end
end

// read
assign ram_output = {ram[addr+3], ram[addr+2], ram[addr+1], ram[addr]};
assign read_data = MemRead ? ram_output : 32'bx;

endmodule
