// ChucK Performance of Terry Riley's 'In C'
//
// In this famous canon by composer Terry Riley, each performer is given the
// same set of phrases.
//
// Each performer repeats each phrase a random number of times before moving
// on to the next phrase.
//
// A single player keeps time by playing a pulse beat
// When all the players are done, the pulse continues for a while, and then stops.
//
// ChucK port 11/2006 -- Jim Bumgardner
// Original Perl Program 9/2004 -- Jim Bumgardner


// With these settings, ChucK produces about 14 minutes of music.
// A more typical 'In C' performance is 20-60 minutes.  Increase the
// min/max repetitions to achieve this...
//
240 => float bps;     // ticks/second
4 => int minRepeats;  // minimum times to repeat a phrase
10 => int maxRepeats; // maximum times to repeat a phrase

 [new StifKarp,
 new StifKarp,
 new StifKarp,
 new StifKarp,
 new StifKarp,
 new StifKarp,
 new Mandolin,
 new Mandolin,
 new Mandolin,
 new Mandolin,
 new Mandolin] @=> StkInstrument players[];

1.0/players.cap() => float mainGain;

[
  // midi pitch, vol, start-ticks, dur-ticks
  [72, 50, 0, 48],
  [72, 50, 48, 48],
  [72, 50, 96, 48],
  [72, 50, 144, 48],
  [72, 50, 192, 48],
  [72, 50, 240, 48],
  [72, 50, 288, 48],
  [72, 50, 336, 48]
] @=> int pulsePhrase[][];

