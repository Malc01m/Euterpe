fs = 44100;
fa = 440;
bpm = 120;

% Randomly decide a scale
scalesteps = diatonicScaleSteps(randi(7))
scaleroot = cell2mat(noteval2notename(randi([-20 5]) * 0.5))
scaleset = noteset(scalesteps, scaleroot)

upperOctSet = transpose(scaleset, 6);
lowerOctSet = transpose(scaleset, -6);
triOctaveSet = [lowerOctSet(1:7) scaleset upperOctSet(2:8)];
allowedOuterRange = 3;
nset = triOctaveSet((8 - allowedOuterRange):(15 + allowedOuterRange));

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

audiodata = 0.05 * notename2aud(sng1, fa, fs, bpm);
audiodata = audiodata + (0.05 * notename2aud(sng2, fa, fs, bpm));

player = audioplayer(audiodata, fs);
play(player);
% Idle while playing so function doesn't return, destroying the player
% before playback
while isplaying(player)
endwhile