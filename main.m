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

% count # of pixels on the boundary
bd = bwperim(mask);
total_pixels = sum(bd(:));
if mod(total_pixels,2) % odd
    total_pixels = total_pixels-1;
end
max_detail = total_pixels/2;
keep_details = floor(max_detail);

% coding boundary to FDs
codes = bd2Fdesc(mask,keep_details); % len(codes) must be an Even#
Fcode = codes(1:end-1,:); % here len(Fcode) must be an Odd#

% changing the FDs
% Core func: FD_change(input-Fcode,low-freq,high-freq,sigma)
% high-freq>=low-freq 
% if low-freq=0: include DC term
% if low-freq>0: keep no change on DC term
Fcode = FD_change(Fcode,2,10,1);
Fcode = [Fcode; codes(end,:)];% len(codes) must be an Even#

% new changed img
[im_height, im_width]=size(mask);
syn_img=zeros(im_height,im_width,'logical');

% convert FDs to boundary
re_img = Fdesc2bd(Fcode,size(mask));
se = strel('square',2);
CH = imdilate(re_img,se);
syn_img = imfill(CH,'holes');

% display
figure, imagesc(syn_img)