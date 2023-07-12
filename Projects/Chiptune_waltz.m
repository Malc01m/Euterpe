fs = 44100;
fa = 440;
bpm = 120;

% Randomly decide a scale
scalesteps = diatonicScaleSteps(randi(7))
scaleroot = cell2mat(noteval2notename(randi([-20 5]) * 0.5))
range = 1:8;
nset = noteset(scalesteps, scaleroot, range)

rep = 4;
phr = 3;
mel = 4;

sng1 = [];
sng2 = [];
for i = 1:mel;
  meli1 = nset(randi(length(nset), phr, 1));
  veri1 = repmat(meli1, 1, rep);
  sng1 = [sng1 veri1];

  meli2 = nset(randi(length(nset), phr, 1));
  veri2 = repmat(meli2, 1, rep);
  sng2 = [sng2 veri2];
endfor

[sng1; sng2]

audiodata = 0.05 * notename2aud(sng1, fa, fs, bpm, 'sine', [3 5]);
audiodata = audiodata + (0.05 * notename2aud(sng2, fa, fs, bpm, 'sine', [3 5]));

player = audioplayer(audiodata, fs);
play(player);
% Idle while playing so function doesn't return, destroying the player
% before playback
while isplaying(player)
endwhile
