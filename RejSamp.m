function seq = RejSamp(seed,t,n,q)
v=[];
for j =1:t
    bit1=BytesToBits(seed(j));
    bit2=IntegerToBits(q,8);
    ba=bitand(bit1,bit2);
    v(end+1)=BitsToInteger(ba);%忽略了原文的一些写法
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
seq=v(1:n);
end

