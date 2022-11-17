module TEMP_ANALOG_lv (EN, OUT, OUTB);
 input  EN;
// inout in_vin;
 output OUT, OUTB;
 wire  n;
wire n1;
wire n2;
wire n3;
wire n4;
wire n5;
wire n6;
wire n7;
wire nx1, nx2, nx3, nb1, nb2;
b15nand02an1n02x5 a_nand_0 ( .a(EN),  .b(n7), .o1(n1));
b15inv000an1n02x5 a_inv_0  ( .a(n1),  .o1(n2));
b15inv000an1n02x5 a_inv_1  ( .a(n2),  .o1(n3));
b15inv000an1n02x5 a_inv_2  ( .a(n3),  .o1(n4));
b15inv000an1n02x5 a_inv_3  ( .a(n4),  .o1(n5));
b15inv000an1n02x5 a_inv_4  ( .a(n5),  .o1(n6));
b15inv000an1n02x5 a_inv_5  ( .a(n6),  .o1(n7));
b15inv000an1n02x5 a_inv_m1 ( .a(n7),  .o1(nx1));
b15inv000an1n02x5 a_inv_m2 ( .a(n7),  .o1(nx2));
b15inv000an1n02x5 a_inv_m3 ( .a(nx2), .o1(nx3));
b15bfn000an1n02x5 a_buf_3  ( .a(nx3), .o(nb2));
b15bfn000an1n02x5 a_buf_0  ( .a(nx1), .o(nb1));
b15bfn000an1n02x5 a_buf_1  ( .a(nb1), .o(OUT));
b15bfn000an1n02x5 a_buf_2  ( .a(nb2), .o(OUTB));

endmodule
