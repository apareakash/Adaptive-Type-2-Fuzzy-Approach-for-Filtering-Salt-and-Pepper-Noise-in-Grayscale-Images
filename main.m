Im=rgb2gray(imread('8.jpg'));
I=imnoise(Im,'salt & pepper',0.3);
I=double(I)/255;
[I_x,I_y]=size(I);
I_new=zeros(size(I));count=0;extra_rep=0;
for i=1:I_x;
    for j=1:I_y;
        I_new(i,j)=I(i,j);%initialization and non salt pepper pixel
        H=1;
       [i j]
        flag=0;
        while ((I(i,j)==1 || I(i,j)==0) && flag==0)%filtering
            count=count+1;
            I_trial=padarray(I,[H H]);%zero padding
            N=(2*H+1)^2;
            h=floor(N/2);
            R=neighbourhood_pixel(I_trial,i+H,j+H,H);%because of zero padding
            R=R(:)';%matrix to array
            [v,sigma]=gmf_para(R,h);
            del=primary_mf(R,v,sigma,h,N);
            Tm=min(max(del));
            pri_mf=mean(del);
            G=double(pri_mf > Tm).*R;%good pixels
            rho=sum(abs(G));
            
            if all(pri_mf >= Tm);I_new(i,j)=I(i,j);flag=1;end
            if sigma<2*eps;I_new(i,j)=mean(v);flag=1;end
            if rho<1;
                if H<10;H=H+1;
                else flag=1;I_new(i,j)=mean(v);
                end
            elseif rho>=1;
                flag=1;
            end 
            
            
        end
        if(flag==1)
            [good_mean,good_sigma]=gmf_para(G,h);
            good_mf=gaussmf(G,[good_sigma,good_mean]);
            w=good_mf; 
            W=sum(good_mf);
            pnew=dot(G,w)/W;
            I_new(i,j)=pnew;
        end
    end
end
subplot(131);imshow(Im);subplot(132);imshow(I);subplot(133);imshow(I_new)