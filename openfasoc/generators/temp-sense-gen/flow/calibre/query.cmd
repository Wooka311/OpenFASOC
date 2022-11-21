
# Define property numbers in annotated GDSII
GDS NETPROP NUMBER 5
GDS PLACEPROP NUMBER 6
GDS DEVPROP NUMBER 7

# Output seed polygon with net ID
GDS SEED PROPERTY DEVICE ORIGINAL

# Output annotated GDSII mapping file for Star-RCXT
RESPONSE FILE ./CCI/annotated.gds.map
GDS MAP

# GDS UNITS 0.001 1e-09
GDS WRITE ./CCI/design.agf

# Output device table file containing descriptions of device layers
# for Star-RCXT
RESPONSE FILE ./CCI/design.devtab
DEVICE TABLE
RESPONSE DIRECT

# Output layout net name / net ID mapping table for Star-RCXT
LAYOUT NETLIST DEVICE LOCATION CENTER
LAYOUT NETLIST TRIVIAL PINS YES
LAYOUT NETLIST EMPTY CELLS YES
LAYOUT NETLIST PRIMITIVE DEVICE SUBCKTS NO
LAYOUT NETLIST SEPARATED PROPERTIES NO
LAYOUT NETLIST PIN LOCATIONS NO
LAYOUT NETLIST DEVICE TEMPLATES YES
LAYOUT NETLIST HIERARCHY AGF
LAYOUT NETLIST NAMES NONE
LAYOUT NAMETABLE WRITE ./CCI/design.lnn EXPAND_CELLS

# Output ideal layout netlist for Star-RCXT
LAYOUT NETLIST WRITE ./CCI/design.spi
LAYOUT SEPARATED PROPERTIES WRITE ./CCI/design.props

# Output net / device instance cross referencing tables for Star-RCXT
#NOTE: XREF NAME <LAYOUT/SOURCE> default to ON.  <ON> adds X prefix to hierarchical subckt definitions. <OFF> drops the X prefix
#XREF XNAME LAYOUT ON
#XREF XNAME SOURCE OFF
SOURCE HIERARCHY WRITE ./CCI/design.sph
LAYOUT HIERARCHY WRITE ./CCI/design.lph
NET XREF WRITE ./CCI/design.nxf BOX LNXF
INSTANCE XREF WRITE ./CCI/design.ixf

# Output cell extents file for Star-RCXT
CELL EXTENTS WRITE ./CCI/extents.txt

# Output ports file for Star-RCXT
PORT TABLE NAME POLYGON PORTS YES
PORT TABLE WRITE ./CCI/design.ports
PORT TABLE CELLS WRITE ./CCI/design.ports_cells

LVS SETTINGS REPORT WRITE ./CCI/lvs_report_file

TERMINATE
