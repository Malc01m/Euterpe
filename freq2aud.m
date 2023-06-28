function noteAudio = freq2aud(freq, fs, samp)
    noteAudio = zeros(samp, 1);
    for j = 1:samp
        % rad / cycle * cycle / s * s / sam
        theta = (pi() * 2) * freq * (1 / fs);
        noteAudio(j) = sin(theta * j);
    endfor
    noteAudio = ramp(noteAudio, 0.1, fs);
endfunction
