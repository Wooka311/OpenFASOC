export DESIGN_NICKNAME = tempsense
export DESIGN_NAME = tempsenseInst_error

export PLATFORM    = intel16

export VERILOG_FILES 		= $(sort $(wildcard ./design/src/$(DESIGN_NICKNAME)/*.v)) \
			  	  ../blocks/$(PLATFORM)/tempsenseInst.blackbox.v
export SDC_FILE    		= ./design/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export DIE_AREA   	 	= 0 0 33.048 34.02
export CORE_AREA   		= 3.024 3.15 30.024 30.87

# area of the smaller voltage domain
export VD1_AREA                 = 4.428 4.41 11.556 9.45

# power delivery network config file
export PDN_TCL 			= ../blocks/$(PLATFORM)/pdn.tcl

export HEADER_TCL		= ../blocks/$(PLATFORM)/pdn_header.tcl

export ADDITIONAL_LEFS  	+= ../blocks/$(PLATFORM)/lef/headerA.lef \
                       	  	   ../blocks/$(PLATFORM)/lef/headerB.lef \
                                   ../blocks/$(PLATFORM)/lef/headerC.lef \
				   ../blocks/$(PLATFORM)/lef/SLC.lef

export ADDITIONAL_GDS 	 	= ../blocks/$(PLATFORM)/gds/headerA.gds \
				  ../blocks/$(PLATFORM)/gds/headerB.gds	\
				  ../blocks/$(PLATFORM)/gds/headerC.gds \
				  ../blocks/$(PLATFORM)/gds/SLC.gds

export ADDITIONAL_CDL           = ../blocks/$(PLATFORM)/cdl/headerA.cdl \
				  ../blocks/$(PLATFORM)/cdl/headerB.cdl \
				  ../blocks/$(PLATFORM)/cdl/headerC.cdl \
				  ../blocks/$(PLATFORM)/cdl/SLC.cdl

# informs what cells should be placed in the smaller voltage domain
export DOMAIN_INSTS_LIST 	= ../blocks/$(PLATFORM)/tempsenseInst_domain_insts.txt

# configuration for placement

# don't run global place w/o IOs
export HAS_IO_CONSTRAINTS = 1
# don't run non-random IO placement (step 3_2)
export PLACE_PINS_ARGS = -random

export GPL_ROUTABILITY_DRIVEN = 1

# DPO optimization currently fails on the tempsense
export ENABLE_DPO = 0

#export CELL_PAD_IN_SITES_GLOBAL_PLACEMENT = 4
#export CELL_PAD_IN_SITES_DETAIL_PLACEMENT = 2

# configuration for routing

export PRE_GLOBAL_ROUTE = $(SCRIPTS_DIR)/openfasoc/pre_global_route.tcl

# informs any short circuits that should be forced during routing
export CUSTOM_CONNECTION 	= ../blocks/$(PLATFORM)/tempsenseInst_custom_net.txt

# indicates with how many connections the VIN route from the HEADER cells connects to the VIN power ring
export VIN_ROUTE_CONNECTION_POINTS = 3
