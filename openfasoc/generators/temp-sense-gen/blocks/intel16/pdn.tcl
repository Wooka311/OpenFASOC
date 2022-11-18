# Get tap and endcap cells
set block [ord::get_db_block]
set all_insts [$block getInsts]
set region [$block findRegion "TEMP_ANALOG"]
set boundary [$region getBoundaries]
set caps_analog {}
set caps_core {}
foreach inst $all_insts {
  if {[[$inst getMaster] getName] eq "b15ztpn00an1d03x5" || \
      [[$inst getMaster] getName] eq "b15zdcf11an1n04x5"} {
    set box [$inst getBBox]

    # Select cells from TEMP_ANALOG region
    if { [$box xMin] >= [$boundary xMin] && [$box xMax] <= [$boundary xMax] \
      && [$box yMin] >= [$boundary yMin] && [$box yMax] <= [$boundary yMax]} {
        lappend caps_analog $inst
      } else {
        lappend caps_core $inst
      }
  }
}

# Add global connections
add_global_connection -net VDD -inst_pattern {.*} -pin_pattern {vcc} -power ;# default: VDD as power
add_global_connection -net VDD -inst_pattern {temp_analog_1.*} -pin_pattern {vcc} -power
add_global_connection -net VIN -inst_pattern {temp_analog_0.*} -pin_pattern {vcc} -power
add_global_connection -net VSS -inst_pattern {.*} -pin_pattern {vssx} -ground

# Manually add connections for tap and encap cells
foreach inst $caps_analog {
  add_global_connection -net VIN -inst_pattern [$inst getName] -pin_pattern {vcc} -power
}
foreach inst $caps_core {
  add_global_connection -net VDD -inst_pattern [$inst getName] -pin_pattern {vcc} -power
}

global_connect

# Set voltage domains
# TEMP_ANALOG region created with the create_voltage_domain command
set_voltage_domain -name CORE -power VDD -ground VSS
set_voltage_domain -region TEMP_ANALOG -power VIN -ground VSS

# Standard cell grids
# VDD / GND
define_pdn_grid -name stdcell -pins m8 -starts_with POWER -voltage_domains CORE

add_pdn_stripe -grid stdcell -layer m1 -width 0.044 -followpins
add_pdn_stripe -grid stdcell -layer m2 -width 0.044 -followpins
add_pdn_ring -grid stdcell -layer {m7 m8} -widths {0.9 0.9} -spacings {0.36 0.36} -core_offsets {0.36 0.36}
add_pdn_stripe -grid stdcell -layer m7 -width 0.180 -pitch 10.80 -offset 1.765 -extend_to_core_ring
add_pdn_stripe -grid stdcell -layer m6 -width 0.160 -pitch 10.80 -offset 3.240 -extend_to_core_ring
add_pdn_stripe -grid stdcell -layer m5 -width 0.044 -pitch 10.80 -offset 2.304
add_pdn_stripe -grid stdcell -layer m4 -width 0.044 -pitch 10.80 -offset 3.240
add_pdn_stripe -grid stdcell -layer m3 -width 0.044 -pitch 10.80 -offset 2.304

# Straps to connect the two domains together
#add_pdn_stripe -grid stdcell -layer m8 -width 0.18 -offset 10.0 -pitch 4.320 -extend_to_core_ring -starts_with GROUND
#add_pdn_stripe -grid stdcell -layer m8 -width 0.18 -pitch 4.320 -extend_to_core_ring -starts_with GROUND -number_of_straps 4 -nets VSS

add_pdn_connect -grid stdcell -layers {m1 m2} -dont_use_vias ".*_illegal" -ongrid {m1}
add_pdn_connect -grid stdcell -layers {m2 m3} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell -layers {m3 m4} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell -layers {m4 m5} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell -layers {m5 m6} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell -layers {m6 m7} -dont_use_vias ".*_illegal"
add_pdn_connect -grid stdcell -layers {m7 m8} -dont_use_vias ".*_illegal"

# VIN / GND
define_pdn_grid -name stdcell_analog -pins m3 -starts_with POWER -voltage_domains TEMP_ANALOG

add_pdn_stripe -grid stdcell_analog -layer m1 -width 0.044 -followpins
add_pdn_stripe -grid stdcell_analog -layer m2 -width 0.044 -followpins
add_pdn_ring -grid stdcell_analog -layer {m7 m8} -widths {0.3 0.3} -spacings {0.24 0.24} -core_offsets {0.24 0.24}
add_pdn_stripe -grid stdcell_analog -layer m7 -width 0.180 -pitch 10.80 -offset 1.765 -extend_to_core_ring
add_pdn_stripe -grid stdcell_analog -layer m6 -width 0.160 -pitch 10.80 -offset 3.240 -extend_to_core_ring
add_pdn_stripe -grid stdcell_analog -layer m5 -width 0.044 -pitch 10.80 -offset 2.304
add_pdn_stripe -grid stdcell_analog -layer m4 -width 0.044 -pitch 10.80 -offset 3.240
add_pdn_stripe -grid stdcell_analog -layer m3 -width 0.044 -pitch 10.80 -offset 2.304

add_pdn_connect -grid stdcell_analog -layers {m1 m2} -dont_use_vias ".*_illegal" -ongrid {m1}
add_pdn_connect -grid stdcell_analog -layers {m2 m3} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell_analog -layers {m3 m4} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell_analog -layers {m4 m5} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell_analog -layers {m5 m6} -dont_use_vias ".*_illegal" 
add_pdn_connect -grid stdcell_analog -layers {m6 m7} -dont_use_vias ".*_illegal"
add_pdn_connect -grid stdcell_analog -layers {m7 m8} -dont_use_vias ".*_illegal"
