function audio = ramp(audio, durInS, fs)
  rampSamp = fs * durInS;
  for i = 1:rampSamp
    audio(i) = audio(i) * (i / rampSamp);
    audio(length(audio) - i + 1) = audio(length(audio) - i + 1) * (i / rampSamp);
  endfor
endfunction
