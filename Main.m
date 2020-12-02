clear; clc;
%% Testing 1D FFT
n = 1:150;
x = sinc(2*pi*n/100 - 5);
fast_fourier(1,x,"fft", 1000);
%% Testing 2D FFT
x = double(imread('pout.tif'));
fast_fourier(2,x,"fft");
%% 1D FFT
% <include>myfft.m</include>
%% 1D IFFT
% <include>myifft.m</include>
%% 2D FFT
% <include>myfft_2D.m</include>
%% 2D IFFT
% <include>myifft_2D.m</include>
%% Zero Padding
% <include>zero_pad.m</include>
%% Layout
% <include>fast_fourier.m</include>