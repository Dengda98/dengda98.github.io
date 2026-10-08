#!/bin/bash
# Check the correctness

set -euo pipefail

rm -rf *.nc

# static greenfn
# 波数积分相关参数进行固定，这里验证结果更多的是为了核对 GRT 矩阵方面有没有计算错误
# 当然至少要保证积分收敛
# 仍用 -X/-Y 建二维库，使 syn 默认网格与 _Ref 一致（输出 nc 现为 4D：depsrc×deprcv×north×east）
# grt static greenfn -M../milrow -D2/3 -R0/6/0.2 -e -Ostgrn.nc
grt static greenfn -M../milrow -D2/3 -X-3.1/3.1/0.2 -Y-2.1/2.1/0.2 -e -Ostgrn.nc -Cn -K+k20+f  # 固定kmax，仅作测试

# syn（单深度库不必设 -Ds/-Dr，默认沿用库的 north/east 网格）
grt static syn -S1e20 -e -Gstgrn.nc -Ostsyn_ex.nc
grt static syn -S1e20 -e -F2/-1/4    -Gstgrn.nc -Ostsyn_sf.nc
grt static syn -S1e20 -e -M77/88/111 -Gstgrn.nc -Ostsyn_dc.nc
grt static syn -S1e20 -e -M77/88 -Gstgrn.nc -Ostsyn_ts.nc
grt static syn -S1e20 -e -T1/-2/-5/0.5/3/1.2 -X-3.1/3.1/0.4 -Y-2.1/2.1/0.4 -Gstgrn.nc -Ostsyn_mt_xy.nc # new XY grid
grt static syn -S1e20 -e -T1/-2/-5/0.5/3/1.2 -Gstgrn.nc -Ostsyn_mt.nc

# rotate to ZNE
grt static syn -S1e20 -e -T1/-2/-5/0.5/3/1.2 -N -Gstgrn.nc -Ostsyn_mt_ZNE.nc

# strain, stress, rotation
grt static strain stsyn_dc.nc
grt static stress stsyn_dc.nc
grt static rotation stsyn_dc.nc

grt static strain stsyn_mt_ZNE.nc
grt static stress stsyn_mt_ZNE.nc
grt static rotation stsyn_mt_ZNE.nc



python ../compare_nc.py stgrn.nc _Ref/stgrn.nc
python ../compare_nc.py stsyn_ex.nc _Ref/stsyn_ex.nc
python ../compare_nc.py stsyn_sf.nc _Ref/stsyn_sf.nc
python ../compare_nc.py stsyn_dc.nc _Ref/stsyn_dc.nc
python ../compare_nc.py stsyn_ts.nc _Ref/stsyn_ts.nc
python ../compare_nc.py stsyn_mt.nc _Ref/stsyn_mt.nc
python ../compare_nc.py stsyn_mt_ZNE.nc _Ref/stsyn_mt_ZNE.nc

rm -rf *.nc
