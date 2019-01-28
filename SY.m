clear ; close all; clc

% data = load('data_sinc.txt');
% data = load('data_sinc_2.txt');
% data = load('data_saddle.txt');
 data = load('data_saddle_2.txt');
k = size(data, 2) - 1; % number of premise variables
X = data(:, 1:k);
y = data(:, k+1);
m = length(y); % number of examples

rnd = randperm(m);

X = X(rnd, :);
y = y(rnd); 

% data_test = load('data_sinc_test.txt');
% data_test = load('data_sinc_test_2.txt');
% data_test = load('data_saddle_test.txt');
 data_test = load('data_saddle_test_2.txt');;
X_test = data_test(:, 1:k);
y_test = data_test(:, k+1);
m_test = length(y_test);


c = 2;
Smin = inf;
aw = 2;

y_ = sum(y)/m;

while 1
   [centers, U] = FCM(y, c);
   U = U';
   
   S = 0;
   
   for i = 1:m
       for j = 1:c
           S = S + (U(i, j)^aw) * (norm(y(i) - centers(j))^2 - norm(centers(j) - y_)^2);
       end
   end
   
   if (S > Smin)
       c = c - 1;
       break;
   end
   
   Smin = S;
   Umin = U;
   centersmin = centers;
   c = c + 1;
end

U = Umin;

Pb = trapeze(U, y, c, m);

X1 = X(1:floor(m/2), :);
X2 = X(floor(m/2)+1:end, :);

y1 = y(1:floor(m/2));
y2 = y(floor(m/2)+1:end);

Pa1 = [];
Pa2 = [];

for i = 1:k
    Pa1 = [Pa1, trapeze(U(1:floor(m/2), :), X1(:, i), c, floor(m/2))];
    Pa2 = [Pa2, trapeze(U(floor(m/2)+1:end, :), X2(:, i), c, m-floor(m/2))];
end

M_opt1 = [];
M_opt2 = [];
M = [];

RCmin1 = inf;
RCmin2 = inf;

l = 0;

while (l < k)

   l = l + 1;
   
   RCmin2 = inf;
   M = M_opt1;
     
   for j = 1:k
       
       if (sum(M == j) ~= 0)
           continue;
       end
       
       M(l) = j;   
       
       RC = calculateRC(y1, X1, y2, X2, floor(m/2), m-floor(m/2), Pb, Pa1, Pa2, M, c, k);
       
       if (RC < RCmin2)
           RCmin2 = RC;
           M_opt2 = M;
       end
             
   end
   
   if (RCmin2 > RCmin1)
       break;
   end 
   
   RCmin1 = RCmin2;
   M_opt1 = M_opt2;
end

Pa = [];

%for i = M_opt1
%    Pa = [Pa, trapeze(U, X(:, i), c, m)];
%end

fis = genfis3(X(:, M_opt1), y, 'mamdani', 'auto', [NaN NaN NaN false]);

% [u, w] = sort(X(:, 1));
% plot(u, U(w, 2))
% 
% Pa

%Pa = optimizeP(Pa, Pb, y, X, c, k, m, M_opt1);

%yy = calculateY(Pa, Pb, y_test, X_test, c, k, m_test, M_opt1);
yy = evalfis(X_test(:, M_opt1), fis);

PI = sum((y_test - yy).^2)/m



