function y_ = calculateY(Pa, Pb, y, X, c, k, m, M)
    
    A = ones(c, k);
    w = zeros(c, 1);
    y_ = zeros(m, 1);
    B = zeros(m, 1);
    b = zeros(c, 1);
    
    for o = 1:m
        for i = 1:c
            for j = M
                A(i, j) = calculateBelief(X(o, j), Pa(i, 4*(j-1)+1:4*j));
            end

            for e = 1:m
                B(e) = calculateBelief(y(e), Pb(i, :));
            end

            b(i) = trapz(y, B.*y)/trapz(y, B);
        end
        
        w = prod(A, 2);
        
        if (sum(w) == 0)
            for i = 1:c
                w(i) = exp(-abs(X(o, 1)-X(i, 1)) - 2 * sum(abs(X(o, 2:end)-X(i, 2:end))));
            end
        end
        
        y_(o) = sum(w.*b)/sum(w);
        
    end
    
end