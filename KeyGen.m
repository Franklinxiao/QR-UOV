function [seed_pk,seed_sk,P_i3_list] = KeyGen(V,M,l,q,t1,t2,t3,g)
lamda=64;
rb=randi([0 1], 1, lamda);
seed_pk=rb(1:lamda/2);
seed_sk=rb(lamda/2+1:lamda);
S_=Expand_sk(seed_sk,V,M,l,t2);
S_=matrix_to_cell(S_);
% P_i1=zeros(V,V,l);
% P_i1=zeros(V,M,l);
P_i3_list=[];
for i=1:m
    [P_i1,P_i2]=Expand_pk(seed_pk,i,t1,t2,q);
    P_i1=matrix_to_cell(P_i1); P_i2=matrix_to_cell(P_i2);
    tem0= poly_matrix_mult_mod(S_', P_i1, g, q);
    tem1= poly_matrix_mult_mod(tem0,S_, g, q);
    tem2=poly_matrix_mult_mod(P_i2,S_, g, q);
    tem3=poly_matrix_mult_mod(S_',P_i2, g, q);
    P_i3=cell_to_matrix(tem1)+cell_to_matrix(tem2)+cell_to_matrix(tem3);
    P_i3_list(end+1)=P_i3;
end

