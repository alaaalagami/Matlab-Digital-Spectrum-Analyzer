function temp = myifft(x)
% array must have 2^n number of elements where n is a positive integer
N = length(x); 
n = log2(N); 
temp = zeros(1, N);
for i = 1: N
    j = de2bi(i-1, n);
    j = flip(j); 
    k = bi2de(j);
    temp(k+1) = x(i)/N; 
end
for i = 1:2:N-1
    x(i) = temp(i) + temp(i+1); 
    x(i+1) = temp(i) - temp(i+1); 
end
p = 4; 
while p <= N
    w = 0; 
    while w < N 
        for k = 1:p/2
             temp(w + k)= x(w + k) + exp(2i*pi*(k-1)/p)*x(w + k + p/2); 
        end
        for k = p/2+1:p
             temp(w + k)= exp(2i*pi*(k-1)/p)*x(w + k) + x(w + k - p/2);
        end
        w = w + p; 
    end
    p = p * 2;  
    x = temp; 
end 
end 