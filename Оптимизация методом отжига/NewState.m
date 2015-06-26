function z = NewState(s)
    a = randi(numel(s)); 
    v = randi(numel(s));
    while a==v
      v = randi(numel(s));
    end
    z = s;
    z(a) = s(v);
    z(v) = s(a);
 end