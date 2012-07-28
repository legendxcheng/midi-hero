__author__ = 'Legendxcheng'

from music21 import *
s = converter.parse('zzz.mid')
print s
for k in s:
    for j in k:
        #if (j.isNote):
        #    print 'Note:'
        #elif (j.isRest):
        #    print 'Rest:'
        pass
    print k
    k = k.notesAndRests

    sum = 0
    for k in s:
        for j in k:
            #if (j.isNote):
            #    print 'Note:'
            #elif (j.isRest):
            #    print 'Rest:'
            print j
            sum += j.seconds
        break
s.show('midi')
print sum
#s.show('midi')
