fs = 44100;
fa = 440;
bpm = 120;

% Randomly decide a scale
scalesteps = diatonicScaleSteps(randi(7))
scaleroot = cell2mat(noteval2notename(randi([-20 5]) * 0.5))
range = 1:8;
noteSet = noteset(scalesteps, scaleroot, range)

notesPerMeasure = 3;
numUniqueMeasures = 4;
numReps = 3;

phraseL = phrase(noteSet, 'rand', numUniqueMeasures, numReps, notesPerMeasure);
phraseR = phrase(noteSet, 'rand', numUniqueMeasures, numReps, notesPerMeasure);

voiceL = 3;
voiceR = 2;
amp = 0.05;

audiodataL = amp * notename2aud(phraseL, fa, fs, bpm, 'sine', voiceL);
audiodataR = amp * notename2aud(phraseR, fa, fs, bpm, 'sine', voiceR);
[audiodataLM, audiodataRM] = mix(audiodataL, audiodataR, 0.3);

player = audioplayer([audiodataLM audiodataRM], fs);
play(player);

% Idle while playing so function doesn't return, destroying the player
% before playback
while isplaying(player)
endwhile
