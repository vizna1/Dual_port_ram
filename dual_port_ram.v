module dual_port_ram (
    input clk, we_a, we_b,
    input [3:0] addr_a, addr_b,
    input [7:0] din_a, din_b, 
    output reg [7:0] dout_a, dout_b
);
    reg [7:0] ram [15:0]; 

    always @(posedge clk)
    begin
        if (we_a)
            ram[addr_a] <= din_a;
        dout_a <= ram[addr_a];

        if (we_b)
            ram[addr_b] <= din_b;
        dout_b <= ram[addr_b];
    end
endmodule
