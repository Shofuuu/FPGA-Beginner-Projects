`timescale 1ns/1ps

//! @title UART TX Module
//! @author Muhammad Shofuwan Anwar
//! This module is used to transmit `8-bit` data via UART communications protocol.
//! State machine in this module are consist of 4 states. Which is started on `IDLE`,
//! and continue to `START_BIT` when the `en` is capturing a *high* logic. In this state
//! UART sending *low* as a starting bit, and afterwards continue to sending the data
//! bits by changing the state to `DATA_TRANSMIT`. Transmitting the 8-bits LSB one-by-one via tx
//! pin until the counter reach `4'd8`. After hit the last data index, state changed to `STOP_BIT`.
//! In this state, UART send *high* logic to indicate the communication was ended. You can see
//! on the waveforms below, how UART send *'N'* (8'd78) character over tx pin.
//! 
//! { signal: [
//! { name: "clk_baud", wave: "P............" },
//! { name: "rst", wave: "hl..........." },
//! { name: "en", wave: "l.h.........." },
//! { name: "data", wave: "x=...........", data: ["01001110"] },
//! { name: "tx", wave: "1..0.1..0.101", node: "...ab.......ef" },
//! { node: "....c.......d."},
//! { name: "busy", wave: "0..1........." },
//! ], edge :[
//!     "a<->b", "c<->d data bits", "e<->f"
//! ], head: {
//!     text: "UART TX Module waveforms", tick: 0, every: 1
//! }}
module uart_tx (
        input wire clk_baud, //! clock input from top module
        input wire rst, //! reset the register value
        input wire en, //! start/enable the uart transmitter
        input wire [7:0] data, //! 8-bit data that will be transmitted
        output reg tx, //! data transmitter pin
        output reg busy //! flag indicating data transmission in progress (includes stop bit)
    );

    localparam IDLE = 2'd0; //! idle state, default tx=1
    localparam START_BIT = 2'd1; //! sending start bit to begin the uart communication
    localparam DATA_TRANSMIT = 2'd2; //! transmitting the data
    localparam STOP_BIT = 2'd3; //! stop bit to end the uart communication, by sending tx=1

    reg [1:0] state, next_state; //! 2-bit register to hold the state machine
    reg [3:0] counter; //! 4-bit counter to access every bits in the data (count until 8)
    reg [7:0] data_buf; //! buffer to hold the data, make it stable for the process

    //! register to keep the scheduler state
    always @(posedge clk_baud or posedge rst) begin: data_counter
        if (rst) begin
            tx       <= 1'b1;
            state    <= IDLE;
            counter  <= 4'd0;
            busy     <= 1'b0;
            data_buf <= 8'd0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    tx       <= 1'b1;
                    counter  <= 4'd0;
                    busy     <= 1'b0;
                    data_buf <= data;
                end
                START_BIT: begin
                    tx <= 1'b0;
                    busy <= 1'b1;
                end
                DATA_TRANSMIT: begin
                    tx <= data_buf[counter];
                    counter <= counter + 4'b1;
                    busy <= 1'b1;
                end
                STOP_BIT: begin
                    tx <= 1'b1;
                    busy <= 1'b1;
                end

                default: begin
                    tx      <= 1'b1;
                    counter <= 4'd0;
                    busy    <= 1'b0;
                end
            endcase
        end
    end

    //! UART TX state machine
    always @(*) begin: uart_state_machine
        next_state = state;

        case (state)
            IDLE: if (en) next_state = START_BIT;
            START_BIT: next_state = DATA_TRANSMIT;
            DATA_TRANSMIT: next_state = (counter == 4'd7 ? STOP_BIT : DATA_TRANSMIT);
            STOP_BIT: next_state = IDLE;
            
            default: next_state = IDLE;
        endcase
    end

endmodule

