module tb_shift_register;

reg clk;
reg rst;
reg shift_left;
reg shift_right;
reg load;
reg serial_in;
reg [3:0] parallel_in;

wire [3:0] data_out;
wire [3:0] sipo_out;
wire piso_out;

// Instantiate modules
universal_shift_register usr (
    .clk(clk),
    .rst(rst),
    .shift_left(shift_left),
    .shift_right(shift_right),
    .load(load),
    .serial_in(serial_in),
    .parallel_in(parallel_in),
    .data_out(data_out)
);

sipo sipo_inst (
    .clk(clk),
    .rst(rst),
    .serial_in(serial_in),
    .parallel_out(sipo_out)
);

piso piso_inst (
    .clk(clk),
    .rst(rst),
    .load(load),
    .parallel_in(parallel_in),
    .serial_out(piso_out)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // ✅ ADD THESE TWO LINES FOR WAVEFORM
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_shift_register);

    clk = 0;
    rst = 1;
    shift_left = 0;
    shift_right = 0;
    load = 0;
    serial_in = 0;
    parallel_in = 4'b1011;

    #10 rst = 0;

    // Parallel Load
    #10 load = 1;
    #10 load = 0;

    // Shift Left
    serial_in = 1;
    shift_left = 1;
    #40 shift_left = 0;

    // Shift Right
    serial_in = 0;
    shift_right = 1;
    #40 shift_right = 0;

    #20 $finish;
end

endmodule