// Phrases transcribed from 'In C' by Terry Riley
[
[
  // midi pitch, vol, start-ticks, dur-ticks
  [0, 63, 0, 96]
],
[
  [60, 63, 0, 6],
  [60, 63, 6, 6],
  [60, 63, 12, 6],
  [64, 63, 18, 90],
  [64, 63, 108, 90],
  [64, 63, 198, 90]
],
[
  [60, 63, 0, 6],
  [64, 63, 6, 42], 
  [64, 63, 48, 96],
  [65, 63, 144, 48]
],
[
  [0, 63, 0, 48],
  [64, 63, 48, 48],
  [64, 63, 96, 48],
  [65, 63, 144, 48]
],
[
  [0, 63, 0, 48],
  [64, 63, 48, 48],
  [65, 63, 96, 48],
  [67, 63, 144, 48]
],
[
  [0, 63, 0, 48],
  [64, 63, 48, 48],
  [65, 63, 96, 48],
  [67, 63, 144, 48]
],
[
  [72, 63, 0, 768]
],
[
  [0, 63, 0, 336],
  [0, 63, 432, 432],
  [60, 63, 336, 24],
  [60, 63, 360, 24],
  [60, 63, 384, 48]
],
[
  [65, 63, 0, 768],
  [67, 63, 768, 576]
],
[
  [0, 63, 0, 336],
  [67, 63, 336, 24],
  [71, 63, 360, 24]
],
[
  [67, 48, 0, 24],
  [71, 48, 24, 24]
],
[
  [65, 48, 0, 24],     // lowest note
  [67, 48, 24, 72],    // all 67s combined
  [71, 48, 96, 48]     // highest note
],
[
  [65, 63, 0, 48],
  [67, 63, 48, 48],
  [71, 63, 96, 384],
  [72, 63, 480, 96]
],
[
  [0, 63, 0, 72],
  [65, 63, 72, 24],
  [67, 63, 96, 72],
  [67, 63, 168, 24],
  [67, 63, 192, 48],
  [67, 63, 240, 312],
  [71, 63, 552, 24]
],
[
  [66, 63, 0, 384],
  [67, 63, 384, 384],
  [71, 63, 768, 384],
  [72, 63, 1152, 384]
],
[
  [0, 63, 0, 360],
  [67, 63, 360, 24]
],
[
  [67, 48, 0, 24],
  [71, 48, 24, 24],
  [71, 48, 48, 24],
  [72, 48, 72, 24]
],
[
  [0, 48, 0, 24],
  [71, 48, 24, 24],
  [71, 48, 48, 24],
  [71, 48, 72, 24],
  [72, 48, 96, 24],
  [72, 48, 120, 24]
],
[
  [64, 48, 0, 24],
  [64, 48, 24, 24],
  [64, 48, 48, 24],
  [64, 48, 72, 72],
  [66, 48, 144, 24],
  [66, 48, 168, 24]
],
[
  [0, 63, 0, 144],
  [67, 63, 144, 144]
],
[
  [55, 48, 0, 72],
  [64, 48, 72, 24],
  [64, 48, 96, 24],
  [64, 48, 120, 24],
  [64, 48, 144, 24],
  [64, 48, 168, 24],
  [66, 48, 192, 24],
  [66, 48, 216, 24],
  [66, 48, 240, 24],
  [66, 48, 264, 24]
],
[
  [66, 63, 0, 288]
],
[
  [64, 63, 0, 144],
  [64, 63, 144, 144],
  [64, 63, 288, 144],
  [64, 63, 432, 144],
  [64, 63, 576, 144],
  [66, 63, 720, 144],
  [67, 63, 864, 144],
  [69, 63, 1008, 144],
  [71, 63, 1152, 48]
],
[
  [64, 63, 0, 48],
  [66, 63, 48, 144],
  [66, 63, 192, 144],
  [66, 63, 336, 144],
  [66, 63, 480, 144],
  [66, 63, 624, 144],
  [67, 63, 768, 144],
  [69, 63, 912, 144],
  [71, 63, 1056, 96]
],
[
  [64, 63, 0, 48],
  [66, 63, 48, 48],
  [67, 63, 96, 144],
  [67, 63, 240, 144],
  [67, 63, 384, 144],
  [67, 63, 528, 144],
  [67, 63, 672, 144],
  [69, 63, 816, 144],
  [71, 63, 960, 48]
],
[
  [64, 63, 0, 48],
  [66, 63, 48, 48],
  [67, 63, 96, 48],
  [69, 63, 144, 144],
  [69, 63, 288, 144],
  [69, 63, 432, 144],
  [69, 63, 576, 144],
  [69, 63, 720, 144],
  [71, 63, 864, 144]
],
[
  [64, 63, 0, 48],
  [66, 63, 48, 48],
  [67, 63, 96, 48],
  [69, 63, 144, 48],
  [71, 63, 192, 144],
  [71, 63, 336, 144],
  [71, 63, 480, 144],
  [71, 63, 624, 144],
  [71, 63, 768, 144]
],
[
  [64, 48, 0, 24],
  [64, 48, 24, 24],
  [64, 48, 48, 24],
  [64, 48, 72, 24],
  [64, 48, 96, 24],
  [66, 48, 120, 24],
  [66, 48, 144, 24],
  [66, 48, 168, 24],
  [66, 48, 192, 24],
  [67, 48, 216, 48],
  [67, 48, 264, 24]
],
[
  [64, 48, 0, 24],
  [64, 48, 24, 24],
  [64, 48, 48, 24],
  [64, 48, 72, 72],
  [66, 48, 144, 24],
  [66, 48, 168, 24]
],
[
  [64, 63, 0, 288],
  [67, 63, 288, 288],
  [72, 63, 576, 288]
],
[
  [72, 63, 0, 576]
],
[
  [65, 48, 0, 24],     // lowest note
  [67, 48, 24, 72],    // all 67s combined
  [71, 48, 96, 48]     // highest note
],
[
  [65, 48, 0, 24],
  [65, 48, 24, 24],
  [65, 48, 48, 312],
  [67, 48, 360, 24],
  [67, 48, 384, 24],
  [67, 48, 408, 144],
  [71, 48, 552, 24]
],
[
  [0, 63, 0, 48],
  [65, 63, 48, 24],
  [67, 63, 72, 24]
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24]
],
[
  [0, 48, 0, 336],
  [0, 63, 336, 240],
  [65, 48, 576, 24],
  [67, 48, 600, 24],
  [67, 48, 624, 24],
  [67, 48, 648, 24],
  [67, 48, 672, 24],
  [67, 48, 696, 24],
  [70, 63, 720, 96],
  [71, 48, 816, 24],
  [71, 48, 840, 24],
  [71, 48, 864, 24],
  [71, 48, 888, 24],
  [76, 63, 912, 288],
  [76, 63, 1200, 240],
  [77, 63, 1440, 576],
  [78, 63, 2016, 336],
  [79, 63, 2352, 288],
  [79, 63, 2640, 96],
  [79, 63, 2736, 48],
  [79, 63, 2784, 48],
  [81, 63, 2832, 48],
  [81, 63, 2880, 144],
  [83, 63, 3024, 48]
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24],
  [67, 48, 48, 24],
  [67, 48, 72, 24],
  [71, 48, 96, 24],
  [71, 48, 120, 24]
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24]
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24],
  [71, 48, 48, 24]
],
[
  [65, 48, 0, 24],     // lowest note
  [67, 48, 24, 48],    // all 67s combined
  [71, 48, 72, 48],    // all 71s combined
  [72, 48, 120, 24]    // highest note
],
[
  [65, 48, 0, 24],
  [71, 48, 24, 24]
],
[
  [67, 48, 0, 24],
  [71, 48, 24, 24]
],
[
  [69, 63, 0, 384],
  [71, 63, 384, 384],
  [72, 63, 768, 384],
  [72, 63, 1152, 384]
],
[
  [64, 48, 0, 96],
  [64, 48, 96, 96],
  [64, 48, 192, 48],
  [64, 48, 240, 48],
  [64, 48, 288, 48],
  [64, 48, 336, 24],
  [65, 48, 360, 96],
  [65, 48, 456, 96],
  [65, 48, 552, 24]
],
[
  [72, 63, 0, 96],
  [76, 63, 96, 96],
  [76, 63, 192, 48],
  [77, 63, 240, 48]
],
[
  [67, 63, 0, 96],
  [74, 63, 96, 96],
  [74, 63, 192, 96]
],
[
  [0, 48, 0, 48],
  [0, 48, 48, 48],
  [0, 48, 96, 48],
  [67, 48, 144, 24],
  [67, 48, 168, 48],
  [67, 48, 216, 48],
  [67, 48, 264, 48],
  [67, 48, 312, 24],
  [74, 48, 336, 24],
  [74, 48, 360, 24],
  [74, 48, 384, 24],
  [76, 48, 408, 24],
  [76, 48, 432, 24]
],
[
  [74, 63, 0, 24],
  [74, 63, 24, 48],
  [76, 63, 72, 24]
],
[
  [65, 63, 0, 480],
  [67, 63, 480, 576],
  [67, 63, 1056, 384]
],
[
  [65, 48, 0, 24],     // lowest note
  [67, 48, 24, 72],    // all 67s combined
  [70, 48, 96, 48]     // highest note
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24]
],
[
  [65, 48, 0, 24],
  [67, 48, 24, 24],
  [70, 48, 48, 24]
],
[
  [67, 48, 0, 24],
  [70, 48, 24, 24]
],
[
  [67, 48, 0, 24],
  [70, 48, 24, 24]
]
] @=> int originalPhraseList[][][];

