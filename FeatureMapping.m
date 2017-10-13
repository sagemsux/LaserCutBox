function v = FeatureMapping(n,s)
%0 - nothing, 1 - screw, 2 - tab
v = zeros(1,n);

b = 2;
for i = 1:(n-1)/2
    v(b) = 2;
    b = b + 2;
end

if mod(n+1,4) %check for even number of screws
    a = 2;
    for i = 1:s/2
        v(a) = 1;
        v(n-a+1) = 1;
        a = a + 2;
    end
else
    if mod(s,2)
        v((n+1)/2) = 1;
        a = 2;
        for i = 1:(s-1)/2
            v(a) = 1;
            v(n-a+1) = 1;
            a = a + 2;
        end
    else
        a = 2;
        for i = 1:s/2
            v(a) = 1;
            v(n-a+1) = 1;
            a = a + 2;
        end
    end
end

end