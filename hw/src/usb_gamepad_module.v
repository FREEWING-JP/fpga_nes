`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:05:06 07/31/2022 
// Design Name: 
// Module Name:    usb_gamepad_module 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module usb_gamepad_module (  
    input   clk24,
    input   rst,
    input   uart_rx,
    output  uart_tx,
//
input         usb_dp_in,
input         usb_dm_in,
output        usb_out_gate,
output        usb_dp_out,
output        usb_dm_out,
output        usb_gamepad_ena,
output     [7:0]   usb_gamepad_data
                     );

endmodule
