A = imread('subsea_7.jpg');
B = imnoise(A,'salt & pepper', 0.05);

[peaksnr, snr] = psnr(B,A);
  
fprintf('\n The Peak-SNR value is %0.25f', peaksnr);
fprintf('\n The SNR value is %0.25f \n', snr);
