function audiodata = notename2aud(notes, fa, fs, bpm, wavetype, hrmncs, audiofile)

  if ~exist('bpm', 'var')
    bpm = 90;
  endif
  if ~exist('fs', 'var')
    fs = 44100;
  endif
  if ~exist('fa', 'var')
    fa = 440;
  endif

  if ~exist('wavetype', 'var')
    wavetype = 'sine';
  endif
  if ~exist('hrmncs', 'var')
    hrmncs = [];
  endif

  audiodata = [];
  for i = 1:length(notes)

    noteval = notename2noteval(notes{i});
    freq = noteval2freq(fa, noteval);
    beats = ones(1, length(notes));
    bps = 60 / bpm;
    samp = round(fs * bps * beats(i));

    if ~exist('audiofile') || isempty('audiofile')

      switch (wavetype)
        case 'sine'
          noteAudio = sinetone(freq, fs, bps * beats(i), 1);
          for j = 1:length(hrmncs)
              noteAudio += sinetone(freq * hrmncs(j), fs, bps * beats(i), 1);
          end
        case 'tri' % WIP
          period = 1/freq;
          noteAudio = [linspace(0, 1, (period / 4)), linspace(1, -1, period / 2), linspace(-1, 0, period / 4)]
      endswitch

    else

      % Enforce length in samples
      noteAudio = load(audiofile);
      if (length(noteAudio) < samp)
        noteAudio = [noteAudio; zeros(samp - length(noteAudio), 1)];
      else
        noteAudio = noteAudio(1:samp);
      endif

      % Shift file frequencies
      origfft = fft(noteAudio);
      origfreq = 440; % TODO correct
      if (origfreq < freq)
        diff = round(freq - origfreq);
        newfft = [zeros(diff, 1); origfft(1:length(origfft - diff))];
      else
        diff = round(origfreq - freq);
        newfft = [origfft(1:length(origfft - diff)); zeros(diff, 1);];
      endif
      noteAudio = abs(ifft(newfft));
      noteAudio = noteAudio(1:samp);
    endif

    noteAudio = linearfade(noteAudio, round((bps * beats(i)) / 40), fs);
    audiodata = [audiodata; noteAudio];
  endfor
endfunction
