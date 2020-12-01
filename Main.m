clear; clc;
x = double(imread('pout.tif'));
figure(1)
y = fast_fourier(2,x,"fft");
figure(2)
x2 = fast_fourier(2,y,"ifft");

%%
n = 1:150;
x = [sinc(2*pi*n/100 - 5)];
fast_fourier(1,x,"fft", 10);