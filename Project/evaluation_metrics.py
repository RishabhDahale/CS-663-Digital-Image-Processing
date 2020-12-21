# -*- coding: utf-8 -*-
"""
Created on Sat Dec  5 22:14:57 2020

@author: shyam
"""

import numpy as np
import matplotlib.pyplot as plt
import json

THRESHOLD = 0.01


def evaluation_metrics(labels, preds):
    imposter_attempts = np.count_nonzero(labels == -1)
    genuine_attempts = len(labels) - imposter_attempts
    
    fp = 0
    fn = 0
    correct = 0
    mismatch = 0
    for i in range(len(labels)):
        if labels[i] == preds[i]:
            correct += 1
        elif labels[i] == -1 and preds[i] != -1:
            fp += 1
        elif labels[i] != -1 and preds[i] == -1:
            fn += 1
        elif labels[i] != preds[i]:
            mismatch += 1
    
    # try:
    # print(fp)
    # print(imposter_attempts) 
    fmr = fp/imposter_attempts
    # except:
        # fmr = 0
    fnmr = (mismatch+fn)/genuine_attempts
    return fmr, fnmr


with open("result-same-same.json", "r+") as infile:
    resultsSame = json.load(infile)

with open("result-different.json", "r+") as infile:
    resultsDiff = json.load(infile)


fmrs = []
fnmrs = []

for THRESHOLD in np.linspace(0, 0.05, 100):
    labels = []
    preds = []

    for p, vals in resultsSame.items():
        v = np.array(vals)
        v = v >= THRESHOLD
        labels.extend(list([int(p[1:])]*len(v)))
        preds.extend(list(
            (v*(int(p[1:])+1))-1
            ))


    for p, vals in resultsDiff.items():
        v = np.array(vals)
        v = v >= THRESHOLD
        labels.extend([-1]*len(v))
        preds.extend(list(
            (v*(int(p[1:])+1))-1
            ))

    # print(labels)

    fmr, fnmr = evaluation_metrics(np.array(labels), np.array(preds))
    fmrs.append(fmr)
    fnmrs.append(fnmrs)
    print(THRESHOLD, fmr, fnmr)


# plt.plot(np.linspace(0, 0.05, 100), fmrs, label="FMR")
# plt.plot(np.linspace(0, 0.05, 100), fnmrs, label="FNMR")
# plt.legend(loc="best")
# plt.title("FMR and FNMR")
# plt.savefig("FMR and FNMR.png")
# plt.clf()

plt.plot(np.linspace(0, 0.05, 100), fnmrs, label="FNMR")
plt.title("FNMR")
plt.show()

# print(labels)
# print(preds)

# labels = [1, 2, 3, -1, 2, 3, 1]
# preds =  [1, 2, 2, 1, 2, -1, 1]

    
