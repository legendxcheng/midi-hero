__author__ = 'Legendxcheng'
# This python file is designed to parse .mid file into .json file.
# The structure of the json file is below:
# number of notes
# note start time duration

# scan entire folder

import string
import os
import json
from music21 import *

ores = []
ii = 0
faddr2 = 0
# delve in a part of the element
# until it is note then write it out
def delveIn(n):
    #print n
    global ores
    if (isinstance(n, note.Note)):
        try:
            
            ounit = {}
            ounit['start'] = n.offset
            ounit['end'] = n.offset + n.seconds
            ounit['pitch'] = n.pitch.name
            ounit['octave'] = n.octave
            #print n.duration
            #print len(ores)
            ores.append(ounit)
            
            return False
        except Exception as e:
            pass
    elif (isinstance(n, stream.Voice)):
        ores = []
        for kk in n:
            delveIn(kk)
        writeJson()
        return True
    elif (isinstance(n, chord.Chord)):
        for kk in n:
            delveIn(kk)
            return False
            break
    elif (isinstance(n, stream.Part)):
        ores = []
        flag = False
        for kk in n:
            if (delveIn(kk)):
                flag = True
        if (not flag):
            writeJson()
    pass

def writeJson():
    global faddr2
    global ii
    ii += 1
    global ores
    f = open(faddr2 + str(ii) + '.jsn', 'w') # open for 'w'riting
    f.write(json.dumps(ores, indent=4)) # write text to file
    f.close() # close the file


def processMidi(faddr1, faddr2):
    s = converter.parse(faddr1)
    #s.show('midi')

    print s
    #s = converter.parse(faddr1)
    # s is a score
    # s is comprised of part
    # part is comprised of notes and so on
    for p in s:
        print p
        global ores
        ores = []
        delveIn(p)
                
       
    #print json.dumps(ores)

def scanFolder(addr, addr2):
    global faddr2
    list_dirs = os.walk(addr)
    for root, dirs, files in list_dirs:
        #for d in dirs:
        #    print os.path.join(root, d)
        #for f in files:
        #    print os.path.join(root, f)
        for f in files:
            # get file
            faddr = os.path.join(root, f)
            faddr2 = os.path.join(addr2, f)
            faddr2 = faddr2.replace('.mid', '')
            processMidi(faddr, faddr2)
            print 'done file'
    pass

def main():
    # test function processMidi
    scanFolder('F:\\MidiHero\\midi-hero\\trunk\\musicResource', 'F:\\midijson')


main()