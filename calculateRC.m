function RC = calculateRC(y1, X1, y2, X2, kA, kB, Pb, Pa1, Pa2, M, c, k)
%   yAB = calculateY(Pa2, Pb, y1, X1, c, k, kA, M);
    fis1 = genfis3(X2(:, M), y2, 'mamdani', c, [NaN NaN NaN false]);
    yAB = evalfis(X1(:, M), fis1);
    
    %yBA = calculateY(Pa1, Pb, y2, X2, c, k, kB, M);
    fis2 = genfis3(X1(:, M), y1, 'mamdani', c, [NaN NaN NaN false]);
    yBA = evalfis(X2(:, M), fis2);
    RC = (sum((y1 - yAB).^2)/kA + sum((y2 - yBA).^2)/kB)/2;
end