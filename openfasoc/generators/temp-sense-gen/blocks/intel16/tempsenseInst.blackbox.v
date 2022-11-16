(* blackbox *) module SLC(
  output VOUT,
  input IN,
  input INB
);
endmodule
(* keep_hierarchy *)
(* blackbox *) module HEADER(
  inout VIN
);
parameter dont_touch = "on";
endmodule
(* blackbox *) module headerA(
  inout VIN
);
parameter dont_touch = "on";
endmodule
(* blackbox *) module headerB(
  inout VIN
);
parameter dont_touch = "on";
endmodule
(* blackbox *) module headerC(
  inout VIN
);
parameter dont_touch = "on";
endmodule
