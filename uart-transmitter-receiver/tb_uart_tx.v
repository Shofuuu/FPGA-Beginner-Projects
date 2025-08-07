module tb_uart_tx;
    reg clk_baud    = 1'b0;
    reg rst         = 1'b1;
    reg en          = 1'b0;
    reg [7:0] data  = 8'd78;
    wire tx;
    wire busy;

    uart_tx uut(
        .clk_baud(clk_baud),
        .rst(rst),
        .en(en),
        .data(data),
        .tx(tx),
        .busy(busy)
    );

    always #5 clk_baud = ~clk_baud;

    initial begin
        $dumpfile("tb_uart_tx.vcd");
        $dumpvars(0, tb_uart_tx);
        $display("[TB_UART_TX] UART TX started..");

        #20 rst = 1'b0;
        #5 en = 1'b1;

        #150 rst = 1'b1; en = 1'b0;

        #20 rst = 1'b0;
        #5 en = 1'b1;

        #150 rst = 1'b1; en = 1'b0;
        $finish;
    end

endmodule