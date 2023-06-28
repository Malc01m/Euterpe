function nset = noteset(steps, root)
  nset(1) = notename2noteval(root);
  for i = 1:length(steps)
    nset(i + 1) = (nset(i) + steps(i));
  endfor
  nset = noteval2notename(nset);
endfunction
