/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> bass.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// sound chain 
Mandolin bass => NRev reverb => dac; // mandolin for bass

// the C Ionian mode
[48,50,52,53,55,57,59,60] @=> int melody[]; 

// audio effect setup - set reverb mix
0.1 => reverb.mix;

// bass setup 
0.0 => bass.stringDamping;
0.02 => bass.stringDetune;
0.05 => bass.bodySize;
0.5 => bass.gain;

1 => int position;

// loop
while ( true )  
{
    <<< "bass" >>>;   
    Math.random2(-1, 1) +=> position;  
    if (position < 0) 
    {  
        1 => position;
    }    
    if (position >= melody.cap() ) 
    {
        melody.cap() - 2 => position;
    }
    Std.mtof(melody[position] - 12) => bass.freq;
    
    Math.random2f(0.05, 0.5) => bass.pluckPos;
    1 => bass.noteOn;
    0.5 :: second => now;
    1 => bass.noteOff;
    0.05 :: second => now;
    
}


