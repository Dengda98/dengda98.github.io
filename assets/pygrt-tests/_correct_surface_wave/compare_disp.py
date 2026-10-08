""" Compare two nc files """

import sys
import numpy as np
from scipy.io import netcdf_file

ncpath1 = sys.argv[1]
ncpath2 = sys.argv[2]

tol = 0.01
errLst = []

with netcdf_file(ncpath1, mmap=False) as f1, netcdf_file(ncpath2, mmap=False) as f2:
    # compare keys
    keys1 = set(f1.variables.keys())
    keys2 = set(f2.variables.keys())

    if keys1 != keys2:
        raise ValueError(f"Different keys in {ncpath1} and {ncpath2}")

    if f1.dimensions['freq'] != f2.dimensions['freq']:
        raise ValueError(f"freq not equal.")

    if f1.dimensions['mode'] != f2.dimensions['mode']:
        raise ValueError(f"mode not equal.")

    # same number of roots
    if np.any(f1.variables['cnum'][:] != f2.variables['cnum'][:]):
        raise ValueError("root-missing!")

    # compare dispersion
    err = np.sum(np.abs(f1.variables['c'][:] - f2.variables['c'][:])) / np.mean(np.abs(f1.variables['c'][:]))
    errLst.append(err)
    if err > tol:
        print(f"Error({err}) > {tol} from dispersion in {ncpath1} and {ncpath2}")

errLst = np.array(errLst)

print('-'*100)
print(ncpath1, ncpath2)
print(errLst)
print('-'*100)
if np.any(errLst > tol):
    raise ValueError(f"Error!!")