function seq = RejSamp(seed,t,n,q)
%REJSAMP 此处显示有关此函数的摘要
v=zeros(n);
for j =1:t
    v(j)=BitsToInteger(BytesToBits(bitand(seed(j),InterToBits(q))));
end
k=n+1;
while v(k)==q&&k<t+1
    k=k+1;
end
for j = 1:n
    if v(j)==q
        if k<t+1
            v(j)=v(k);
            k=k+1;
            while v(k)==q&&k<t+1
                k=k+1;
            end
        else
            v(j)=0;
        end
    end
end
seq=v;
end

