function playscale(mode, root, bpm, fs, fa)

  if ~exist('bpm', 'var')
    bpm = 90;
  endif
  if ~exist('fs', 'var')
    fs = 44100;
  endif
  if ~exist('fa', 'var')
    fa = 440;
  endif

  nset = noteset(diatonicScaleSteps(mode), root)
  playnoteset(nset, bpm, fs, fa);

endfunction
