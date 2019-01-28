function belief = calculateBelief(x, pp)
    if (x < pp(1) | x > pp(4))
        belief = 0;
    elseif (x >= pp(1) & x <= pp(2))
        if(pp(1) == pp(2))
            belief = 1;
        else
            belief = (x - pp(2))/(pp(2) - pp(1)) + 1;
        end
    elseif (x >= pp(2) & x <= pp(3))
        belief = 1;
    elseif (x >= pp(3) & x <= pp(4))
        if (pp(2) == pp(3))
            belief = 1;
        else
            belief = (x - pp(3))/(pp(3) - pp(4)) + 1;
        end
    end
end