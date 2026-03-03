`timescale 1ns/1ps

// ======================================================
// Universal Shift Register
// ======================================================
module universal_shift_register (
    input clk,
    input rst,
    input shift_left,
    input shift_right,
    input load,
    input serial_in,
    input [3:0] parallel_in,
    output reg [3:0] data_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        data_out <= 4'b0000;
    else if (load)
        data_out <= parallel_in;
    else if (shift_left)
        data_out <= {data_out[2:0], serial_in};
    else if (shift_right)
        data_out <= {serial_in, data_out[3:1]};
end

endmodule


// ======================================================
// SIPO
// ======================================================
module sipo (
    input clk,
    input rst,
    input serial_in,
    output reg [3:0] parallel_out
);

always @(posedge clk or posedge rst) begin
    if (rst)
        parallel_out <= 4'b0000;
    else
        parallel_out <= {parallel_out[2:0], serial_in};
end

endmodule


// ======================================================
// PISO
// ======================================================
module piso (
    input clk,
    input rst,
    input load,
    input [3:0] parallel_in,
    output reg serial_out
);

reg [3:0] shift_reg;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        shift_reg <= 4'b0000;
        serial_out <= 0;
    end
    else if (load)
        shift_reg <= parallel_in;
    else begin
        serial_out <= shift_reg[3];
        shift_reg <= {shift_reg[2:0], 1'b0};
    end
end

endmodule
