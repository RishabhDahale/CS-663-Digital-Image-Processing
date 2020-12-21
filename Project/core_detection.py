import cv2
import scipy
import matplotlib.pyplot as plt
import numpy as np
import copy
import pandas as pd


i_max = 255


def direction_count(im):  # 16x16 block
    type1_cases = [np.array([[i_max, i_max], [0, 0]], np.uint8), np.array([[0, 0], [i_max, i_max]], np.uint8)]
    type2_cases = [np.array([[i_max, i_max], [i_max, 0]], np.uint8), np.array([[0, i_max], [i_max, i_max]], np.uint8),
                   np.array([[0, 0], [0, i_max]], np.uint8), np.array([[i_max, 0], [0, 0]], np.uint8)]
    type3_cases = [np.array([[i_max, 0], [i_max, 0]], np.uint8), np.array([[0, i_max], [0, i_max]], np.uint8)]
    type4_cases = [np.array([[i_max, i_max], [0, i_max]], np.uint8), np.array([[i_max, 0], [i_max, i_max]], np.uint8),
                   np.array([[0, 0], [i_max, 0]], np.uint8), np.array([[0, i_max], [0, 0]], np.uint8)]
    type5_cases = [np.array([[i_max, 0], [0, i_max]], np.uint8), np.array([[0, i_max], [i_max, 0]], np.uint8)]

    type1_count = 0
    type2_count = 0
    type3_count = 0
    type4_count = 0
    type5_count = 0
    L1, L2 = im.shape
    for i in range(L1):
        for j in range(L2):
            found = False
            for x in type1_cases:
                if np.array_equal(im[i:i + 2, j:j + 2], x) == True:
                    type1_count += 1
                    found = True
                    break
            if found == True:
                continue
            for x in type2_cases:
                if np.array_equal(im[i:i + 2, j:j + 2], x) == True:
                    type2_count += 1
                    found = True
                    break
            if found == True:
                continue
            for x in type3_cases:
                if np.array_equal(im[i:i + 2, j:j + 2], x) == True:
                    type3_count += 1
                    found = True
                    break
            if found == True:
                continue
            for x in type4_cases:
                if np.array_equal(im[i:i + 2, j:j + 2], x) == True:
                    type4_count += 1
                    found = True
                    break
            if found == True:
                continue
            for x in type5_cases:
                if np.array_equal(im[i:i + 2, j:j + 2], x) == True:
                    type5_count += 1
                    found = True
                    break
            if found == True:
                continue
    type2_count += type5_count
    type4_count += type5_count
    type2_count /= np.sqrt(2)
    type4_count /= np.sqrt(2)

    res = [type1_count, type2_count, type3_count, type4_count]
    if sum(res) == 0:
        return res
    return [i / sum(res) for i in res]


def create_direction_pattern(im, block_size):
    Mmax, Nmax = im.shape
    dir_patt = np.zeros((int(Mmax / block_size), int(Nmax / block_size), 4))
    for i in range(0, Mmax, block_size):
        for j in range(0, Nmax, block_size):
            im_slice = im[i:i + block_size, j:j + block_size]
            dir_patt[int(i / block_size)][int(j / block_size)] = direction_count(im_slice)
    return dir_patt


def compatibility(i, j):
    if i == j:
        return 1
    if i == 0 and j == 2:
        return -1
    if i == 1 and j == 3:
        return -1
    return 0


def eight_neighbours(i, j, Mmax, Nmax):
    i_val = set([max(0, i - 1), i, min(i + 1, Mmax - 1)])
    j_val = set([max(0, j - 1), j, min(j + 1, Nmax - 1)])
    return i_val, j_val


