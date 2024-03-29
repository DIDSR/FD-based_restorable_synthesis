function o = bd2Fdesc(img,ncoef)

img(img~=0)=1;
img = bwperim(img);
image_edged = double(img);

border_fft=zeros(size(image_edged));

% find border
f=find(image_edged);
lenf=length(f);
[new_indeces]=find_close_indeces(image_edged);
ii=new_indeces(:,1);jj=new_indeces(:,2);
border_cmplx=ii+1i*jj;

border_fft =fftshift(fft(border_cmplx));

if mod(lenf,2) % odd
    lenf = lenf-1;
end
rc = fix(lenf/2)+1;

p1=[ (rc+1):(rc+1+ncoef-1)];
p2=[ (rc-1):-1:(rc-1-ncoef+1)];

o = zeros(2*ncoef+1,2);

n = 1;


for ind =(ncoef):-1:1
    o(n,1)=real(border_fft(p2(ind)));
    o(n,2)=imag(border_fft(p2(ind)));
    n=n+1;
end

%add dc
o(n,1)=real(border_fft(rc));
o(n,2)=imag(border_fft(rc));
n=n+1;

for ind = 1:(ncoef)
    o(n,1)=real(border_fft(p1(ind)));
    o(n,2)=imag(border_fft(p1(ind)));
    n=n+1;
end
o(n,1)=length(f);
o(n,2)=length(f);
% o=o/10e+5;
end