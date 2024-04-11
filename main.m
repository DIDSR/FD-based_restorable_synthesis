clc;clear


img = imread('STAPLE05.png');

% binarize area image
if size(img,3)~=1
    img=rgb2gray(img);
end

if ~isa(img,'logical')
    mask = imbinarize(img);  
else
    mask = img;
end


% coding boundary to FDs
Fcode = bd2Fdesc(mask); 

% changing the FDs
% Core func: FD_change(input-Fcode,low-freq,high-freq,sigma)
% high-freq>=low-freq 
% if low-freq=0: include DC term
% if low-freq>0: keep no change on DC term
CFcode = FD_change(Fcode,2,10,1);

% new changed img
[im_height, im_width]=size(mask);
syn_img=zeros(im_height,im_width,'logical');

% convert FDs to boundary
re_img = Fdesc2bd(CFcode,size(mask));
se = strel('square',2);
CH = imdilate(re_img,se);
syn_img = imfill(CH,'holes');

% display
figure, imagesc(syn_img)
