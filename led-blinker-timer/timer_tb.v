module timer_tb;
    reg clk = 1'b0;
    reg rst = 1'b1;
    wire led;

    //! Generate master clock
    always #5 clk = ~clk;

    //! Unit Under Test for timer module
    timer #(.CLOCK_FREQ(100), .BLINK_FREQ(2)) uut (
        .clk(clk),
        .rst(rst),
        .led(led)
    );

    initial begin
        $dumpfile("timer_tb.vcd");
        $dumpvars(0, timer_tb);
        $display("[TIMER_TB] Starting test..");

        //! reset after 20ns
        #20 rst = 1'b0;

        //! run simulation
        #1000;
        $finish;
    end
endmodule