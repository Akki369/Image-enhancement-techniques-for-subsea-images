A = imread('subsea_7.jpg');
filter = fspecial('Gaussian',[10 10],1.5);
C = imfilter(A,filter,'replicate');

subplot(1,2,1); 
imshow(A); 
title('Original Image');
subplot(1,2,2); 
imshow(C);   
title('Blurred Image');

[ssimval, ssimmap] = ssim(C,A);
  
fprintf('The SSIM value is %0.25f.\n',ssimval);
  
figure, imshow(ssimmap,[]);
title(sprintf('ssim Index Map - Mean ssim Value is %0.25f',ssimval));
dissimilarity = (1-ssimval)/2
