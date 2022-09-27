function micronPerPixel = deterPxSize()

prompt2D = {'Insert image pixel size (um/pixel).'};
dlgtitle2D = 'Determine pixel size';
dims2D = [1 35];
definput2D = {'0.07'};
answer2D = inputdlg(prompt2D,dlgtitle2D,dims2D,definput2D);
micronPerPixel = str2double(answer2D{1});


end