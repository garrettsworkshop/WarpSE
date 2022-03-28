setMode -bs
setMode -bs
setMode -bs
setMode -bs
setCable -port svf -file "//192.168.64.1/Repos/Warp-SE/cpld/XC95144XL/MXSE.svf"
addDevice -p 1 -file "//192.168.64.1/Repos/Warp-SE/cpld/XC95144XL/MXSE.jed"
Erase -p 1 
Program -p 1 -e -v 
setMode -bs
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
saveProjectFile -file "\\192.168.64.1\Repos\Warp-SE\cpld\\auto_project.ipf"
setMode -bs
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
setMode -bs
saveProjectFile -file "\\192.168.64.1\Repos\Warp-SE\cpld\\auto_project.ipf"
setMode -bs
setMode -bs
deleteDevice -position 1
setMode -bs
setMode -ss
setMode -sm
setMode -hw140
setMode -spi
setMode -acecf
setMode -acempm
setMode -pff
