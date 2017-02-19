/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> shakers.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// sound chain
Shakers shakers => Pan2 p => dac;

// shakers parameters
7 => shakers.preset;  // sleigh bells

// timing parameter
0.625 => float beat;

// loop
while (true) 
{
       Math.sin(now/1::second*2*pi) => p.pan; // audio panning in sine pattern
       Math.random2f(0.0, 128.0) => shakers.objects;
       Math.random2f(0.0, 1.0) => shakers.decay; 
       1.0 => shakers.energy;
       2.5 => shakers.noteOn;
       <<< "shakers" >>>; 
       beat::second => now;
}
