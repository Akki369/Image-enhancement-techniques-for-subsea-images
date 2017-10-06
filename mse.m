A = imread('subsea_7.jpg');
imshow(A)

B = imnoise(A,'salt & pepper', 0.05);
imshow(B)

err = immse(B, A);
fprintf('\n The mean-squared error is %0.25f\n', err);