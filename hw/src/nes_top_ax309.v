// ALINX AX309 clone Xilinx Spartan-6 XC6SLX16 (This is AX309 clone So it not XC6SLX9)
//  Copyright (c) 2022 FREE WING,Y.Sakamoto
module nes_top_ax309
(
  input  wire       CLK_50MHZ,         // 50MHz system clock signal
  input  wire       BTN_nRESET,        // reset push button
  input  wire       BTN_nCPU_RESET,    // console reset
  input  wire       RXD,               // rs-232 rx signal
  //input  wire [3:0] SW,                // switches
  //input  wire       NES_JOYPAD_DATA1,  // joypad 1 input signal
  //input  wire       NES_JOYPAD_DATA2,  // joypad 2 input signal
  output wire       TXD,               // rs-232 tx signal
  output wire       VGA_HSYNC,         // vga hsync signal
  output wire       VGA_VSYNC,         // vga vsync signal
  output wire [3:0] VGA_RED,           // vga red signal
  output wire [3:0] VGA_GREEN,         // vga green signal
  output wire [3:0] VGA_BLUE,          // vga blue signal
  // output wire       NES_JOYPAD_CLK,    // joypad output clk signal
  // output wire       NES_JOYPAD_LATCH,  // joypad output latch signal
  output wire       AUDIO,             // pwm output audio channel
  output wire [3:0] led,

  inout         usb_dp,
  inout         usb_dm
);

wire BTN_SOUTH = ~BTN_nRESET;
wire BTN_EAST  = ~BTN_nCPU_RESET;
wire [3:0] SW  = 4'b0001;
wire [7:0] led8;
assign led = led8[3:0]; // START, SELECT, B, A
// assign led = led8[7:4]; // Right, Left, Down, Up

wire CLK_100MHZ;
wire CLK_24MHz;
wire RESET = 1'b0;

DCM_50MHz_to_100MHz dcm(
    // Clock in ports
    .CLK_IN1(CLK_50MHZ),    // IN
    // Clock out ports
    .CLK_OUT1(CLK_100MHZ),  // OUT
    .CLK_OUT2(CLK_24MHz),     // OUT
    // Status and control signals
    .RESET(RESET),          // IN
    .LOCKED()         // OUT
);

// JOYPAD
wire [ 7:0] joypad_cfg;
wire        joypad_cfg_upd;

nes_top nes_top(
  .CLK_100MHZ(CLK_100MHZ),
  .BTN_SOUTH(BTN_SOUTH),
  .BTN_EAST(BTN_EAST),
  .RXD(RXD),
  .SW(SW),
  .TXD(TXD),
  .VGA_HSYNC(VGA_HSYNC),
  .VGA_VSYNC(VGA_VSYNC),
  .VGA_RED(VGA_RED),
  .VGA_GREEN(VGA_GREEN),
  .VGA_BLUE(VGA_BLUE),
  .AUDIO(AUDIO),
//  .AUDIO_SD(),
//  .led(led8)
  .joypad_cfg(joypad_cfg),
  .joypad_cfg_upd(joypad_cfg_upd)
);

// Instantiate the module
wire [7:0] usb_joy;
wire usb_joy_clk;
wire usb_out_gate;
wire usb_dp_o;
wire usb_dm_o;
usb_gamepad_module usb_gamepad_module (
    .clk24(CLK_24MHz), 
    .rst(!BTN_nRESET), 
    .uart_rx(1'b0), 
    .uart_tx(), 
    .usb_gamepad_data(usb_joy), 
	.usb_gamepad_ena(usb_joy_clk),
    .usb_out_gate(usb_out_gate), 
    .usb_dp_in(usb_dp), 
    .usb_dm_in(usb_dm), 
    .usb_dp_out(usb_dp_o), 
    .usb_dm_out(usb_dm_o)
    );

assign usb_dp = usb_out_gate ? usb_dp_o : 1'bz;
assign usb_dm = usb_out_gate ? usb_dm_o : 1'bz;
assign led8 = usb_joy; // START, SELECT, B, A

assign joypad_cfg_upd = usb_joy_clk;
assign joypad_cfg = usb_joy;

endmodule
