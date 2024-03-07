function out = FD_change(Fcode,l,h)
Len = size(Fcode,1);% Len must be an Odd#
n=(Len-1)/2;
% idx: 1,2,3,…,n,n+1, Len-n+1, Len-n+2,…,Len
% idx: 1,2,3,…,n-1,n,n+1 (DC),n+2,n+3,…,2n-1,2n,2n+1
% shifted idx, n is at DC
% s_i: 0,1,2,…,n-2,n-1,n (DC),n+1,n+2,…,2n-2,2n-1,2n
% idx = s_i + 1;
    
    % high-freq:h; low-freq:l
    % h>=l, in[0,n]; 
    % if l=0: include n(DC)
    % if l>0: keep no change on n(DC)
    
%     l=2; h=10;
    
    s_i = [(n-h):(n-l),(n+l):(n+h)];
    idx = s_i + 1;

    sigma= 1;
    
    for i=1:length(idx)
        Fcode(idx(i),1)=Fcode(idx(i),1)*(1+normrnd(0,sigma));
        Fcode(idx(i),2)=Fcode(idx(i),2)*(1+normrnd(0,sigma));
    end


out = Fcode;

end
