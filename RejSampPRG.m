function v = RejSampPRG(seed,i,t,n,q)
r=PRG(seed,i,8*t);
v=RejSamp(r,t,n,q);
end

