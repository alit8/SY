function p_ = optimizeP(Pa, Pb, y, X, c, k, m, M)
    
    options = optimset('MaxIter', 400);
    
    init = reshape(Pa, 1, numel(Pa));

    temp = fmincon(@(p)(index(p, Pb, y, X, c, k, m, M)), init, [], [], [], [], [], [], [], options);
    
    p_ = reshape(temp, c, 4 * length(M));
    
end