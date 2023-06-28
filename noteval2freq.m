% noteval2freq - Malcolm Worrell, 2022
% SUMMARY ----------------------------------------------------
% Converts a note value to a frequency
% PARAMS -------------------------------------------------------
% - fa:      The frequency assigned to middle A
% - noteval: The number of halfSteps relative to
%            middle A, given by note2noteval
% RETURN -------------------------------------------------------
% - freq:    The frequency of the note

function freq = noteval2freq(fa, noteval)
    freq = fa * (2^(1/12))^(noteval * 2);
endfunction
