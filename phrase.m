function outPhrase = phrase(noteSet, choiceType, numUniqueMeasures, numReps, notesPerMeasure)
  outPhrase = [];
  for i = 1:numUniqueMeasures
    if strcmpi(choiceType, 'rand')
      measure = noteSet(randi(length(noteSet), notesPerMeasure, 1));
    end
    oneMeasureReps = repmat(measure, 1, numReps);
    outPhrase = [outPhrase oneMeasureReps];
  endfor
end
