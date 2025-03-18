`include "vix.v"

`timescale 1ns / 1ps

module tb_dual_port_ram;

    reg clk, we_a, we_b;
    reg [3:0] addr_a, addr_b;
    reg [7:0] din_a, din_b;
    wire [7:0] dout_a, dout_b;

    dual_port_ram uut (.clk(clk), .we_a(we_a),.we_b(we_b),.addr_a(addr_a),.addr_b(addr_b),.din_a(din_a),.din_b(din_b),.dout_a(dout_a),.dout_b(dout_b));
 
    initial clk = 0;
    always #5 clk = ~clk; 

    initial begin
        $monitor("Time: %0t | clk=%b | we_a=%b addr_a=%d din_a=%h dout_a=%h | we_b=%b addr_b=%d din_b=%h dout_b=%h",
                 $time, clk, we_a, addr_a, din_a, dout_a, we_b, addr_b, din_b, dout_b);
    end

    initial begin
        $dumpfile("dual_port_ram.vcd");
        $dumpvars(0, tb_dual_port_ram);
    end

    initial begin
        we_a = 0; we_b = 0; addr_a = 0; addr_b = 0; din_a = 0; din_b = 0;

        #10;
        we_a = 1; addr_a = 4'd3; din_a = 8'hAA;
        #10;
        we_a = 0; we_b = 1; addr_b = 4'd5; din_b = 8'h55;
        #10;
        we_b = 0; addr_a = 4'd3; addr_b = 4'd5;
        #10;
        we_a = 1; we_b = 1; addr_a = 4'd7; addr_b = 4'd7; din_a = 8'h0F; din_b = 8'hF0;
        #10;
        we_a = 0; we_b = 0; addr_a = 4'd7; addr_b = 4'd7;
        #10;
        #100 $finish;
    end

endmodule
