//`timescale 1ns/10ps
`timescale 1ns/1ns

module ucounter8_tb;

reg  clk, _areset, _aset, _load, _updown, _wrapstop;
reg  [7:0] preld_val;
wire [7:0] dcount;
wire overflow;
reg  [7:0] dcount_tb;
reg  overflow_tb;
integer i;

    ucounter8 g(overflow, dcount, clk, _areset, _aset, _load, preld_val, _updown, _wrapstop);
    initial
    begin
        clk = 0;
        _areset = 1; 
        _aset = 0;
        _load = 0;
        _updown = 1;
        _wrapstop = 0;
        preld_val = 8'b11111000;

        dcount_tb = 0;
        overflow_tb = 0;
        $dumpfile("ucounter8_tb");
        $dumpvars;
        #10000 $finish;
    end
    
    always begin
        #1 clk = ~clk;
    end
 
    initial begin
        _areset = 1;
        #3 _areset = 0;
        #5 _load = 1;
    end

    initial begin
        dcount_tb = 0;
        #3;
        for (i = 0; i < 5; i = i+1) begin
            dcount_tb = dcount_tb + 1;
            #1;
        end
        dcount_tb = 8'b11111000;
    end
endmodule
