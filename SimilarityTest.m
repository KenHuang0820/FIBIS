function [peaksnr, err, ssimval, multissimval] = SimilarityTest(Image)
[FileName,PathName] = uigetfile({'*.tif';'*.bin'}, 'Select image series');
fname = strcat(PathName, FileName);
data = im2double(imread(fname));
ref = imresize(data,[256 256]);

A = Image;
peaksnr = psnr(A,ref); 
err = immse(A,ref);
ssimval = ssim(A,ref);
multissimval = multissim(A,ref);
end