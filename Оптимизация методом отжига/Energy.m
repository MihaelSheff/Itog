function E = Energy(s,distance)
E = 0;
for i = 1:numel(s)-1 
 
    E = E + distance(s(i),s(i+1));
end 
E = E + distance(s(numel(s)), s(1));


end