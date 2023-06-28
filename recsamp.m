function recsamp(name, deviceid, numchannels, fs, nbits)

  if ~exist('name', 'var')
    error('Recording requires a name');
  endif

  if ~exist('deviceid', 'var')
    for i = 1:size(audiodevinfo.input, 2)
      disp([' ' num2str(i) ': ' audiodevinfo.input(i).Name ' (ID: ' ...
        num2str(audiodevinfo.input(i).ID) ')']);
    endfor
    devind = input(['Choose an input device (1-' ...
      num2str(size(audiodevinfo.input, 2)) '): ']);
    deviceid = audiodevinfo.input(devind).ID;
  endif

  if ~exist('numchannels', 'var')
    numchannels = 1;
  endif
  if ~exist('fs', 'var')
    fs = 44100;
  endif
  if ~exist('nbits', 'var')
    nbits = 24;
  endif

  retry = true;
  while (retry)
    recorder = audiorecorder(fs, nbits, numchannels, deviceid)

    disp('Press space to start')
    pause
    record(recorder);
    disp('Press space to stop')
    pause
    stop(recorder);

    samp = getaudiodata(recorder);

    playReq = true;
    while (playReq)
      playReq = yes_or_no('Play recording? ');
      if (playReq)
        player = audioplayer(samp, fs, nbits);
        play(player);
        while isplaying(player)
        endwhile
      endif
    endwhile

    trimStartReq = true;
    trimsamp = samp;
    while (trimStartReq)
      trimStartReq = yes_or_no('Trim start of recording? ');
      startsamp = 1;
      if (trimStartReq)
        startsamp = input(["Choose start sample (1-" int2str(length(samp)) ")"]);
        trimsamp = samp(startsamp:length(samp));
        plot(trimsamp);
        player = audioplayer(trimsamp, fs, nbits);
        play(player);
        while isplaying(player)
        endwhile
      else
        samp = trimsamp;
      endif
    endwhile

    trimEndReq = true;
    while (trimEndReq)
      trimEndReq = yes_or_no('Trim end of recording? ');
      endsamp = length(samp);
      if (trimEndReq)
        endsamp = input(["Choose end sample (1-" int2str(length(samp)) ")"]);
        trimsamp = samp(1:endsamp);
        plot(trimsamp);
        player = audioplayer(trimsamp, fs, nbits);
        play(player);
        while isplaying(player)
        endwhile
      else
        samp = trimsamp;
      endif
    endwhile

    saveReq = yes_or_no('Save recording? ');
    if (saveReq)
      save("-ascii", name, "samp");
      retry = false;
    else
      retry = yes_or_no('Retry? ');
    endif

  endwhile
endfunction
