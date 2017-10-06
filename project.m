







clear;
close all;

image=imread('subsea_7.jpg');


filter=fspecial('unsharp'); %choosing Sharp filtering enhancement 
gray=rgb2gray(image); %converting to gray


stretch=imadjust(image,stretchlim(image)); %strechconstrast enhancement

se = strel('disk',15);
tophatFiltered = imtophat(image,se); %top-hat filter
stretchTopHat=imadjust(tophatFiltered,stretchlim(tophatFiltered)); %strechconstrast enhancement

background = imopen(gray,strel('disk',15)); %detecting background
gray2 = gray - background; %removing background


filtered2=imfilter(gray2,filter); %applying filter
filtered=imfilter(gray,filter); %applying filter

I=adapthisteq(filtered);  %adaptive histogramo equalization
I2=adapthisteq(filtered2);  %adaptive histogramo equalization

% link for hist andd adapthist http://www.ijarcce.com/upload/2014/july/IJARCCE4K%20a%20veer%20varinder%20A%20Review%20on%20Underwater%20image%20enhancement.pdf


I3 = imadjust(gray,[],[],0.8); %gamma adjustement enhancement 
I4 = imadjust(gray2,[],[],0.8); %gamma adjustement enhancement 

HSV = rgb2hsv(stretch);
% "20% more" saturation:
HSV(:, :, 2) = HSV(:, :, 2) * 1.8;
% or add:
% HSV(:, :, 2) = HSV(:, :, 2) + 0.2;
HSV(HSV > 1) = 1;  % Limit values
RGB = hsv2rgb(HSV);


% figure(1)
% imshowpair(image,I,'montage')
% figure(2)
% imshowpair(image,I2,'montage')
% figure(3)
% imshowpair(image,I3,'montage')
% figure(4)
% imshowpair(image,I4,'montage')
% figure(5)
% imshowpair(image,tophatFiltered,'montage')
% figure(6)
% imshowpair(image,stretchTopHat,'montage')
% figure(7)
% imshowpair(image,stretch,'montage')
% figure(8)
% imshowpair(image,RGB,'montage')



figure(1)
subplot(2,1,1)
imshowpair(image,I,'montage') %result od original image and other chosen
title('adaptive histogram');
subplot(2,1,2)
imshowpair(image,I2,'montage') %result od original image and other chosen
title('adaptive histogram without background');

figure(2)
subplot(2,1,1)
imshowpair(image,I3,'montage') %result od original image and other chosen
title('gamma adjustment');
subplot(2,1,2)
imshowpair(image,I4,'montage') %result od original image and other chosen
title('gamma adjustment without background');

figure(3)
subplot(2,1,1)
imshowpair(image,tophatFiltered,'montage') %result od original image and other chosen
title('Top-Hat filter');
subplot(2,1,2)
imshowpair(image,stretchTopHat,'montage') %result od original image and other chosen
title('Contrast Stretch + Top-Hat filter');

figure(4)
subplot(2,1,1)
imshowpair(image,stretch,'montage') %result od original image and other chosen
title('stretch');
subplot(2,1,2)
imshowpair(image,RGB,'montage') %result od original image and other chosen
title('hsv saturation');
% 
% close all
% 
% 
% 
peaksnr = psnr(I,gray); %psnr(A, REF)
fprintf('\n The Peak-SNR for adaptive histogram value is %0.4f', peaksnr);
err = immse(I,gray);
fprintf('\n The mean-squared for adaptive histogram error is %0.4f\n', err);
ssimval = ssim(I,gray);
fprintf('The SSIM for adaptive histogram value is %0.4f.\n',ssimval);

peaksnr = psnr(I2,gray); %psnr(A, REF)
fprintf('\n The Peak-SNR for adaptive histogram without background value is %0.4f', peaksnr);
err = immse(I2,gray);
fprintf('\n The mean-squared for adaptive histogram without background error is %0.4f\n', err);
ssimval = ssim(I2,gray);
fprintf('The SSIM for adaptive histogram without background value is %0.4f.\n',ssimval);

peaksnr = psnr(I3,gray); %psnr(A, REF)
fprintf('\n The Peak-SNR for gamma adjustment value is %0.4f', peaksnr);
err = immse(I3,gray);
fprintf('\n The mean-squared for gamma adjustment error is %0.4f\n', err);
ssimval = ssim(I3,gray);
fprintf('The SSIM for gamma adjustment value is %0.4f.\n',ssimval);

peaksnr = psnr(I4,gray); %psnr(A, REF)
fprintf('\n The Peak-SNR for gamma adjustment without background value is %0.4f', peaksnr);
err = immse(I4,gray);
fprintf('\n The mean-squared for gamma adjustment without background error is %0.4f\n', err);
ssimval = ssim(I4,gray);
fprintf('The SSIM for gamma adjustment without background value is %0.4f.\n',ssimval);

peaksnr = psnr(tophatFiltered,image); %psnr(A, REF)
fprintf('\n The Peak-SNR for Top-Hat filter value is %0.4f', peaksnr);
err = immse(tophatFiltered,image);
fprintf('\n The mean-squared for Top-Hat filter error is %0.4f\n', err);
ssimval = ssim(tophatFiltered,image);
fprintf('The SSIM for Top-Hat filter value is %0.4f.\n',ssimval);

peaksnr = psnr(stretchTopHat,image); %psnr(A, REF)
fprintf('\n The Peak-SNR for Contrast Stretch + Top-Hat filter value is %0.4f', peaksnr);
err = immse(stretchTopHat,image);
fprintf('\n The mean-squared for Contrast Stretch + Top-Hat filter error is %0.4f\n', err);
ssimval = ssim(stretchTopHat,image);
fprintf('The SSIM for Contrast Stretch + Top-Hat filter value is %0.4f.\n',ssimval);

peaksnr = psnr(stretch,image); %psnr(A, REF)
fprintf('\n The Peak-SNR for stretch value is %0.4f', peaksnr);
err = immse(stretch,image);
fprintf('\n The mean-squared for stretch error is %0.4f\n', err);
ssimval = ssim(stretch,image);
fprintf('The SSIM for stretch value is %0.4f.\n',ssimval);

peaksnr = psnr(RGB,im2double(image)); %psnr(A, REF)
fprintf('\n The Peak-SNR for hsv saturation value is %0.4f', peaksnr);
err = immse(RGB,im2double(image));
fprintf('\n The mean-squared for hsv saturation error is %0.4f\n', err);
ssimval = ssim(RGB,im2double(image));
fprintf('The SSIM for hsv saturation value is %0.4f.\n',ssimval);