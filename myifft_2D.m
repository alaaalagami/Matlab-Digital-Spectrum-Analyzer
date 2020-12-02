function X = myifft_2D(x)
% This function performs 2D IFFT.
% x must have a size of 2^n by 2^m where n,m are positive integers.

[n, m] = size(x);
Int = zeros(n, m);
X = zeros(n,m);

% Perform 1D IFFT on each column of x then store the results in Int
for i = 1:m
    Int(:,i) = myifft(x(:,i)')';
end

% Perform 1D IFFT on each row of Int then store the results in X
for i = 1:n
    X(i,:) = myifft(Int(i,:));
end

end