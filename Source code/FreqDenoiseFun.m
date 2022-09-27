function ImFreqDenoise = FreqDenoiseFun(NormInt,FreqPeak)

%% frezuency peak remove
Fint = fft2(NormInt);
FreqShift = fftshift(abs(Fint));

hmask = ones(size(NormInt));
hmask(FreqShift >FreqPeak) = 0;

Fimage_filter = fftshift(Fint).*hmask;
filtered_im = ifft2(ifftshift(Fimage_filter));
filtered_im_gray = mat2gray(filtered_im);
% figure; imagesc(filtered_im_gray);

ImFreqDenoise = filtered_im_gray;

end