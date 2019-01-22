import numpy as np

from PIL import Image
from scipy.fftpack import dct, idct


Qy = np.array([
    [16, 11, 10, 16, 24, 40, 51, 61],
    [12, 12, 14, 19, 26, 58, 60, 55],
    [14, 13, 16, 24, 40, 57, 69, 56],
    [14, 17, 22, 29, 51, 87, 80, 62],
    [18, 22, 37, 56, 68, 109, 103, 77],
    [24, 35, 55, 64, 81, 104, 113, 92],
    [49, 64, 78, 87, 103, 121, 120, 101],
    [72, 92, 95, 98, 112, 100, 103, 99]
])

Qc = np.array([
    [17, 18, 24, 47, 99, 99, 99, 99],
    [18, 21, 26, 66, 99, 99, 99, 99],
    [24, 26, 56, 99, 99, 99, 99, 99],
    [47, 66, 99, 99, 99, 99, 99, 99],
    [99, 99, 99, 99, 99, 99, 99, 99],
    [99, 99, 99, 99, 99, 99, 99, 99],
    [99, 99, 99, 99, 99, 99, 99, 99],
    [99, 99, 99, 99, 99, 99, 99, 99]
])

M = np.array([
    [0.299, 0.587, 0.114],
    [-0.1687, -0.3313, 0.5],
    [0.5, -0.4187, -0.0813]
])


def get_quantization_matrix(Q, qf=100):
    assert (1 <= qf <= 100), 'Please provide the quality factor as an integer between 1 and 100'
    sf = (100 - qf) / 50 if qf <= 50 else 50 / qf
    Qx = np.round(Q * sf) if sf != 0 else Q
    return Qx


def read_image(path):
    return np.array(Image.open(path))


def image_trans(inX, tM):
    a = np.sum(inX * tM[0], axis=-1)
    b = np.sum(inX * tM[1], axis=-1)
    c = np.sum(inX * tM[2], axis=-1)
    return np.stack([a, b, c], axis=2)


def rgb2yuv(rgb):
    return image_trans(rgb, M)


def yuv2rgb(yuv):
    return image_trans(yuv, np.linalg.inv(M))


def to_blocks(x, h=8, w=8):
    H, W, *_ = x.shape
    for i in range(int(H/h)):
        for j in range(int(W/w)):
            block = x[i*h:(i+1)*h, j*w:(j+1)*w]
            yield i*h, j*w, block


def jpeg_compress(rgb, qf=100):
    # 1. Transform to YUV color space
    yuv = rgb2yuv(rgb) - 128.
    out = np.zeros_like(yuv)
    Qs = np.stack((Qy, Qc, Qc), axis=2)
    Qs = get_quantization_matrix(Qs, qf)
    for i, j, block in to_blocks(yuv):
        Gs = jpeg_compress_block(block)
        Bs = np.round(Gs / Qs)
        out[i:i+8, j:j+8] = Bs
    return out


def jpeg_compress_block(x):
    return dct(dct(x, axis=0, norm='ortho'), axis=1, norm='ortho')


def jpeg_decompress(x, qf=100):
    yuv = np.zeros_like(x)
    Qs = np.stack((Qy, Qc, Qc), axis=2)
    Qs = get_quantization_matrix(Qs, qf)
    for i, j, block in to_blocks(x):
        Bs = block * Qs
        Gs = np.round(jpeg_decompress_block(Bs))
        yuv[i:i+8, j:j+8] = Gs
    yuv += 128
    rgb = yuv2rgb(yuv)
    return rgb.astype('uint8')


def jpeg_decompress_block(x):
    return idct(idct(x, axis=1, norm='ortho'), axis=0, norm='ortho')
