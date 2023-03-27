.PHONY: bin

all: bin/warpse_0700.bin bin/warpse_1508.bin

bin:
	mkdir -p bin 

clean:
	rm -fr bin

bin/warpse_1508_preswap.bin: bin se.bin
	rm -f bin/warpse_1508_preswap.bin
	rm -f bin/warpse_0700_preswap.bin
	../../romtools/bin/bytesplit se.bin 2 bin/warpse_1508_preswap.bin bin/warpse_0700_preswap.bin

bin/warpse_0700_preswap.bin: bin se.bin bin/warpse_1508_preswap.bin

bin/warpse_1508.bin: bin/warpse_1508_preswap.bin
	../../romtools/bin/romswap 11,9,8,13,0,1,14,17,2,3,18,10,12,7,6,5,15,4,16 7,6,5,4,3,2,1,0 bin/warpse_1508_preswap.bin $@

bin/warpse_0700.bin: bin/warpse_0700_preswap.bin
	../../romtools/bin/romswap 14,13,8,9,18,15,11,10,12,7,16,17,0,1,2,3,4,5,6 7,6,5,4,3,2,1,0 bin/warpse_0700_preswap.bin $@
