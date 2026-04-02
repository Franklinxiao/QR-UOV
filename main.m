 clc

 %data set:1
V=74;
M=10;
l=10;
q=7;
lamda=128;
t1=32629;
t2=8947;
t3=201;
g=[1,0,0,0,0,0,0,0,0,q-1,q-1];

 %data set:toy
V=8;
M=4;
l=4;
q=7;
lamda=16;
t1=326;
t2=894;
t3=201;
g=[1,0,q-1,q-1];
 
[seed_pk,seed_sk,P_i3_list]=KeyGen(V,M,l,q,t1,t2,lamda,g);
