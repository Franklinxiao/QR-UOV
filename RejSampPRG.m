function v = RejSampPRG(seed,i,t,n)
r=PRG(seed,i,8*t);
v=RejSamp(r,t,n);
end

