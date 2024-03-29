KICAD = /Applications/KiCad/KiCad.app/Contents/MacOS/kicad-cli
LAYERS = F.Cu,In1.Cu,In2.Cu,B.Cu,F.Paste,F.SilkS,B.SilkS,F.Mask,B.Mask,Edge.Cuts

PYTHON = python3
BOM_SCRIPT =  ../GW_KiCADBuild/export_bom.py

F_PCB = $@/../WarpSE.kicad_pcb
F_SCH = $@/../WarpSE.kicad_sch
F_NETLIST = $@/WarpSE-NET.xml
F_BOM = $@/WarpSE-BOM.csv
F_POS = $@/WarpSE-top-pos.csv
F_ZIP = $@/WarpSE.4410A-gerber.zip
F_STENCIL = gerber/WarpSE.4410A-stencil.zip
F_SCHPDF = $@/WarpSE.4410A-Schematic.pdf
F_PCBPDF = $@/WarpSE.4410A-Placement.pdf


OPT_GERBER = -l $(LAYERS) --subtract-soldermask --no-netlist --no-x2
CMD_GERBER = pcb export gerbers $(OPT_GERBER) -o $@/ $(F_PCB)

CMD_DRILL = pcb export drill -o $@/ $(F_PCB)

CMD_NETLIST = sch export netlist --format kicadxml -o $(F_NETLIST) $(F_SCH)

OPT_POS = --smd-only --units mm --side front --format csv
CMD_POS = pcb export pos $(OPT_POS) -o $(F_POS) $(F_PCB)

CMD_SCHPDF = sch export pdf --black-and-white --no-background-color -o $(F_SCHPDF) $(F_SCH)
CMD_PCBPDF = pcb export pdf --black-and-white -l F.Fab,Edge.Cuts -o $(F_PCBPDF) $(F_PCB)


.PHONY: all clean gerber stencil Documentation rom
all: gerber stencil Documentation rom
clean:
	rm -fr gerber/
	rm -fr rom/
	rm -f  Documentation/WarpSE.4410A-Schematic.pdf
	rm -f  Documentation/WarpSE.4410A-Placement.pdf

gerber:
	mkdir -p $@
	$(KICAD) $(CMD_GERBER)
	$(KICAD) $(CMD_DRILL)
	$(KICAD) $(CMD_POS)
	$(KICAD) $(CMD_NETLIST)
	sed -i '' 's/PosX/MidX/g' $(F_POS)
	sed -i '' 's/PosY/MidY/g' $(F_POS)
	sed -i '' 's/Rot/Rotation/g' $(F_POS)
	$(PYTHON) $(BOM_SCRIPT) $(F_NETLIST) $(F_BOM)
	rm -f $(F_ZIP)
	zip -r $(F_ZIP) $@/

stencil: gerber
	zip $(F_STENCIL) -xi gerber/WarpSE-F_Paste.gtp

Documentation:
	mkdir -p $@
	$(KICAD) $(CMD_SCHPDF)
	$(KICAD) $(CMD_PCBPDF)

rom:
	rm -fr rom/
	mkdir -p $@
	mkdir -p $@/build
	mkdir -p $@/bin
	../romtools/bin/bytesplit romsrc/se.bin 2 rom/build/warpse_1508_preswap.bin rom/build/warpse_0700_preswap.bin
	../romtools/bin/romswap 11,9,8,13,0,1,14,17,2,3,18,10,12,7,6,5,15,4,16 7,6,5,4,3,2,1,0 rom/build/warpse_1508_preswap.bin rom/bin/warpse_1508.bin
	../romtools/bin/romswap 14,13,8,9,18,15,11,10,12,7,16,17,0,1,2,3,4,5,6 7,6,5,4,3,2,1,0 rom/build/warpse_0700_preswap.bin rom/bin/warpse_0700.bin
