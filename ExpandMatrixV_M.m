function A= ExpandMatrixV_M(v,V,M,l)
A=cell(V,M);
k=1;
    for i = 1:V
      for j =1:M
         A{i,j}=v(k:k+l-1);%在原来的文献中这里S_的每个元素都是多项式类型的，现在在MATLAB里就简单就用1*l储存所有的系数了。
         k=k+l;
      end
    end
end

