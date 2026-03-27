function C = matrix_to_cell(M)
   [m,n,l]=size(M);
   C=cell(m,n);
   for i =1:m
       for j =1:n
           temp=zeros(l);
           temp(1:l)=M(i,j,1:l);
           C{m,n}=temp;
       end
   end
end

