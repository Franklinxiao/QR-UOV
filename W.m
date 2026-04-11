function result = W(n)
result=zeros(n,n);
for i= 1:n
    for j =1:n
        if i+j==n+1
            result(i,j)=1;
        end
    end
end
end