// Calculate length of each phrase and create a sorted index
int phraseIndex[originalPhraseList.cap()];
int phraseLengths[originalPhraseList.cap()];

fun int phraseLength(int ph[][])
{
   return ph[ph.cap()-1][2] + ph[ph.cap()-1][3];
}

// Initialize phrase index and calculate lengths
for (0 => int i; i < originalPhraseList.cap(); i++) {
   i => phraseIndex[i];
   phraseLength(originalPhraseList[i]) => phraseLengths[i];
   
   // Debug for long phrases to verify they're being identified
   if (originalPhraseList[i].cap() > 0 && (phraseLengths[i] > 500)) {
       <<< "Found long phrase at index", i, "length:", phraseLengths[i], "ticks" >>>;
   }
}

// Sort phrases by length, shortest to longest
for (0 => int i; i < originalPhraseList.cap(); i++) {
   for (0 => int j; j < originalPhraseList.cap() - i - 1; j++) {
      if (phraseLengths[j] > phraseLengths[j+1]) {  // Changed to > for ascending order
         // Swap lengths
         phraseLengths[j] => int tempLength;
         phraseLengths[j+1] => phraseLengths[j];
         tempLength => phraseLengths[j+1];
         
         // Swap indices
         phraseIndex[j] => int tempIndex;
         phraseIndex[j+1] => phraseIndex[j];
         tempIndex => phraseIndex[j+1];
      }
   }
}

players.cap() => int playersIn;
1 => int pulseIsPlaying;

// Array to track current phrase for each player
int playerPhrases[players.cap()];

// Initialize all players at phrase 0
for (0 => int i; i < players.cap(); i++) {
    0 => playerPhrases[i];
}

// Function to check if a player should wait before moving to next phrase
fun int shouldWait(int currentPlayer, int nextPhrase) {
    // Allow gap to grow as piece progresses
    // FIX: Use Std.ftoi for proper type conversion
    Std.ftoi(4 + Math.floor(nextPhrase/10.0)) => int maxGap;
    
    for (0 => int i; i < players.cap(); i++) {
        if (i != currentPlayer && i > 0) {  // Skip pulse player (0) and self
            if (nextPhrase - playerPhrases[i] > maxGap) {
                return true;  // Too far ahead, should wait
            }
        }
    }
    return false;  // OK to proceed
}

