function o = Fdesc2bd(Fdesc,SIZE)

len = size(Fdesc);
ii=Fdesc(:,1);jj=Fdesc(:,2);
cmplx=ii+1i*jj;

border_ifft =ifft(ifftshift(cmplx));
border_restored = zeros(SIZE);
xx=round(real(border_ifft));yy=round(imag(border_ifft));
try
    for i=1:len
        border_restored(xx(i),yy(i))=1;
    end
catch
    border_restored = zeros(SIZE); % if error, return empty img -> sum(img(:))==0
end
o= logical(border_restored);
end
