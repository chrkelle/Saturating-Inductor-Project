`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2019 01:21:15 PM
// Design Name: 
// Module Name: ADC_test
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


module ADC_test(sys_clk_p, sys_clk_n, reset, start, hi_muxsel,
dco_p, dco_n, da_p, da_n, db_p, db_n,
aclk_p, aclk_n, cnv_p, cnv_n, tp, tl, clk);

    input wire sys_clk_p, sys_clk_n;
    input wire reset, start;
    input wire dco_p, dco_n;
    input wire da_p,da_n;
    input wire db_p,db_n;
    
    
    output wire hi_muxsel;
    
    output wire aclk_p, aclk_n;
    output wire cnv_p, cnv_n, tp, tl;
     
    
    output wire clk;
//    output wire [9:0] counter;
//    output wire [9:0] state;
//    output wire cntr_load;

//*************************    
    
    assign hi_muxsel = 0;
    assign tp = 1;
    
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD("LVDS_25")) 
    IBUFDS_inst0 (.O(clk_in), .I(sys_clk_p), .IB(sys_clk_n));
    
    clk_wiz_0 inst0(.clk_out1(clk), .clk_in1(clk_in));                      
    
        IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD("LVDS_25")) // Specify the input I/O standard)
    IBUFDS_inst1(.O(da), .I(da_p), .IB(da_n));
            
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD("LVDS_25")) // Specify the input I/O standard)
    IBUFDS_inst3(.O(db), .I(db_p), .IB(db_n));
        
    IBUFDS #(.DIFF_TERM("FALSE"), .IBUF_LOW_PWR("FALSE"), .IOSTANDARD("LVDS_25")) // Specify the input I/O standard)
    IBUFDS_inst4(.O(dco), .I(dco_p), .IB(dco_n));
       
    OBUFDS #(.IOSTANDARD("LVDS_25"))   // Low power="TRUE", Highest performance="FALSE"
    OBUFDS_inst0(.O(aclk_p), .OB(aclk_n), .I(aclk));
    
    //module instantiation        
    ADC adc(.clk(clk), .reset(reset), .dco(dco), .da(da),. db(db), .start(start),
         .aclk(aclk), .cnv(cnv_p), .tp(temp), .tl(tl), .data(ADC_out), .adc_done(adc_done));
        
   
endmodule
