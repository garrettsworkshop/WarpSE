rm -fr rombuild
rm -fr rom
mkdir -p rombuild
mkdir -p rom
../romtools/bin/bytesplit romsrc/se.bin 2 rombuild/warpse_0815_preswap.bin rombuild/warpse_0007_preswap.bin
../romtools/bin/romswap 14,13,8,9,18,15,11,10,12,7,16,17,0,1,2,3,4,5,6 7,6,5,4,3,2,1,0 rombuild/warpse_0007_preswap.bin rom/warpse_0007.bin
../romtools/bin/romswap 11,9,8,13,0,1,14,17,2,3,18,10,12,7,6,5,15,4,16 7,6,5,4,3,2,1,0 rombuild/warpse_0815_preswap.bin rom/warpse_0815.bin
