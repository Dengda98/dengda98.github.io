#!/bin/bash

# 这里仅验证频散结果和计算的面波波形

set -euo pipefail

echo "Compute dispersion"
grt eigenv -M../milrow -SR -F0/1/0.01 -N -Cphase_milrow_R.nc
grt eigenv -M../thin1  -SR -F0/100/0.1 -N -Cphase_thin1_R.nc
grt eigenv -M../seafloor2 -SR -F0/2/0.01 -N -Cphase_seafloor2_R.nc

grt eigenv -M../milrow -SL -F0/1/0.01 -N -Cphase_milrow_L.nc
grt eigenv -M../thin1  -SL -F0/100/0.1 -N -Cphase_thin1_L.nc
grt eigenv -M../seafloor2 -SL -F0/2/0.01 -N -Cphase_seafloor2_L.nc

python compare_disp.py "phase_milrow_R.nc"  "_Ref/phase_milrow_R.nc"
python compare_disp.py "phase_thin1_R.nc"  "_Ref/phase_thin1_R.nc"
python compare_disp.py "phase_seafloor2_R.nc"  "_Ref/phase_seafloor2_R.nc"
python compare_disp.py "phase_milrow_L.nc"  "_Ref/phase_milrow_L.nc"
python compare_disp.py "phase_thin1_L.nc"  "_Ref/phase_thin1_L.nc"
python compare_disp.py "phase_seafloor2_L.nc"  "_Ref/phase_seafloor2_L.nc"

# 由于芯片架构差异，ubuntu上计算的结果和mac会有细微差别，因此这里仅比较基阶波形，方便测试
echo "Compute Surface wave"
grt modsum -Cphase_milrow_R.nc -D2/0.2 -R100 -N0 -OGRN_milrow -W5 -e
grt modsum -Cphase_milrow_L.nc -D2/0.2 -R100 -N0 -OGRN_milrow -W5 -e
grt modsum -Cphase_thin1_R.nc -D0.02/0.01 -R0.8 -N0 -OGRN_thin1 -W5 -e
grt modsum -Cphase_thin1_L.nc -D0.02/0.01 -R0.8 -N0 -OGRN_thin1 -W5 -e

grt modsum -Cphase_seafloor2_R.nc -D7/4.01 -R50 -N0 -OGRN_seafloor2 -W5 -e
grt modsum -Cphase_seafloor2_L.nc -D7/4.01 -R50 -N0 -OGRN_seafloor2 -W5 -e

# python ../compare_sac.py  "GRN_milrow/*/*.sac"  "_Ref/GRN_milrow/*/*.sac"
# python ../compare_sac.py  "GRN_thin1/*/*.sac"  "_Ref/GRN_thin1/*/*.sac"
# python ../compare_sac.py  "GRN_seafloor2/*/*.sac"  "_Ref/GRN_seafloor2/*/*.sac"

# rm -rf *.nc
# rm -rf GRN*