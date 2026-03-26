function [pk,sk] = KeyGen(V,M,l,q,t1,t2,t3)
lamda=64;
rb=randi([0 1], 1, lamda);
seed_pk=rb(1:lamda/2);
seed_sk=rb(lamda/2+1:lamda);
S_=Expand_sk(seed_sk,V,M,l,t2);
P_i1=zeros(V,V,l);
P_i1=zeros(V,M,l);
for i=1:m
    [P_i1,P_i2]=Expand_pk(seed_pk,i,t1,t2,q);
    
end

