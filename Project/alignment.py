import numpy as np
import cv2
import math
from mpl_toolkits.mplot3d import Axes3D
import scipy.ndimage
import matplotlib.pyplot as plt
from numpy import unravel_index
# from findpeaks import findpeaks


def BLPOC(dft1, dft2, band=[100, 100]):
    xBL = band[0];
    yBL = band[1]
    df1 = np.zeros_like(dft1)
    df2 = np.zeros_like(dft2)
    df1x, df1y = df1.shape
    df2x, df2y = df2.shape
    df1[df1x // 2 - xBL:df1x // 2 + xBL, df1y // 2 - yBL:df1y // 2 + yBL] = dft1[df1x // 2 - xBL:df1x // 2 + xBL,
                                                                            df1y // 2 - yBL:df1y // 2 + yBL]
    df2[df2x // 2 - xBL:df2x // 2 + xBL, df2y // 2 - yBL:df2y // 2 + yBL] = dft2[df2x // 2 - xBL:df2x // 2 + xBL,
                                                                            df2y // 2 - yBL:df2y // 2 + yBL]
    dft1 = df1
    dft2 = df2
    for i in range(dft1.shape[0]):
        for j in range(dft1.shape[1]):
            if dft1[i][j] != 0:
                dft1[i][j] = dft1[i][j] / abs(dft1[i][j])
            if dft2[i][j] != 0:
                dft2[i][j] = np.conjugate(dft2[i][j]) / abs(dft2[i][j])
    return np.fft.ifft2(np.fft.ifftshift(dft1 * dft2))


def CheckPeak(blpoc):
    peak = np.max(abs(blpoc))
    thresh = peak * 0.85
    above = np.sum(abs(blpoc) > thresh)
    if above > 1:
        return None
    else:
        return unravel_index(abs(blpoc).argmax(), blpoc.shape)



def RotationAlign(img1, img2):
    dft2 = np.fft.fftshift(np.fft.fft2(img2))
    values = []
    for theta in range(-40, 41):
        # print(theta)
        temp = scipy.ndimage.rotate(img1, theta, reshape=False)
        blpoc = BLPOC(np.fft.fftshift(np.fft.fft2(temp)), dft2)
        loc = CheckPeak(blpoc)
        if loc is not None:
            values.append((theta, abs(blpoc[loc[0]][loc[1]]), loc))
    try:
        thetaMax = max(values, key=lambda val: val[1])
        return scipy.ndimage.rotate(img1, thetaMax[0], reshape=False), img2, thetaMax[2]
    except:
        return img1, img2, None


def RotationAlignFine(img1, img2):
    dft2 = np.fft.fftshift(np.fft.fft2(img2))
    values = []
    for theta in [-2, -1.5, -1, -0.5, 0, 0.5, 1, 1.5, 2]:
        # print(theta)
        temp = scipy.ndimage.rotate(img1, theta, reshape=False)
        blpoc = BLPOC(np.fft.fftshift(np.fft.fft2(temp)), dft2)
        loc = CheckPeak(blpoc)
        if loc is not None:
            values.append((theta, abs(blpoc[loc[0]][loc[1]]), loc))
    try:
        thetaMax = max(values, key=lambda val: val[1])
        return scipy.ndimage.rotate(img1, thetaMax[0], reshape=False), img2, thetaMax[2]
    except:
        return img1, img2, None


def TranslationWithCoreAlign(img1c1, img2c1, dft1, dft2):
    # DFT1
    xTrans = (img1c1[0] * 16) + 8
    yTrans = (img1c1[1] * 16) + 8
    for i in range(dft1.shape[0]):
        for j in range(dft1.shape[1]):
            dft1[i][j] = dft1[i][j] * complex(math.cos(1 * (i * xTrans + j * yTrans)),
                                              math.sin(1 * (i * xTrans + j * yTrans)))
            dft1[i][j] = dft1[i][j] * complex(math.cos(-1 * (i * (dft1.shape[0] / 2) + j * (dft1.shape[1] / 2))),
                                              math.sin(-1 * (i * (dft1.shape[0] / 2) + j * (dft1.shape[1] / 2))))

    # DFT2
    xTrans = (img2c1[0] * 16) + 8
    yTrans = (img2c1[1] * 16) + 8
    for i in range(dft2.shape[0]):
        for j in range(dft2.shape[1]):
            dft2[i][j] = dft2[i][j] * complex(math.cos(1 * (i * xTrans + j * yTrans)),
                                              math.sin(1 * (i * xTrans + j * yTrans)))
            dft2[i][j] = dft2[i][j] * complex(math.cos(-1 * (i * (dft2.shape[0] / 2) + j * (dft2.shape[1] / 2))),
                                              math.sin(-1 * (i * (dft2.shape[0] / 2) + j * (dft2.shape[1] / 2))))
    return dft1, dft2


def TranslationWithoutCoreAlign(img1, img2, shift):
    if shift is not None:
        s = list(shift)
        if shift[0] > 256:
            s[0] = shift[0] - 512
        if shift[1] > 256:
            s[1] = shift[1] - 512
        s = [s[0]*-1, s[1]*-1]
        img1 = scipy.ndimage.shift(img1, s)
    return img1, img2


# input img1c1 = (i, j), img1c2, img2c1, img2c2, all_core_present
def AlignFingerPrint(img1, img2, img1c1=(0, 0), img2c1=(0, 0), all_core=False):
    dft1, dft2 = np.fft.fftshift(np.fft.fft2(img1)), np.fft.fftshift(np.fft.fft2(img2))
    if all_core:
        dft1, dft2 = TranslationWithCoreAlign(img1c1, img2c1, dft1, dft2)
        dft1, dft2, _, _ = RotationAlign(dft1, dft2)
    else:
        # print("Outside jugaad")
        imgR1, imgR2, shift = RotationAlign(img1, img2)
        imgFix1, imgFix2 = TranslationWithoutCoreAlign(imgR1, imgR2, shift)
    return imgFix1, imgFix2


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


def basBauhutHogaya(img1):
    i1, i2, j1, j2 = trimmed(255 - img1)
    return cv2.resize(img1[i1:i2, j1:j2].astype(np.float), (512, 512))


def basBauhutHogayaReturns(img1, img2):
    i11, i21, j11, j21 = trimmed(255 - img1)
    i12, i22, j12, j22 = trimmed(255 - img2)
    i1 = (i11+i21)/2 - (i12+i22)/2
    j1 = (j11+j21)/2 - (j12+j22)/2
    return scipy.ndimage.shift(img1, (-1*i1, -1*j1)), img2


def Predict(img1, img2):
    img1 = cv2.resize(img1, (512, 512))
    img1 = 255 * (img1 > np.mean(img1))
    # plt.imshow(img1, cmap="gray")
    # plt.savefig("img1.png")
    # plt.clf()
    # plt.show()
    img2 = cv2.resize(img2, (512, 512))
    img2 = 255 * (img2 > np.mean(img2))
    # plt.imshow(img2, cmap="gray")
    # plt.savefig("img2.png")
    # plt.clf()

    # plt.show()
    img1, img2 = basBauhutHogayaReturns(img1, img2)
    # plt.imshow(img1)
    # plt.savefig("img1 returns.png")
    # plt.clf()
    # plt.imshow(img2)
    # plt.savefig("img2 returns.png")
    # plt.clf()
    #
    img1, img2 = AlignFingerPrint(img1, img2)
    img1 = 255 * (img1 > np.mean(img1))
    img2 = 255 * (img2 > np.mean(img2))
    # plt.imshow(img1, cmap="gray")
    # plt.savefig("img1 after Alignment.png")
    # plt.clf()
    # plt.imshow(img2, cmap="gray")
    # plt.savefig("img2 after Alignment.png")
    # plt.clf()
    i1, i2, j1, j2 = common_region(255-img1, 255-img2)
    # print(i1, i2, j1, j2)
    img1 = img1[i1:i2, j1:j2]
    img2 = img2[i1:i2, j1:j2]
    # img1 = basBauhutHogaya(img1)
    # img2 = basBauhutHogaya(img2)
    # plt.imshow(img1, cmap="gray")
    # plt.savefig("img1 trimmed.png")
    # plt.clf()
    # plt.imshow(img2, cmap="gray")
    # plt.savefig("img2 trimmed.png")
    # plt.clf()
    dft1 = np.fft.fftshift(np.fft.fft2(img1))
    dft2 = np.fft.fftshift(np.fft.fft2(img2))
    # blpoc = abs(BLPOC(dft1, dft2, band=[img1.shape[0]//4, img1.shape[1]//4]))
    blpoc = abs(BLPOC(dft1, dft2, band=[100, 100]))
    blpoc = blpoc.reshape(-1)
    blpoc = np.sort(blpoc)
    p1 = np.sum(blpoc[-2:])
    print(p1)
    return p1


if __name__ == "__main__":
    img1 = 255 - cv2.imread("107_4.tif", 0)
    img2 = 255 - cv2.imread("107_6.tif", 0)
    img3 = 255 - cv2.imread("102_6.tif", 0)
    # img4 = 255 - cv2.imread("109_5.tif", 0)
    p1 = Predict(img1, img2)
    p2 = Predict(img2, img3)
    print(f"IMG1, IMG2 prediction {p1>0.007}")
    print(f"IMG2, IMG3 prediction {p2 > 0.007}")
    # Predict(img3, img4)
    # Predict(img1, img4)
