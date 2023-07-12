function nset = noteset(steps, root, nrange)
  rootval = notename2noteval(root);
  for i = 1:length(nrange)
    thisStep = nrange(i);
    nset(i) = rootval + (floor(thisStep / 8) * 8) + sum(steps(1:mod(thisStep, 8)));
  endfor
  nset = noteval2notename(nset);
endfunction
