function Pb = trapeze(U, data, c, n)
    
    r = 8;

    mu_min = min(U);
    mu_max = max(U);
    
    m = (mu_min * (r - 1) + mu_max)/r;
    M = (mu_max * (r - 1) + mu_min)/r;
    
    [data, I] = sort(data);
    
    xml = zeros(c, 1);
    xMl = zeros(c, 1);
    xMr = zeros(c, 1);
    xmr = zeros(c, 1);
    
    
    for j = 1:c
        if (U(I(1), j) >= m(j))
            xml(j) = data(1) - 0.1;
            pre(j) = 1;
        else
            xml(j) = data(1);
            pre(j) = 1;
            for i = 2:n
                if (U(I(i), j) >= m(j))
                    xml(j) = data(i-1);
                    pre(j) = i - 1;
                    break;
                end
            end
        end
    end  
    
    for j = 1:c
        for i = pre(j):n
            if (U(I(i), j) >= M(j))
                xMl(j) = data(i);
                pre(j) = i;
                break;
            elseif (i == n)
                xMl(j) = data(n);
                pre(j) = n;
            end
        end
    end
    
    for j = 1:c
        for i = pre(j):n
            if (U(I(i), j) < M(j))
                if(i ~= 1)
                    xMr(j) = data(i-1);
                    pre(j) = i - 1;
                    break;
                else
                    xMr(j) = data(i);
                    pre(j) = i;
                    break;
                end
            elseif (i == n)
                xMr(j) = data(n);
                pre(j) = n;
            end
        end
    end
    
    for j = 1:c
        for i = pre(j):n
            if (U(I(i), j) < m(j))
                xmr(j) = data(i);
                pre(j) = i;
                break;
            elseif (i == n)
                xmr(j) = data(n);
                pre(j) = n;
            end
        end
    end
    
    
    Pb = [xml xMl xMr xmr];
  
end