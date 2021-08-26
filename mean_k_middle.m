function m=mean_k_middle(R)
    N=length(R);
    h=floor(N/2);
    m=zeros(1,h);
    if N/2==0
        for k=1:h
            m(k)=sum(R(h-k+1:h+k))/(2*k);
        end
    else
        for k=1:h
            m(k)=sum(R(h-k+1:h+k-1))/((2*k)-1);
        end
     
    end
end