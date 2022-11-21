set block [ord::get_db_block]

# Add 2W, 2S rule to ring oscillator input
create_ndr -name NDR_r_VIN \
           -spacing { m1 *1 m2:m7 0.09 } \
           -width { m1 *1 m2:m7 0.09  }

#set ndr [$block findNonDefaultRule NDR_5W_5S]
#$ndr setHardSpacing 1

assign_ndr -ndr NDR_r_VIN -net r_VIN
