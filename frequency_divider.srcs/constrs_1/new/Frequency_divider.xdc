# ZYBO Pin Assignments
###################################
# On-board 125MHz external clock  #
##################################
set_property PACKAGE_PIN L16 [get_ports Clock_in]
set_property IOSTANDARD LVCMOS33 [get_ports Clock_in]


############################
# On-board led             #
############################
set_property PACKAGE_PIN G14 [get_ports Clock_5Hz]
set_property IOSTANDARD LVCMOS33 [get_ports Clock_5Hz]
set_property PACKAGE_PIN D18 [get_ports Clock_2Hz]
set_property IOSTANDARD LVCMOS33 [get_ports Clock_2Hz]

############################
# On-board push buttons    #
############################

set_property PACKAGE_PIN R18 [get_ports Reset]
set_property IOSTANDARD LVCMOS33 [get_ports Reset]




