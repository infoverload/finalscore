/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> drums.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// sound chain
SndBuf snare => dac;
SndBuf hihat => dac;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;
me.dir(-1) + "/audio/hihat_01.wav" => hihat.read;

// set drum parameters
1.5 => snare.gain;
1.0 => hihat.gain;
snare.samples() => snare.pos;
snare.samples() => hihat.pos;


// function hihatThread
fun void hihatThread()
{
    while ( true )  
    {
        Math.random2f(0.2, 0.4) => hihat.gain;
        Math.random2f(0.9, 1.2) => hihat.rate;
        (Math.random2(1,2) * 0.2) :: second => now;
        0 => hihat.pos;
        <<< "hihat" >>>;
    }
}

// spork hihat() as a child shred
spork ~ hihatThread();

// loop
while ( true )  
{
        Math.random2f(0.3, 0.6) => snare.gain;
        Math.random2f(0.9, 1.2) => snare.rate;
        (Math.random2(1,2) * 0.4) :: second => now;
        0 => snare.pos;
    
    <<< "snare" >>>;
}    