// Function to update player's current phrase
fun void updatePlayerPhrase(int player, int phrase) {
    phrase => playerPhrases[player];
}


fun void playPhrase(int ph[][], StkInstrument voc)
{
  for (0 => int i; i < ph.cap(); ++i)
  {
   if (ph[i][0] > 0) {
     // convert midi-note to frequency
     Std.mtof(ph[i][0]) => voc.freq;
     // convert midi-vol to gain (and randomize it a bit)
     (mainGain*ph[i][1]+Std.rand2(0,9)-4)/127.0 => voc.gain;
   }
   else {
      // rest
      0 => voc.gain;
   }
   1 => voc.noteOn;
   // wait til next note...
   (ph[i][3]/bps)::second => now;
   1 => voc.noteOff;
    if (i+1 < ph.cap())
   {
      if ((ph[i+1][2] - ph[i][2]) > ph[i][3])
        ((ph[i+1][2] - (ph[i][2]+ph[i][3]))/bps)::second => now;
    }
  }    
}

// Repeat a particular phrase N times
fun void repeatPhrase(int ph[][], int n, int player)
{
  if (player >= players.cap())
  {
     <<< "Bad Player!" >>>;
  }    
   
  players[player] @=> StkInstrument voc;
  0 => voc.gain;
  20 => voc.freq;
  phraseLength(ph) => float totBeats;
  
  // Debug long duration phrases
  if (ph.cap() > 0 && ph[0][3] > 300) {
      <<< "Player", player, "playing long duration phrase, length:", totBeats >>>;
  }
  
  for (0 => int pp; pp < n; ++pp)
  {
    playPhrase(ph, voc);
  }      
}

// Performance by a single player
// play each phrase a random number of times
// Instead of creating a new sorted array, we'll just reference the original phrases
// through our sorted phraseIndex

// And modify the doRileyPart function to use this indirection:
fun void doRileyPart(int player)
{
    for (0 => int p; p < phraseIndex.cap(); ++p) {
        // Get the actual phrase index from our sorted list
        phraseIndex[p] => int actualPhraseIndex;

        // Wait if we're getting too far ahead of other players
        while(shouldWait(player, p)) {
            <<< "Player", player, "waiting before phrase", p, "to stay with ensemble" >>>;
            0.1::second => now;
            if (shouldWait(player, p)) {
                0.4::second => now;
            }
        }

        // Update our current phrase position
        updatePlayerPhrase(player, p);

        // Print phrase info
        <<< "Player", player, "starting phrase", p, "length:", phraseLength(originalPhraseList[actualPhraseIndex]),
            "original index:", actualPhraseIndex >>>;

        // Special debug for very long notes
        if (originalPhraseList[actualPhraseIndex].cap() > 0 &&
            phraseLength(originalPhraseList[actualPhraseIndex]) > 500) {
            <<< "  **** LONG PHRASE ALERT ****" >>>;
        }

        Std.rand2(minRepeats,maxRepeats) => int nTimes;

        // Play the phrase from the original list using our sorted index
        repeatPhrase(originalPhraseList[actualPhraseIndex], nTimes, player);
    }
    <<< "Player", player, "finished all phrases" >>>;
    --playersIn;
}

// Performance by the Pulse player
fun void doPulse()
{
  do {
     repeatPhrase(pulsePhrase, 1, 0);
  } while (playersIn > 0);
  
  // Continue playing pulse for ~8 seconds after all players finish
  // Calculate how many repeats of the pulse pattern equals ~8 seconds
  8::second => dur continueTime;
  phraseLength(pulsePhrase)/bps => float pulseTimeInSeconds;
  Math.ceil(8.0/pulseTimeInSeconds) => float continueRepeats;
  
  <<< "All players finished! Continuing pulse for", continueTime/second, "seconds,", 
      Std.ftoi(continueRepeats), "repeats" >>>;
  
  // Play the additional pulses
  repeatPhrase(pulsePhrase, Std.ftoi(continueRepeats), 0);
  
  0 => pulseIsPlaying; // Notification that we have stopped
}

// Performance by all non-pulse players
fun void doRileyParts()
{
  for (1 => int p; p < players.cap(); ++p)
    spork ~ doRileyPart(p);
}

for (0 => int i; i < players.cap(); ++i)
{
 players[i] => dac;
 0 => players[i].gain;
}

// Start the Pulse
spork ~ doPulse();

// Let him go for a bit...
(phraseLength(pulsePhrase)*4/bps)::second => now;

// Start up all the players
doRileyParts();

// Let time elapse until the pulse stops
do {
  1::second => now;
} while (pulseIsPlaying);
