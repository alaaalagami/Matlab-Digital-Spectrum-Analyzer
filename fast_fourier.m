function X = fast_fourier(dim, x, type, fs)
% This is the layout function. 
% dim is the dimension of the FFT and can take values of either 1 or 2. 
% x is the input signal.
% type is a flag used to specify whether to perform FFT or IFFT and can take
%values of either 'fft' or 'ifft'.
% fs is the sampling frequency of the input signal.

if (dim ~= 1 && dim ~= 2)
    disp("Error: The dimension of the fft/ifft can either be 1 or 2");
    return;
end

if (type ~= "fft" && type ~= "ifft")
    disp("Error: The type parameter can either be 'fft' or 'ifft'");
    return;
end

x = zero_pad(x,dim);

m = size(x,2);

if dim == 1
    if type == "fft"
        X = myfft(x);
        time = x; fourier = X;
    else
        X = myifft(x);
        time = X; fourier = x;
    end
    subplot(2,1,1);
    stem(1:m, abs(time));
    xlabel("Time");
    ylabel("Amplitude");
    title("Time-domain signal");
    subplot(2,1,2);
    stem(linspace(-fs/2,fs/2,m), abs(fftshift(fourier)));
    xlabel("Frequency");
    ylabel("Amplitude");
    title("Magnitude of frequency-domain signal");
else
    if type == "fft"
        X = myfft_2D(x);
        image = x; fourier = X;
    else
        X = myifft_2D(x);
        image = X; fourier = x;
    end
        subplot(1,2,1);
        imshow(uint8(image));
        title("Image");
        subplot(1,2,2);
        imshow(uint8(abs(fourier)));
        title("Magnitude of Fourier Transform");
end