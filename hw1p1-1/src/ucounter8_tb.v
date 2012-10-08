//`timescale 1ns/10ps
`timescale 1ns/1ns

module ucounter8_tb;
parameter CLK_CYCLE = 2;
parameter DEFAULT_VAL = 8'b11111000;
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
        _wrapstop = 1;
        preld_val = DEFAULT_VAL;
        
        $dumpfile("ucounter8_tb");
        $dumpvars;
        #10000 $finish;
    end
    
    always begin
        #(CLK_CYCLE/2) clk = ~clk;
    end
    
    initial begin
        #CLK_CYCLE _areset = 0;
        #(CLK_CYCLE*5) _load = 1;
        #CLK_CYCLE _load = 0;
    end
 
    initial begin
        #1 dcount_tb = 0;
        for (i = 0; i < 5; i = i + 1) begin
            #(CLK_CYCLE) dcount_tb = dcount_tb + 1;
        end

        #(CLK_CYCLE) dcount_tb = DEFAULT_VAL;
        for (i = 0; i < 10; i = i + 1) begin
            #(CLK_CYCLE) dcount_tb = dcount_tb + 1;
        end
    end

endmodule