def relaxation(dir_patt):
    L1, L2, L3 = dir_patt.shape
    dir_patt_new = np.zeros_like(dir_patt)
    for z in range(3):
        for i in range(L1):
            for j in range(L2):
                # find neighbours N(x)
                i_val, j_val = eight_neighbours(i, j, L1, L2)
                q = np.zeros(L3)
                for x1 in i_val:
                    for y1 in j_val:
                        for r in range(L3):
                            for r_prime in range(L3):
                                q[r] += compatibility(r, r_prime) * dir_patt[x1][y1][r_prime]
                for r in range(L3):
                    q[r] -= dir_patt[i][j][r]
                den = 0
                for r in range(L3):
                    den += (1 + q[r]) * dir_patt[i][j][r]
                if den == 0:
                    continue
                for r in range(L3):
                    dir_patt_new[i][j][r] = (1 + q[r]) * dir_patt[i][j][r] / den
        dir_patt = copy.deepcopy(dir_patt_new)
    return dir_patt_new


def create_TU_pattern(dir_patt):
    L1, L2, L3 = dir_patt.shape
    t = np.zeros((L1, L2))
    u = np.zeros((L1, L2))
    for i in range(L1):
        for j in range(L2):
            t[i][j] = dir_patt[i][j][1] - dir_patt[i][j][3]
            u[i][j] = dir_patt[i][j][0] - dir_patt[i][j][2]
    return t, u


def get_code(t, u):
    if t > 0.1:
        return '+'
    elif -0.1 < t < 0.1:
        if u > 0:
            return '0+'
        else:
            return '0-'
    else:
        return '-'


def apply_rules(code):
    reduced_code = []
    flag = True
    for i in range(len(code) - 1):
        if code[i] not in ['0+', '0-']:
            reduced_code.append(code[i])
        elif code[i] == '0+' and code[i + 1] == '0-':
            reduced_code.append('+')
            flag = False
        elif code[i] == '0-' and code[i + 1] == '0+':
            reduced_code.append('-')
            flag = False
        else:
            if flag:
                reduced_code.append(code[i])
            else:
                flag = True
    reduced_code = [x for x in reduced_code if (x != '0+') and (x != '0-')]
    if reduced_code == []:
        return ['+']
    final_code = [reduced_code[0]]
    for i in range(1, len(reduced_code)):
        if reduced_code[i - 1] != reduced_code[i]:
            final_code.append(reduced_code[i])
    return final_code


def encode(T, U):
    I = [0, 0, 0, 1, 2, 2, 2, 1]
    J = [0, 1, 2, 2, 2, 1, 0, 0]
    code = []
    for k in range(len(I)):
        res = get_code(T[I[k], J[k]], U[I[k], J[k]])
        code.append(res)
    code = apply_rules(code)
    return code


def find_core(T, U):
    side_len = T.shape[0]
    singularity = np.zeros_like(T)
    for i in range(1, side_len - 1):
        for j in range(1, side_len - 1):
            code = encode(T[i - 1:i + 2, j - 1:j + 2], U[i - 1:i + 2, j - 1:j + 2])
            if code == ['+', '-']:
                singularity[i, j] = 1
    return singularity


def trimmed(im1, i_max=255):
    im1_neg = i_max - im1
    im1_neg_rowsum = np.sum(im1_neg, axis=1)
    i1 = 0
    i2 = im1.shape[0] - 1
    while im1_neg_rowsum[i1] == 0 and i1 < im1.shape[0]:
        i1 += 1
    while im1_neg_rowsum[i2] == 0 and i2 >= 0:
        i2 -= 1
    im1_neg_colsum = np.sum(im1_neg, axis=0)
    j1 = 0
    j2 = im1.shape[1] - 1
    while im1_neg_colsum[j1] == 0 and j1 < im1.shape[1]:
        j1 += 1
    while im1_neg_colsum[j2] == 0 and j2 >= 0:
        j2 -= 1
    return i1, i2, j1, j2


def common_region(im_a, im_b, i_max=255):
    ai1, ai2, aj1, aj2 = trimmed(im_a, i_max)
    bi1, bi2, bj1, bj2 = trimmed(im_b, i_max)
    return max(ai1, bi1), min(ai2, bi2), max(aj1, bj1), min(aj2, bj2)
