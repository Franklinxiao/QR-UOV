function num = Tseq_cal(n,lamda,q)
p=q/(2.^(log2(q)));
tau_lst=[];
for t =n-1:n+10
    P=0;
    for i =0 :n-1
        P=P+nchoosek(t,i)*p.^i*(1-p).^(t-i);
    end
    if P<= 2^(-lamda)
        tau_lst(end+1)=t;
    end
end
if tau_lst~=[]
    num=min(tau_lst);
else
    num=0;
end

