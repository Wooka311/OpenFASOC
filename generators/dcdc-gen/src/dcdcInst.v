// Designed by Jeongsup Lee

module dcdcInst (
    inout VDD,
    inout VSS,
    inout AVDD,
    inout GND,
    inout VOUT,
    input clk,
	input VREF_in, //new added input
	input dummy_in,
	input [5:0] sel_vh, sel_vl,
	output reg dummy_out
	input [1:0] s; //add the select input --changed by jianwei jia 02/08/2022
);

    wire w_clk0, w_clk0b, w_clk1, w_clk1b;
    wire [DCDC_NUM_STAGE-1:0] y0_top, y0_bot, y1_top, y1_bot;
	wire comp_out, clk_gate_out, FF_out;
	
	always @ (posedge clk) begin
		dummy_out <= ~dummy_in;
    end
	
    DCDC_SIX_STAGES_CONV u_DCDC_SIX_STAGES_CONV(
		.VDD(VDD),
		.VSS(VSS),
		.AVDD(AVDD),
		.GND(GND),
		.VOUT(VOUT),
		.sel_vh(sel_vh),
		.sel_vl(sel_vl),
		.w_clk0(w_clk0),
		.w_clk0b(w_clk0b), 
		.w_clk1(w_clk1), 
		.w_clk1b(w_clk1b)
	);
	// AUX CELL DCDC_NOV_CLKGEN--changed by jianwei jia 02/08/2022
    DCDC_NOV_CLKGEN u_DCDC_NOV_CLKGEN (
        .clk_in(FF_out),
		.s (s),//notice, two bit to select the dead time
        .clk0(w_clk0),
        .clk0b(w_clk0b),
        .clk1(w_clk1),
        .clk1b(w_clk1b)
    );
	
	// AUX CELL DCDC_COMP
	DCDC_COMP u_DCDC_COMP(
		.pos_in(VREF_in), 
		.neg_in(VOUT), 
		.clk(clk), 
		.out(comp_out)
	);
	
	// Clock Gate
	sky130_fd_sc_hd__dlclkp_1 u_DCDC_CLKGATE(
		.CLK(clk), 
		.GATE(comp_out), 
		.GCLK(clk_gate_out)
	);
	
	// Sync FF
	sky130_fd_sc_hd__dfxtp_1 u_DCDC_FF(
		.CLK(clk_gate_out), //check which input is clk
		.D(FF_out_inv), 
		.Q(FF_out)
	);
	
	// Sync Inv
	sky130_fd_sc_hd__inv_1 u_DCDC_INVERTER( 
		.A(FF_out), 
		.Y(FF_out_inv)
	);
endmodule

