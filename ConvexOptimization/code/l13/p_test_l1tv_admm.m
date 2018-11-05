function [] = p_test_l1tv_admm()

clear;
close all;
randn('seed', 0); rand('seed', 0);

noiselevel = 0.1;
lambda = 1.0;

image_path = 'images/lena.jpg';
img = double(imread(image_path));

img_noise = img;
RN = rand(size(img_noise)); CorI = (RN < noiselevel); CorI2 = ~CorI;
RN(CorI2)=0; RV = RN(CorI) ; RN= ((RN-min(RV(:))).*(255-0))./(max(RV(:))-min(RV(:)));
img_noise(CorI) = RN(CorI);

% normalize to accelerate convergence
img_noise = img_noise / 255; img = img / 255;
[img_denoise] = l1tv_admm(@Af, @Bf, @Adf, @Bdf, img_noise, lambda, 100);

subplot(1, 3, 1); imshow(img, []); title('Original', 'fontsize', 13);
subplot(1, 3, 2); imshow(img_noise, []); title('Pulse Noise', 'fontsize', 13);
subplot(1, 3, 3); imshow(img_denoise, []); title('Recovered', 'fontsize', 13);

function [R] = Af(X)
R = X(:, [2:end, end], :)-X;

function [R] = Bf(X)
R = X([2:end, end], :, :)-X;

function [R] = Adf(dAfx)
R = dAfx(:, [1, 1:end-1], :) - dAfx;
R(:, 1, :) = -dAfx(:, 1, :);
R(:, end, :) = dAfx(:, end-1, :);

function [R] = Bdf(dBfx)
R = dBfx([1, 1:end-1], :, :) - dBfx;
R(1, :, :) = -dBfx(1, :, :);
R(end, :, :) = dBfx(end-1, :, :);
