`timescale 1ns / 1ps

//! @title LED Blinker Timer
//! @author Muhammad Shofuwan Anwar
//! This module generates a square wave by toggling an LED output based on a counter.
//! The counter resets when it reaches `THRESHOLD = CLOCK_FREQ / BLINK_FREQ`.
//!
//! Here's the waveforms output for better visualization
//! { signal:[
//! { name: "clk", wave: "P.............." },
//! {	name: "counter", wave: "===============", 
//! 	data:["5F","60","61","62","63","00",
//!			  "01","02","03","04", "05", "06",
//!			  "07", "08", "09", "0A"] },
//! { name: "led", wave: "0....1........." }
//! ], head: {
//! 	text: 'LED Blinker Timer Waveforms @500KHz', tick: 95, every: 1
//! }}
module timer #(
		parameter integer WIDTH = 26,
		parameter integer CLOCK_FREQ = 50_000_000, //! external crystal oscillator
		parameter integer BLINK_FREQ = 1 //! blinking frequency rate in Hz
	)(
		input wire rst, //! reset pin for clearing the register value
		input wire clk, //! clock source pin
		output reg led //! led output pin
	);

	//! The *THRESHOLD* constant defines the number of clock cycles per toggle event
	localparam integer THRESHOLD = (CLOCK_FREQ/BLINK_FREQ);
	reg [WIDTH-1:0] counter = 0; //! register to count clock cycles up to threshold

	//! This always block continously incrementing the counter register
	//! until it's reach the *THRESHOLD* value. Afterwards, the counter
	//! will be reset and the led is toggled.
	always @(posedge clk or posedge rst) begin : counter_reg
		if (rst) begin
			counter <= 0;
			led <= 1'b0;
		end else if ((counter >= THRESHOLD)) begin
			counter <= 0;
			led <= ~led;
		end else
			counter <= counter + 1'b1;
	end

endmodule
