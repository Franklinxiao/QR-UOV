function S_=Expand_sk(seed_sk,V,M,l,t2,q)
    n2=l*V*M;
    v=RejSampPRG(seed_sk,t2,n2,q);
    S_=ExpandMatrixV_M(v,V,M,l);
end


