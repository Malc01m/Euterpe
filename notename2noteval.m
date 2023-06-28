% note2noteval - Malcolm Worrell, 2022
% SUMMARY ----------------------------------------------------
% Converts a note name to a number of halfSteps
% relative to A
% PARAMS -------------------------------------------------------
% - note: Note name to be converted. Middle A
%         and following notes are capital letters
%         A-G. Sharps are followed by '#',
%	and flats by 'b'. Octaves above and
%         below are accessed by their number.
%         This makes the A above middle A '1A',
%         and the A below middle A '-1A', for
%         example.
% RETURN -------------------------------------------------------
% - val:  Number of halfSteps relative to A as a
%         signed decimal
% NOTES ---------------------------------------------------------
% - Should B# and E# (which don't exist) be
%   allowed to alias to C and F (as they
%   currently do)?

function val = notename2noteval(note)
    orig = note;

    % Handle sharps and flats by value assigning
    % and discarding
    shFlAdjust = 0;
    if (length(note) > 1)
        if (note(length(note)) == '#')
            shFlAdjust = 0.5;
            note = note(1:(length(note) - 1));
        elseif (note(length(note)) == 'b') && (isalpha(note(length(note) - 1)))
            shFlAdjust = -0.5;
            note = note(1:(length(note) - 1));
        endif
    endif

    % Handle other octaves, discard number
    octAdjust = 0;
    if length(note) > 1
        oct = str2double(note(1:(length(note) - 1)));
        if ~isnan(oct)
            octAdjust = oct * 6;
            note = note(length(note));
        endif
    endif

    % We should be left with a valid letter.
    switch (lower(note))
        case 'a'
            letterAdjust = 0;
        case 'b'
            letterAdjust = 1;
        case 'c'
            letterAdjust = 1.5;
        case 'd'
            letterAdjust = 2.5;
        case 'e'
            letterAdjust = 3.5;
        case 'f'
            letterAdjust = 4;
        case 'g'
            letterAdjust = 5;
        otherwise
            error(['Name "' orig '" is invalid and cannot be converted']);
    endswitch
    val = shFlAdjust + octAdjust + letterAdjust;
endfunction
