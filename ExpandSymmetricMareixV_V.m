function A = ExpandSymmetricMareixV_V(v,V,l)
k=1;
A=zeros(V,V,l);
for i = 1:V
    for j =1:V
        if j<i
            A(i,j,:)=A(j,i,:);
        else
            A(i,j,k:k+l-1)=v(k:k+l-1);%在原来的文献中这里A的每个元素都是多项式类型的，现在在MATLAB里就简单就用1*l储存所有的系数了。
        end
    end
end
end

