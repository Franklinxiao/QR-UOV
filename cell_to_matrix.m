function M = cell_to_matrix(C,l)
[m,n]=size(C);
M=zeros(m,n,l);
for i =1:m
    for j =1:n
            M(i,j,1:l)=C{m,n};
    end
end
end

