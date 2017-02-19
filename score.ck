/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> score.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// paths to chuck files
me.dir() + "/sitar.ck" => string sitarPath;
me.dir() + "/shakers.ck" => string shakersPath;
me.dir() + "/bass.ck" => string bassPath;
me.dir() + "/drums.ck" => string drumsPath;

// define tempo object of class BPM
BPM tempo; 
tempo.tempo(120.0);

// tempo
10.0 => float beat;

SinOsc chord[3];
Gain master => dac;

// function playMajorChord
fun void playMajorChord(int root)
{   
    // root
    Std.mtof(root) => chord[0].freq;
    
    // third
    Std.mtof(root+4) => chord[1].freq;
    
    // fifth
    Std.mtof(root+7) => chord[2].freq; 
    
    0.75::second => now;
}

// MAIN SCORE

// use array to chuck unit generator to master
for (0 => int i; i < chord.cap(); i++)
{
    chord[i] => master;
    1.0/chord.cap() => chord[i].gain;
}

now + 6::second => time later;
while( now < later )
{    
    playMajorChord(59);
    playMajorChord(56);
    playMajorChord(52);
    playMajorChord(49);
    playMajorChord(56);
    playMajorChord(52);
}
0 => master.gain;

// start sitar
Machine.add(sitarPath) => int sitarID;
beat::second => now;

// start drums
Machine.add(drumsPath) => int drumsID;
beat::second => now;

// remove sitar
Machine.remove(sitarID);

// start bass and shakers
Machine.add(bassPath) => int bassID; 
Machine.add(shakersPath) => int shakersID;
16.0 * tempo.quarterNote => now;

// -------start piano solo-------

PianoPlayer p; // make a PianoPlayer object

// declare data for chording and strumming
["G","D","A","E","A","G","E","G","A","G","E","D"] @=> string chords[];
[0.4,0.4,0.4,0.2,0.4,0.2,0.4,0.5,0.2,0.4,0.4,0.7] @=> float duration[]; 

// play the arpeggio of the chords, reading through the arrays
0 => int counter;
while (counter < chords.cap())  
{
    p.arpeggio(chords[counter], duration[counter]::second);
    counter++;
}
// -------end piano solo-------

// remove bass and shakers
Machine.remove(bassID);
Machine.remove(shakersID);
0.4*beat::second => now;

// remove drums
Machine.remove(drumsID);
