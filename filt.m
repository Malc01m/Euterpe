function audioDataOut = filt(audioDataIn, type, nsamp)
  nsamp_div2 = nsamp / 2;
  switch (type)
    case "lp_step"
        nsamp_div4 = nsamp / 4;
        ker = [repmat(0, 1, nsamp_div2), repmat(0.1, 1, nsamp_div4), repmat(0, 1, nsamp_div4)];
    case "lp_exp"
        ker = [repmat(0, 1, nsamp_div2), exp(linspace(0,-10,nsamp_div2)) - 1];
    case "lp_sinc"
        ker = sin(-nsamp_div2:nsamp_div2) ./ (-nsamp_div2:nsamp_div2);
  endswitch
  audioDataOut = conv(audioDataIn, ker, "same");
endfunction
