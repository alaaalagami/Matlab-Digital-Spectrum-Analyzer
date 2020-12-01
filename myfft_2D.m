function X = myfft_2D(x)
% matrix must have a size of 2^n x 2^m where n,m are positive integers

[n, m] = size(x);
Int = zeros(n, m);
X = zeros(n,m);

for i = 1:m
    Int(:,i) = myfft(x(:,i)')';
end

for i = 1:n
    X(i,:) = myfft(Int(i,:));
end

end