function temp = myifft(x)
% This function performs 1D IFFT.
% x must have 2^n elements where n is a positive integer.

N = length(x); 
n = log2(N); 
temp = zeros(1, N);

% Apply bit inversion to get correct order of IFFT input
for i = 1: N
    j = dec2bin(i-1, n); % Convert decimal number to binary
    j = flip(j);  % Invert bit order
    k = bin2dec(j); % Convert back to decimal
    temp(k+1) = x(i)/N; % Re-insert original number into its new position
                        % and scale by 1/N
end

% Apply 2-point IDFT on each adjacent pair of points
for i = 1:2:N-1
    x(i) = temp(i) + temp(i+1); 
    x(i+1) = temp(i) - temp(i+1); 
end

% Recursively compute the 4-point till N-point iFFT  
p = 4; 
while p <= N
    w = 0; 
    % Apply algorithm for each p points of the array
    while w < N 
        for k = 1:p/2
             temp(w + k)= x(w + k) + exp(2i*pi*(k-1)/p)*x(w + k + p/2); 
        end
        for k = p/2+1:p
             temp(w + k)= exp(2i*pi*(k-1)/p)*x(w + k) + x(w + k - p/2);
        end
        w = w + p; % Increment w to compute next p points
    end
    p = p * 2;  % Double p to compute next layer
    x = temp; 
end 

temp = x;
end 