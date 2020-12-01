function y = zero_pad(x,dim)
[n,m] = size(x);

if dim == 1
    remaining_zeroes = 2^ceil(log2(m)) - m;
    if remaining_zeroes > 0
      if mod(remaining_zeroes,2) == 0
        y = [zeros(1,remaining_zeroes/2) x zeros(1,remaining_zeroes/2)];
      else
        y = [zeros(1,(remaining_zeroes+1)/2) x zeros(1,(remaining_zeroes-1)/2)];
      end
    else
        y = x;
    end
else
    remaining_zeroes_x = 2^ceil(log2(m)) - m;
    remaining_zeroes_y = 2^ceil(log2(n)) - n;
    
    if remaining_zeroes_x > 0
        if remaining_zeroes_x > 0 && mod(remaining_zeroes_x,2) == 0
           y = [zeros(n,remaining_zeroes_x/2) x zeros(n,remaining_zeroes_x/2)];
        else
           y = [zeros(n,(remaining_zeroes_x+1)/2) x zeros(n,(remaining_zeroes_x-1)/2)];
        end
    else
        y = x;
    end
    
    if remaining_zeroes_y > 0
       if mod(remaining_zeroes_y,2) == 0
         y = [zeros(remaining_zeroes_y/2, m+remaining_zeroes_x) y zeros(m+remaining_zeroes_x,remaining_zeroes_y/2)];
       else
         y = [zeros((remaining_zeroes_y+1)/2, m+remaining_zeroes_x); y; zeros((remaining_zeroes_y-1)/2, m+remaining_zeroes_x)];
       end
    end
    
end
end