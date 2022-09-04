# ZYBO Pin Assignments
###################################
# On-board 125MHz external clock  #
##################################
set_property PACKAGE_PIN L16 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

############################
# Oled pins #
############################
set_property IOSTANDARD LVCMOS33 [get_ports VDD]
set_property IOSTANDARD LVCMOS33 [get_ports VBAT]
set_property IOSTANDARD LVCMOS33 [get_ports SDO]
set_property IOSTANDARD LVCMOS33 [get_ports SCLK]
set_property IOSTANDARD LVCMOS33 [get_ports CS]
set_property IOSTANDARD LVCMOS33 [get_ports DC]
set_property IOSTANDARD LVCMOS33 [get_ports RES]
set_property PACKAGE_PIN N15 [get_ports CS]
set_property PACKAGE_PIN N16 [get_ports DC]
set_property PACKAGE_PIN L15 [get_ports RES]
set_property PACKAGE_PIN K14 [get_ports SCLK]
set_property PACKAGE_PIN L14 [get_ports SDO]
set_property PACKAGE_PIN J16 [get_ports VBAT]
set_property PACKAGE_PIN J14 [get_ports VDD]



############################
# On-board Slide Switches  #
############################
set_property PACKAGE_PIN G15 [get_ports sw[0]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[0]]
set_property PACKAGE_PIN P15 [get_ports sw[1]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[1]]
set_property PACKAGE_PIN W13 [get_ports sw[2]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[2]]
set_property PACKAGE_PIN T16 [get_ports sw[3]]
set_property IOSTANDARD LVCMOS33 [get_ports sw[3]]

############################
# On-board led             #
############################
set_property PACKAGE_PIN M14 [get_ports led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property PACKAGE_PIN M15 [get_ports led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property PACKAGE_PIN G14 [get_ports led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property PACKAGE_PIN D18 [get_ports led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led[3]]

############################
# On-board push buttons    #
############################
set_property PACKAGE_PIN R18 [get_ports pb[0]]
set_property IOSTANDARD LVCMOS33 [get_ports pb[0]]
set_property PACKAGE_PIN P16 [get_ports pb[1]]
set_property IOSTANDARD LVCMOS33 [get_ports pb[1]]
set_property PACKAGE_PIN V16 [get_ports pb[2]]
set_property IOSTANDARD LVCMOS33 [get_ports pb[2]]
set_property PACKAGE_PIN Y16 [get_ports pb[3]]
set_property IOSTANDARD LVCMOS33 [get_ports pb[3]]