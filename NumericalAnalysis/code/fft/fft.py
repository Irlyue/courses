import numpy as np

from time import time


class Timer:
    def __enter__(self):
        self.tic = time()
        return self

    def __exit__(self, *args):
        self.elapsed = time() - self.tic


def my_fft(y):
    """
    Recursive implementation of FFT.

    :param y: list, with length equal to `2^L`.
    :return
        yh: list, same length as `y`.
    """
    n = len(y)
    N = n // 2
    if n == 2:
        y0, y1 = y
        yh0 = y0 + y1
        yh1 = y0 - y1
        return np.array([yh0, yh1])
    yeven = my_fft(y[::2])
    yodd = my_fft(y[1::2])
    wk = np.exp(-np.arange(N)*np.pi/N * 1j)
    yh = np.zeros(n, dtype=np.complex128)
    yh[:n//2] = yeven + wk * yodd
    yh[n//2:] = yeven - wk * yodd
    return yh


def get_indices(n):
    if n == 2:
        return np.array([0, 1])
    indices = np.zeros(n, dtype=np.int32)
    indices[:4] = [0, 2, 1, 3]
    i = 4
    while i < n:
        indices[:i] *= 2
        indices[i:2*i] = indices[:i] + 1
        i *= 2
    return indices


def my_fft_non_recursive(y):
    n = len(y)
    indices = get_indices(n)
    ar = np.arange(n)
    yh = np.zeros(n, dtype=np.complex128)
    yh[:] = y[indices]
    even = yh[::2]
    odd = yh[1::2]
    yh[::2], yh[1::2] = even + odd, even - odd
    i = 2
    while i < n:
        j = 0
        wk = np.exp(-ar[:i]*np.pi/i * 1j)
        while j < n:
            even = yh[j:j+i]
            odd = yh[j+i:j+2*i]
            yh[j:j+i], yh[j+i:j+2*i] = even + wk * odd, even - wk * odd
            j += 2*i
        i *= 2
    return yh


def my_ifft(yh):
    pass


def test_method(funcs, descs, n=16):
    y = np.random.randn(n)
    with Timer() as timer0:
        yh_gt = np.fft.fft(y)
    print('Numpy version done in %.5fs' % timer0.elapsed)

    for func, desc in zip(funcs, descs):
        with Timer() as timer1:
            yh = func(y)
        print('%s version done in %.5fs(%dx slower)' % (desc, timer1.elapsed, timer1.elapsed / timer0.elapsed))
        print('Max error: ', np.abs(yh_gt - yh).max())


def main():
    n = 1 << 20
    test_method([my_fft, my_fft_non_recursive], ['Recursive', 'Non-recursive'], n)


if __name__ == '__main__':
    main()
