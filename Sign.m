function sigma = Sign(Message,seed_sk,seed_pk,V,M,l,q,t1,t2,t3,lamda,g)
y=randi([0, q-1], 1, V*l)';
assignin('base', 'y', y );    
L=zeros(M*l,M*l);
u=zeros(1,M*l);
S_=Expand_sk(seed_sk,V,M,l,q,t2);
 
for i =1:M*l
     [P_i1,P_i2]=Expand_pk(seed_pk,V,M,l,i,t1,t2,q);
     y_=W(V*l)*fai_inv(P_i1,l,g,q)*y;
     L(i,:)=mod(-2.*fai_inv(S_,l,g,q)'*y_+2.*W(M*l)*fai_inv(P_i2',l,g,q)*y,q);
     u(i)=mod(y'*y_,q);
end
assignin('base', 'L', L );
assignin('base', 'u', u );    
 a = [seed_pk, BytesToBits(Message)];
miu = SHAKE.SHAKE256(a, 512);
   
has_solution=false;
while(has_solution==false)
    r=randi([0 1], 1, lamda);
    t=Hash(miu,r,t3,M*l,q);
    assignin('base', 't', t );    
    if whether_has_soluiton(L,(t-u)',q)
        has_solution=true;
    end
end
x=quick_solution(L, (t-u)', q);
assignin('base', 'x', x );   
assignin('base', 'fainv_S_',fai_inv(S_,l,g,q) );
s=[y;x]'-[fai_inv(S_,l,g,q)*x;zeros(M*l,1)]';
s=mod(s,q);
sigma ={r,s};
end

