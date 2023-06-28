function note = noteval2notename(noteval)
  for i = 1:length(noteval)
    if mod(noteval(i), 0.5) == 0
        % notevals -0.5   -  5.5 are oct  0.
        %          -1.0   - -6   are oct -1.
        if noteval(i) >= -0.5
          oct = fix((noteval(i) + 0.5) / 6);
          noteval(i) = noteval(i) - (oct * 6);
        elseif noteval(i) <= -1.0
          oct = fix((noteval(i) + 1) / 6);
          noteval(i) = noteval(i) - (oct * 6);
          oct = oct - 1;
        endif

        notechar = '';
        wheel = {'a', 'bb', 'b', 'c', 'db', 'd', 'eb', 'e', 'f', 'gb', 'g', 'ab'};
        halfsteps = abs(noteval(i) / 0.5);
        if noteval(i) >= 0
          notechar = wheel{halfsteps + 1};
        else
          wheelind = length(wheel) - halfsteps + 1;
          if wheelind == 0
            notechar = 'ab';
          else
            notechar = wheel{wheelind};
          endif
        endif

        octchar = '';
        if oct ~= 0
          octchar = int2str(oct);
        endif

        note{i} = [octchar notechar];
    else
        error(['Notevals must be divisible by 0.5 (as all notes are some ', ...
          'multiple of half steps away from each other)']);
    endif
  endfor
endfunction
