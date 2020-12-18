clear; clc;
%x = audioread("beethoven.mp3");
%x = x(1:length(x)/2,1)';
%fs = length(x)/10;
%sound(x, fs)
fs = 8;
t = linspace(0,1-1/fs,fs);
%x = sinc(t-5);
%x = rectpuls(t, 2);
x = cos(2*pi*t);
X = fast_fourier(1,x,'fft',fs);
disp("This is the spectrum analyzer beep boop")
fprintf("What do you want to do to your audio?\n1. Apply Window\n2. Calculation Mode\n3. N-DFT\n4. Comparison Mode\n")
choice = input("Enter the number that corresponds to your choice: ");
n = length(x);
i = 1:n;
if choice == 1 %Windowing
    rectWindow = @(L) i <= L;
    triWindow = @(L) ((2*i/L) .* (i <= L/2) + (2-2*i/L) .* (i > L/2)) .* (i <= L);
    hanWindow = @(L) (0.5 - 0.5 * cos(2*pi*i/L)) .* (i <= L);
    hamWindow = @(L) (0.54 - 0.46 * cos(2*pi*i/L)) .* (i <= L);
    fprintf("Which window would you like to apply?\n1. Rectangular\n2. Triangular\n3. Hanning\n4. Hamming\n")
    windowIndex = input("Enter the number that corresponds to your choice: ");
    windowLength = input("Enter the length of the window: ");
    if windowIndex == 1 %Rectangular
        xWindowed = x .* rectWindow(windowLength);
    elseif windowIndex == 2 %Triangular
        xWindowed = x .* triWindow(windowLength);
    elseif windowIndex == 3 %Hanning
        xWindowed = x .* hanWindow(windowLength);
    elseif windowIndex == 4 %Hamming
        xWindowed = x .* hamWindow(windowLength);
    else
        disp("Please enter a valid choice!")
    end
    figure()
    X = fast_fourier(1,xWindowed,'fft',fs);
    
elseif choice == 2 % Calculation
    X = fast_fourier(1,x,'fft',fs);
    fprintf("What do you want to calculate?\n1. Power\n2. RMS\n")
    calculation = input("Enter the number that corresponds to your choice: ");
    if calculation == 1 %Power
        rangeStart = input("Enter the start of the frequency range: ");
        rangeEnd = input("Enter the end of the frequency range: ");
        N = length(X);
        X_oneSided = ifftshift(X);
        X_oneSided = X_oneSided(1:N/2);
        PSD = 1/N * (abs(X_oneSided) .^ 2);
        PSD(2:end) = 2*PSD(2:end);
        Power = sum(PSD(round(rangeStart * N/fs)+1, round(rangeEnd * N/fs)+1));
        fprintf("Power = %f Watt\n", Power)
    elseif calculation == 2 %RMS
        numValidSplits = 0;
        i = 2;
        validSplitters = [];
        while i < sqrt(n) && numValidSplits < 5
            if mod(n,i) == 0
                validSplitters = [validSplitters i];
                numValidSplits = numValidSplits + 1;
            end
            i = i + 1;
        end

        fprintf("How do you want to split the signal?\n1. By number of segments\n2. By length of segments\n")
        splitCriterion = input("Enter the number that corresponds to your choice: ");
        if splitCriterion == 1
            fprintf("Pick one of the following number of splits: ");
            for i = 1:numValidSplits
                fprintf("%d ", validSplitters(i))
            end
            fprintf('\n')
            numSplits = input("Enter the desired number of splits: ");
            X = zeros(1,2^ceil(log2(n/numSplits)));
            for i = 1:numSplits
                xSplit = x((i-1)*n/numSplits+1: i*n/numSplits);
                XSplit = fast_fourier(1,xSplit,'fft',fs);
                X = X + 1/numSplits * XSplit;
            end
        elseif splitCriterion == 2
            fprintf("Pick one of the following lengths of splits: ");
            for i = 1:numValidSplits
                fprintf("%d ", n/validSplitters(i))
            end
            fprintf('\n')
            lengthSplits = input("Enter the desired length of splits: ");
            numSplits = n/lengthSplits;
            X = zeros(1,2^ceil(log2(lengthSplits)));
            for i = 1:numSplits
                xSplit = x((i-1)*n/numSplits+1: i*n/numSplits);
                XSplit = fast_fourier(1,xSplit,'fft',fs);
                X = X + 1/numSplits * XSplit;
            end
            % Plot Avg X
        end
    end
elseif choice == 3 % N-DFT
    leastN = 2^ceil(log2(n));
    nextN = 2 * leastN;
    MAXN = 64000;
    fprintf("Pick one of the following lengths of DFT: %d ", leastN);
    while nextN < MAXN
         fprintf("%d ", nextN)
         nextN = nextN * 2;
    end
    fprintf("%d \n", MAXN)
    lengthDFT = input("Enter the desired length of DFT: ");
    xPadded = [x zeros(1,lengthDFT-n)];
    X = fast_fourier(1,xPadded,'fft',fs);
    
elseif choice == 4 % Comparison
    subplot(2,2,[1 3])
    X = fast_fourier(1,x,'fft',fs);
    subplot(2,2,[2 4])
    stem(x)
else
    disp("Please choose right...");
end
        
