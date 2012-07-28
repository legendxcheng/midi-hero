__author__ = 'Legendxcheng'

from music21 import *
ast = 'cdefgab'

partLower = stream.Part()
for o in [3, 4, 5, 6]:
    for i in ast:
        n1 = note.Note(i + '-' + str(o))
        n1.duration.type = 'whole'
        partLower.append(n1)

        n1 = note.Note(i + str(o))
        n1.duration.type = 'whole'
        partLower.append(n1)

        n1 = note.Note(i + '#' + str(o))
        n1.duration.type = 'whole'
        partLower.append(n1)

s = stream.Score()
s.append(partLower)
s.show('midi')