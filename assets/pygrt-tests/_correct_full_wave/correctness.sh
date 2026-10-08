#!/bin/bash
# Check the correctness

set -euo pipefail

rm -rf GRN GRN_milrow GRN_killari GRN_thin1 GRN_seafloor
rm -rf syn_*

# =========================================
# greenfn
# 波数积分相关参数进行固定，这里验证结果更多的是为了核对 GRT 矩阵方面有没有计算错误
# 当然至少要保证积分收敛
grt greenfn -M../milrow  -D2/3 -N600/0.02 -R10    -e -OGRN_milrow -s -Cn -K+k20+s2+f
grt greenfn -M../killari -D3/0 -N300/0.01 -R3     -e -OGRN_killari -s -Cn -K+k20+s1.15+f
grt greenfn -M../thin1   -D0.015/0 -N700/0.02 -R1 -e -OGRN_thin1 -s -Cn -K+k300+s2+f
# liquid model
grt greenfn -M../seafloor -D5/1.1 -N500/0.4+a -R100 -e -OGRN_seafloor -s -Cn -K+k20+s1.15+f

python ../compare_sac.py  "GRN_milrow/milrow_2_3_10/*"  "_Ref/milrow_2_3_10/*"
python ../compare_sac.py  "GRN_killari/killari_3_0_3/*"  "_Ref/killari_3_0_3/*"
python ../compare_sac.py  "GRN_thin1/thin1_0.015_0_1/*"    "_Ref/thin1_0.015_0_1/*"
python ../compare_sac.py  "GRN_seafloor/seafloor_5_1.1_100/*"    "_Ref/seafloor_5_1.1_100/*"

# =========================================
# syn
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -Dt/0.2/0/0.2 -e -Osyn_ex
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -F2/-1/4 -Dt/0.1/0.2/0.3 -e -Osyn_sf
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -M77/88/111 -Dp/0.6 -e -Osyn_dc
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -M77/88 -Dp/0.6 -e -Osyn_ts
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -T1/-2/-5/0.5/3/1.2 -Dr/3 -e -Osyn_mt

# also check the time functions
python ../compare_sac.py  "syn_ex/*"  "_Ref/syn_ex/*"
python ../compare_sac.py  "syn_sf/*"  "_Ref/syn_sf/*"
python ../compare_sac.py  "syn_dc/*"  "_Ref/syn_dc/*"
python ../compare_sac.py  "syn_ts/*"  "_Ref/syn_ts/*"
python ../compare_sac.py  "syn_mt/*"  "_Ref/syn_mt/*"

# rotate to ZNE
grt syn -GGRN_milrow/milrow_2_3_10 -A22 -S1e20 -T1/-2/-5/0.5/3/1.2 -Dr/3 -e -N -Osyn_mt_ZNE

python ../compare_sac.py  "syn_mt_ZNE/*"  "_Ref/syn_mt_ZNE/*"


# ===========================================
# strain, stress, rotation
grt strain -Gsyn_dc
grt stress -Gsyn_dc
grt rotation -Gsyn_dc

python ../compare_sac.py  "syn_dc/stress_*"  "_Ref/syn_dc2/stress_*"
python ../compare_sac.py  "syn_dc/strain_*"  "_Ref/syn_dc2/strain_*"
python ../compare_sac.py  "syn_dc/rotation_*"  "_Ref/syn_dc2/rotation_*"

grt strain -Gsyn_mt_ZNE
grt stress -Gsyn_mt_ZNE
grt rotation -Gsyn_mt_ZNE

python ../compare_sac.py  "syn_mt_ZNE/stress_*"  "_Ref/syn_mt2_ZNE/stress_*"
python ../compare_sac.py  "syn_mt_ZNE/strain_*"  "_Ref/syn_mt2_ZNE/strain_*"
python ../compare_sac.py  "syn_mt_ZNE/rotation_*"  "_Ref/syn_mt2_ZNE/rotation_*"

rm -rf GRN GRN_milrow GRN_killari GRN_thin1 GRN_seafloor
rm -rf syn_*
