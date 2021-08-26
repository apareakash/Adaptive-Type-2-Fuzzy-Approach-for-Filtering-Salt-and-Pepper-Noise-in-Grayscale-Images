function [v,sigma]=gmf_para(R,h)
v=mean_k_middle(R);
v_avg=mean(v);
sigma=mean(abs(R-v_avg));
if sigma==0;sigma=eps;end
end