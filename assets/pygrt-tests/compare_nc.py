""" Compare two nc files """

import sys
import numpy as np
from scipy.io import netcdf_file

# Newer STGRNLIB files are 4D (depsrc x deprcv x north x east) and store
# model / medium as variables. Older refs used 2D fields and attributes.
SKIP_VARS = {
    "depsrc", "deprcv", "model",
    "src_va", "src_vb", "src_rho",
    "rcv_va", "rcv_vb", "rcv_rho",
}

ncpath1 = sys.argv[1]
ncpath2 = sys.argv[2]

tol = 0.05
errLst = []

with netcdf_file(ncpath1, mmap=False) as f1, netcdf_file(ncpath2, mmap=False) as f2:
    keys1 = set(f1.variables.keys()) - SKIP_VARS
    keys2 = set(f2.variables.keys()) - SKIP_VARS

    if keys1 != keys2:
        raise ValueError(f"Different keys in {ncpath1} and {ncpath2}: {keys1 ^ keys2}")

    for k in sorted(keys1):
        arr1 = np.squeeze(np.asarray(f1.variables[k][:], dtype=float))
        arr2 = np.squeeze(np.asarray(f2.variables[k][:], dtype=float))

        if arr1.shape != arr2.shape:
            raise ValueError(
                f"Shape mismatch on '{k}' in {ncpath1} and {ncpath2}: {arr1.shape} vs {arr2.shape}"
            )

        if np.all(arr1 == 0.0) and np.all(arr2 == 0.0):
            errLst.append(0.0)
            continue

        err = np.sum(np.abs(arr1 - arr2)) / np.mean(np.abs(arr1))
        errLst.append(err)
        if err > tol:
            print(f"Error({err}) > {tol} from keys={k} in {ncpath1} and {ncpath2}")

errLst = np.array(errLst)

print('-'*100)
print(ncpath1, ncpath2)
print(errLst)
print('-'*100)
if np.any(errLst > tol):
    raise ValueError(f"Error!!")
