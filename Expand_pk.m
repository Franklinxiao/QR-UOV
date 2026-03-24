function [P_1,P_2] = Expand_pk(seed_pk,i,t1,t2)
n1=l*V*(V+1)/2;
v=RejampPRG(seed_pk,2*i-1,t1,n1);
P_1= ExpandSymmetricMareixV_V(v);
n2=l*V*M;
v=RejampPRG(seed_pk,2*i,t2,n2);
P_2=ExpandMatrixV_M(v,V,M,l);
end

