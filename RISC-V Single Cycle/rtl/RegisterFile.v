module register_file
// IO ports
(
    input wire clk, reset,

    // read port 1
    input wire [4:0] reg_read_addr_1,
    output wire [31:0] reg_read_data_1,

    // read port 2
    input wire [4:0] reg_read_addr_2,
    output wire [31:0] reg_read_data_2,

    // write port
    input wire reg_write_en,
    input wire [4:0] reg_write_addr,
    input wire [31:0] reg_write_data
);

// internal signal declaration
reg [31:0] reg_file [31:0];
integer i;

// body

always @(posedge clk, posedge reset)
begin
    if(reset)
        begin
            for(i = 0; i < 32; i = i + 1)
                reg_file[i] = i;
        end
    else
        // write operation
        begin
            if(reg_write_en)
                reg_file[reg_write_addr] <= reg_write_data;
        end
end

// read operation
// address 32'b0 is hardwired to 32'b0
assign reg_read_data_1 = (reg_read_addr_1 == 0) ? 32'b0 : reg_file[reg_read_addr_1];
assign reg_read_data_2 = (reg_read_addr_2 == 0) ? 32'b0 : reg_file[reg_read_addr_2];

endmodule
