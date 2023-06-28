function audio = linearfade(audio, durInS, fs, in, out)

  if ~exist('fs', 'var')
    fs = 44100;
  endif
  if ~exist('in', 'var')
    in = true;
  endif
  if ~exist('out', 'var')
    out = true;
  endif

  samples = fs * durInS;
  for i = 1:samples
    indices = [i, length(audio) - i + 1];
    audio(indices) = audio(indices) * (i / samples);
  endfor

endfunction
