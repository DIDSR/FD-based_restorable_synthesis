function o = bd2Fdesc(img)

img(img~=0)=1;
img = bwperim(img);
image_edged = double(img);

% find border
f=find(image_edged);
lenf=length(f);
[new_indeces]=find_close_indeces(image_edged);
ii=new_indeces(:,1);jj=new_indeces(:,2);
border_cmplx=ii+1i*jj;

border_fft =fftshift(fft(border_cmplx));

o = zeros(lenf,2);
o(:,1)=real(border_fft);
o(:,2)=imag(border_fft);

end
