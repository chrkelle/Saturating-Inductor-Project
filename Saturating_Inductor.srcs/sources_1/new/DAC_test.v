`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2019 12:47:24 PM
// Design Name: 
// Module Name: DAC_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DAC_test(sys_clk_p, sys_clk_n, reset, start, hi_muxsel, clk, dacclk, ctrl_2_dac, mode);

    input wire sys_clk_p, sys_clk_n;
    input wire reset, start;
    
    output wire hi_muxsel;
    
    output wire clk, dacclk, mode;
    output reg [13:0] ctrl_2_dac;
    reg [13:0] n_ctrl_2_dac;

//*************************    
    
    assign hi_muxsel = 0;
    wire clk_in, dac_done;
    reg [5:0] count, n_count;
      
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD("LVDS_25")) 
    IBUFDS_inst0 (.O(clk_in), .I(sys_clk_p), .IB(sys_clk_n));
    
    clk_wiz_0 inst0(.clk_out1(clk), .clk_in1(clk_in));                      
    
    //module instantiation        
    DAC dac(.clk(clk), .start(start), .reset(reset),
                             .dacclk(dacclk), .dac_done(dac_done), .mode(mode));
     
    always@* begin
        n_count = count + 1;
        if(count[5] == 1)
            n_ctrl_2_dac = ctrl_2_dac + 1;
    end
    
    always @(posedge clk, posedge reset) begin
        if(reset) begin
            ctrl_2_dac <= 0;
            count <= 0;
        end
        else begin
            ctrl_2_dac <= n_ctrl_2_dac;
            count <= n_count;
        end
    end 
           
endmodule
