function nset = transpose(nset, steps)
    for i = 1:length(nset)
        nset(i) = noteval2notename(notename2noteval(nset{i}) + steps);
    endfor
end
