function [audiodataLM, audiodataRM] = mix(audiodataL, audiodataR, mixfactor)
  audiodataLM = audiodataL + (mixfactor * audiodataR);
  audiodataRM = audiodataR + (mixfactor * audiodataL);
end
