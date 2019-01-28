function [center, U] = FCM(data, cluster_n)

    data_n = size(data, 1);
    data_dim = size(data, 2);

    center = zeros(cluster_n, data_dim);

    expo = 2;		    % Exponent for U
    min_impro = 1e-5;		% Min. improvement

    U = rand(cluster_n, data_n);
    col_sum = sum(U);
    U = U./col_sum(ones(cluster_n, 1), :);

    while 1

        for j = 1:cluster_n
            center(j, :) = ((U(j, :).^expo) * data) / sum(U(j, :));
        end
    
        dist = distfcm(center, data);
        tmp = dist.^(-2/(expo-1));
        U_new = tmp./(ones(cluster_n, 1)*sum(tmp));

        if (norm(U_new - U) < min_impro)
            U = U_new;
            break;
        end
    
        U = U_new;
    
    end

end
