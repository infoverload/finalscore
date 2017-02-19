/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> sitar.ck
   Length: 60 seconds 
-------------------------------------------------------------------------*/

// sound chain
Sitar sitar => Gain sitarGain => Gain master => dac;
sitarGain => Gain sitarFeedback => Delay delay => sitarGain;
SinOsc sin => dac;

// set volume
1.3 => master.gain;
0 => sin.gain;

// the Db Phrygian mode
[49,50,52,54,56,57,59,61] @=> int melody_db[]; 

// timing parameter
0.75 => float beat;

// sitar feedback parameters
beat::second => delay.max;
beat::second => delay.delay;
0.5 => sitarFeedback.gain;

// loop
while( true )
{
    // time variation
    Math.random2f(0.5,1.5) => float beatFactor;
    
    // loop
    for (0 => int i; i < melody_db.cap(); i++)
    {
        // sitar control
        Std.mtof(melody_db[Math.random2(0, melody_db.cap()-1)]) => sitar.freq;
        sitar.noteOn(Math.randomf());
        <<< "sitar" >>>;
               
        // notes from scale
        0.6 => sin.gain;
        Math.random2(0, melody_db.cap()-1) => int whichnote;
        Std.mtof(melody_db[whichnote] - 12) => sin.freq;  // MIDI to frequency        
        
        // advance time
        beat::second*beatFactor => now;
    }
    
}
