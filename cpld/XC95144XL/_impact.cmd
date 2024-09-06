setMode -bs
setMode -bs
setMode -bs
setMode -bs
setCable -port svf -file "Z:/Repos/WarpSE/cpld/XC95144XL/WarpSE.svf"
addDevice -p 1 -file "Z:/Repos/WarpSE/cpld/XC95144XL/WarpSE.jed"
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
saveProjectFile -file "\auto_project.ipf"
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
saveProjectFile -file "\auto_project.ipf"
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
