## FPGA Spartan-6 XC6SLX16でファミコンを動かす！
Xilinx FPGA Spartan-6 XC6SLX16 NES clone in ALINX AX309  
http://www.neko.ne.jp/~freewing/fpga/xilinx_spartan_6_nes_ax309/

Nexys 3 Spartan-6 FPGA board用の実装を ALINX AX309 cloneで動く様に改変したものです。  

オリジナルの https://github.com/brianbennett/fpga_nes に https://github.com/brianbennett/fpga_nes/issues/34 の[denghongcai@021a890](https://github.com/denghongcai/fpga_nes/commit/021a890721ca7dfa8bf397dcce3d0221d1f0095a)のパッチを適用しています。  

**Development Environment:**

1. [ISE 14.7 WebPack](https://japan.xilinx.com/downloadNav/vivado-design-tools/archive-ise.html) (free)
2. [Visual Studio 2017 Community](https://visualstudio.microsoft.com/ja/vs/older-downloads/) (free)

* オリジナルの https://github.com/brianbennett/fpga_nes
```
[Windows PC] nesdbg.exe -- (38400bps) -- [Nexys 3 Spartan-6 FPGA board] -- VGA display (RGB332,640x480,31KHz)
                                                      +-- [actual NES Controller(4021 shift register)]  
```
* denghongcai改造版 https://github.com/denghongcai/fpga_nes
```
[Windows PC] nesdbg.exe -- (256000bps) -- [Nexys 3 Spartan-6 FPGA board] -- VGA display (RGB444,640x480,31KHz)  
       +-- USB joypad
```
* FREE WING改造版 https://github.com/FREEWING-JP/fpga_nes
```
[Windows PC] nesdbg.exe -- (256000bps) -- [ALINX AX309 clone Spartan-6 FPGA board] -- VGA display (RGB444,640x480,31KHz)
       +-- USB joypad
```

* fpga_nes is "Only mapper 0 is supported."  
Mapper 0 = PRG = 16/32KB、CHR = 8KB  

* Transfer .nes Image  
Launch nesdbg.exe  
```
rem Launch nesdbg.exe
rem 123 as COM port COM123
nesdbg.exe 123

rem Select File and Load ROM...
```
![nesdbg.exe](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/master/assets/fpga_nes_load_nes_cassete_game_image.png)  

![pic 1](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/master/assets/xilinx_spartan_6_nes_ax309_1.jpg)  
![pic 2](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/master/assets/xilinx_spartan_6_nes_ax309_2.jpg)

---
* FREE WING改造版 https://github.com/FREEWING-JP/fpga_nes/tree/feature/support_usb_gamepad with USB GamePad ver.
```
[Windows PC] nesdbg.exe -- (256000bps) -- [ALINX AX309 clone Spartan-6 FPGA board] -- VGA display (RGB444,640x480,31KHz)
                                                          +-- USB joypad (Low Speed only)
```
### Notice Before Synthesize
```
Copy
./hw/src/usb_gamepad_module.ngc
to
./hw/ise/
Before Synthesize .
```

## USB HOST機能を FPGAに実装する方法、FPGAの GPIOに USB HIDデバイスを接続したい！！
http://www.neko.ne.jp/~freewing/fpga/usb_host_fpga/
Support Low Speed USB Gamepad only .  

![usb 1](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/feature/support_usb_gamepad/assets/usb_host_fpga_schematics.png)  
![usb 2](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/feature/support_usb_gamepad/assets/usb_host_fpga_18.jpg)  
I don't have 15k ohm resistor . So I use 22k ohm .  
![usb 3](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/feature/support_usb_gamepad/assets/usb_connector_pin_assign.jpg)  
![usb 4](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/feature/support_usb_gamepad/assets/buffalo_bsgp815gy_usb_gamepad_1.jpg)  
BUFFALO model BSGP815GY CLASSIC USB GAMEPAD  
![usb 5](https://raw.githubusercontent.com/FREEWING-JP/fpga_nes/feature/support_usb_gamepad/assets/usb_host_fpga_receive_3.png)  
USB Protocol wave form .  
---
**fpga_nes** is an fpga-targeted Nintento Entertainment System emulator written in Verilog.  It is currently under development, and is most notably missing support for mappers and the DMC sound channel.  At this point, it runs most NROM games capably (e.g., Super Mario Brothers, Excitebike).

In addition, this project includes a C++ Windows application called NesDbg, which communicates with the FPGA over USB UART to load ROMs, run unit tests, readwrite memory, etc.

**Hardware Setup:**

![alt text](http://1.bp.blogspot.com/-BfVh-h9vj14/T-9pofsWmEI/AAAAAAAAAG8/kW62NiNQTsE/s320/setup.jpg "Title")

1. [Nexys 3 Spartan-6 FPGA board](http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,400,897&Prod=NEXYS3). ($119 / $199)
2. Micro-USB connection for FPGA power and programming.
3. VGA display connection for NES video output.
4. Micro-USB connection for communication between NES and NesDbg software.
5. [PmodBB Bread Board](http://www.digilentinc.com/Products/Detail.cfm?NavPath=2,401,471&Prod=PMOD-BB) for a solderless joypad connection.  ($20)
6. [NES Joypad Adapter](http://www.parallax.com/StoreSearchResults/tabid/768/txtSearch/nes/List/0/SortField/4/ProductID/613/Default.aspx) to accept input from joypads.  ($5)
7. 2 [NES Joypads](http://www.parallax.com/Store/Accessories/Hardware/tabid/162/txtSearch/nes/List/0/SortField/4/ProductID/528/Default.aspx) to accept user input.  (2 * $5)
8. [PmodAMP1](http://www.digilentinc.com/Products/Detail.cfm?Prod=PMOD-AMP1) to amplify NES PWM audio output.  ($20)
9. [Speaker](http://www.digilentinc.com/Products/Catalog.cfm?NavPath=2,393&Cat=3) to play the NES sound.  ($6)


**Development Environment:**

1. [ISE 14.1 WebPack](http://www.xilinx.com/support/download/index.htm) (free)
2. [Visual Studio 2010 Express](http://www.microsoft.com/visualstudio/en-us/products/2010-editions/visual-cpp-express) (free)
