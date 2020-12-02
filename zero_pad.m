function y = zero_pad(x,dim)
% This function zero pads the input signal from all sides until its 
%dimensions reach a power of 2.
% x is the input signal.
% dim is the the dimension of the matrix (1 or 2).

[n,m] = size(x);

if dim == 1
    % Calculate the number of remaining zeroes to reach a power of 2
    remaining_zeroes = 2^ceil(log2(m)) - m;
    
    if remaining_zeroes > 0
      % Pad the remaining zeroes from both sides
      if mod(remaining_zeroes,2) == 0
        y = [zeros(1,remaining_zeroes/2) x zeros(1,remaining_zeroes/2)];
      else
        y = [zeros(1,(remaining_zeroes+1)/2) x zeros(1,(remaining_zeroes-1)/2)];
      end
    else
        % In case no padding is required, return x as is
        y = x;
    end
else
    % Calculate the number of remaining zeroes for each dimension to 
    %reach a power of 2
    remaining_zeroes_x = 2^ceil(log2(m)) - m;
    remaining_zeroes_y = 2^ceil(log2(n)) - n;
    
    if remaining_zeroes_x > 0
        % Pad the remaining zeroes from both sides along the horizontal
        % axis
        if remaining_zeroes_x > 0 && mod(remaining_zeroes_x,2) == 0
           y = [zeros(n,remaining_zeroes_x/2) x zeros(n,remaining_zeroes_x/2)];
        else
           y = [zeros(n,(remaining_zeroes_x+1)/2) x zeros(n,(remaining_zeroes_x-1)/2)];
        end
    else
        % In case no padding is required, return x as is
        y = x;
    end
    
    if remaining_zeroes_y > 0
       % Pad the remaining zeroes from both sides along the horizontal
       % axis
       if mod(remaining_zeroes_y,2) == 0
         y = [zeros(remaining_zeroes_y/2, m+remaining_zeroes_x) y zeros(m+remaining_zeroes_x,remaining_zeroes_y/2)];
       else
         y = [zeros((remaining_zeroes_y+1)/2, m+remaining_zeroes_x); y; zeros((remaining_zeroes_y-1)/2, m+remaining_zeroes_x)];
       end
    end
    
end
end