function hash_value = Hash(message,salt,t3,m,q)
      r=SHAKE.SHAKE256( BitsToInteger(BytesToBits(message),salt), 8*t3);
      hash_value=RejSamp(r,t3,m,q);
end

