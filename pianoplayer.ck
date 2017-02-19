/*----------------------------------------------------------------------- 
   Title: FinalScoreExp -> pianoplayer.ck
   Length: 60 seconds
-------------------------------------------------------------------------*/

// PianoPlayer Class

public class PianoPlayer 
{
    
    // an array of four piano keys connected up
    Rhodey p[4];
    p[0] => JCRev rev => Gain master => dac;
    p[1] => rev;
    p[2] => rev;
    p[3] => rev;
    0.02 => rev.mix;
    
    // function to set all four key frequencies 
    fun void freqs(float gKey, float aKey, float dKey, float eKey)
    {
        p[0].freq(gKey);
        p[1].freq(aKey);
        p[2].freq(dKey);
        p[3].freq(eKey);
    }
    
    // function to set all four key notes        
    fun void notes(int gNote, int aNote, int dNote, int eNote)  
    {
        p[0].freq(Std.mtof(gNote));
        p[1].freq(Std.mtof(aNote));
        p[2].freq(Std.mtof(dNote));
        p[3].freq(Std.mtof(eNote));
    }
         
    // function chords
    fun void chord(string which)  
    {
        if (which == "G") 
        {
            this.notes(55,62,71,79);
        }
        if (which == "A") 
        {
            this.notes(57,60,64,78); 
        }
        if (which == "D")
        {     
            this.notes(55,64,72,79); 
        }
        if (which == "E") 
        {
            this.notes(57,62,69,78); 
        }
    }
    
    // function arpeggio
    fun void arpeggio(string chord, dur rate) 
    {
        this.chord(chord);
        for (0 => int i; i < 4; i++)  
        {
            1 => p[i].noteOn;
            rate => now;
        }
    }

}   
