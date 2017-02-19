/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> initialize.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// print title
<<< "FinalScoreExp" >>>;

// add classes 
me.dir() + "/BPM.ck" => string BPMPath;
Machine.add(BPMPath);

me.dir() + "/pianoplayer.ck" => string PianoPlayerPath;
Machine.add(PianoPlayerPath);

// add score.ck
me.dir() + "/score.ck" => string scorePath;
Machine.add(scorePath);