# pins.tcl
# Append pin location assignments into the project's .qsf file.
# Usage from Quartus Tcl shell (or generic Tcl):
#    source pins.tcl
# It will append the assignments to lab5_kg.qsf in the same folder.

## pins.tcl — simple set_location_assignment lines
# Source this file from the Quartus Tcl console before compiling to apply pin
# assignments for the project (e.g. in Quartus Tcl console:
#    source c:/path/to/lab5_kg/pins.tcl
# Or add a call to source it from any build script that runs Quartus Tcl.

# Seven-segment display (display_led[0..6])
set_location_assignment PIN_G18  -to top.display_led[0]
set_location_assignment PIN_F22  -to top.display_led[1]
set_location_assignment PIN_E17  -to top.display_led[2]
set_location_assignment PIN_L26  -to top.display_led[3]
set_location_assignment PIN_L25  -to top.display_led[4]
set_location_assignment PIN_J22  -to top.display_led[5]
set_location_assignment PIN_H22  -to top.display_led[6]

# Switch inputs and reset
set_location_assignment PIN_AB28 -to top.sw[0]
set_location_assignment PIN_AC28 -to top.sw[1]
# Map the extra pin you provided to the reset input
set_location_assignment PIN_AC27 -to top.rst

# System clock
set_location_assignment PIN_Y2   -to top.clk

# End of pins.tcl
