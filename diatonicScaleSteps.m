function steps = diatonicScaleSteps(mode)
  if mode > 7 || mode < 1
    error("Mode must be in range of 1-7");
  endif
  minorSteps = [1 0.5 1 1 0.5 1 1];
  steps = [minorSteps(mode:7), minorSteps(1:(mode - 1))];
endfunction
