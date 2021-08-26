function del=primary_mf(R,v,sigma,h,N)
del=zeros(h,N);
for k=1:h
    del(k,:)=gaussmf(R,[sigma v(k)]);
end

end