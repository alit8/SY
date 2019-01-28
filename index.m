function idx = index(p, Pb, y, X, c, k, m, M)
   pa = reshape(p, c, 4 * length(M));
   y_ = calculateY(pa, Pb, y, X, c, k, m, M);
   idx = sum((y - y_).^2)/m;
end