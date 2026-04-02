function S_=Expand_sk(seed_sk,V,M,l,q,t2)
    n2=l*V*M;
    v=RejSampPRG(seed_sk,1,t2,n2,q);
    assignin('base', 'prgseq', v);
    S_=ExpandMatrixV_M(v,V,M,l);%返回二维元胞数组
end


