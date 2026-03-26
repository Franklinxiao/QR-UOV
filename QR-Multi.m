function result = QR-Muti(A,B)
   %商环的矩阵乘法实现
   Asize=size(A);
   Bsize=size(B);
   if Asize(2)~=Bsize(1) || Asize(3)~=Bsize(3)
       printf("illeagle operation");
   l=Asize(3);
   C=zeros(Asize(1),Bsize(2))
   for i =1:Asize(1)
       for j =1:Bsize(2)
           for k =1:l
                C(i,j)=
           end
       end
   end
end

