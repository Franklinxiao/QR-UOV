function [P_1,P_2] = Expand_pk(seed_pk,V,M,l,i,t1,t2,q)
n1=l*V*(V+1)/2;
%t1=Tseq_cal();
v=RejSampPRG(seed_pk,2*i-1,t1,n1,q);
P_1= ExpandSymmetricMareixV_V(v,V,l);%返回二维元胞数组
n2=l*V*M;
%t2=Tseq_cal();
v=RejSampPRG(seed_pk,2*i,t2,n2,q);
P_2=ExpandMatrixV_M(v,V,M,l);%返回二维元胞数组
end

