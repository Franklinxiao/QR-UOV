function result = fai_inv(P,l,g,q)
     %先根据次数书写伴随矩阵
     Cf=zeros(l,l);
     for i=2:l
         Cf(i,i-1)=1;
     end
     for i =1:l
         Cf(i,l)=q-g(l-i+2);
     end
    [M,N]=size(P);
    result=zeros(M*l,N*l);
    for i =1:M
        for j=1:N
            ploy=P{i,j};%提取到该多项式
            r=ploy(l)*eye(l);
            for k=2:l
                r=r+ploy(l-k+1)*Cf.^(k-1);
            end
            
            for jj=1:l
                for kk=1:l
                    r(jj,kk)=mod(r(jj,kk),q);
                end
            end
             result(l*(i-1)+1:l*i,l*(j-1)+1:l*j)=r;
        end
    end
end

