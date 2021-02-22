`timescale  10ns/1ns

module cpu_tb;

// signal declaration
reg clk, reset;

// DUT instantiation
cpu dut (.clk(clk), .reset(reset));

// body
initial
begin
    $monitor("time: %d", $time," pc = %d r1 = %d, r4 = %d, r10 = %d, ram[6] = %d",
            dut.pc_out, dut.reg_file.reg_file[1], dut.reg_file.reg_file[4],
            dut.reg_file.reg_file [10], dut.ram.ram[6]);
end

initial
begin
    clk = 0;
    reset = 1;
    #2
    reset = 0;
end

// clock signal generation
always
    #5 clk = ~clk;

// dump to file
initial
    begin
        $dumpfile("riscv_cpu.vcd");
        $dumpvars(0, cpu_tb);
    end

endmodule
