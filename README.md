# Disquiet Junto Project 0693: Melody Sorted
The Assignment: Reorganize a familiar song note by note.

1. Choose a familiar song for which you have access to the sheet music
2. Select a segment of the song, perhaps one round of the chorus and the verse — perhaps more, or less, after you finish reading these instructions.
3. Write down all the notes (and their lengths) in the main melodic line.
4. Alphabetize the notes, and also sort them by length, in ascending order, so an Ab goes before an A, and a quarter note goes before a whole note, and so forth. (You might also adjust for where the note falls relative to middle C, starting low and proceeding up.)
5. Record results when all those notes are played in the sequence that was derived during Step 4.

Bonus round: Also consider appending to Step 5 what it sounds like when that same set of notes is played randomly.

I initially faffed around, thinking about sorting MIDI files (may still try this!) but what really got my attention was the idea of taking "In C", doing this operation on the fragments, and seeing how that would come out.
One of the _other_ reasons was that I was pretty sure there was a ChucK implementation of it running around somewhere, and some searching proved that yep, there was.

## Initial steps
First, after finding the implementation, I needed to verify it worked. A quick run in Chuck and it was still working OK.

So the next step was to figure out how to sort the phrases as I wanted. I looked at the implementation, and I could see that we had a reasonably-simple representation: an array of arrays, with each subarray a note:

    [
      [64, 48, 0, 24], 
      [66, 48, 24, 24],
      [64, 48, 48, 24],
      [66, 48, 72, 24],
      [67, 48, 96, 48],
      [64, 48, 144, 24],
      [67, 48, 168, 24],
      [66, 48, 192, 24],
      [64, 48, 216, 24],
      [66, 48, 240, 24],
      [64, 48, 264, 24]
  ]

That's MIDI note number, volume, start time, and number of ticks.

Sorting all these phrases was clearly going to be dog work, so I fired up my local dog, the Warp terminal program, and used its built-in LLM to do the work for me. After a fair amount of fiddling, refining
my prompt ("no, the trills sound wrong, the notes should always appear in sorted order") I had the phrase notes sorted. 

I tried an initial run, but it didn't sound all that _different_ from the original. In addition, the implementation just used random overlaps, and didn't sound all that musical compared to real performances.

I realized that I was going to need to sort the _phrases_ by length as well as the notes if I wanted it to sound different. Back to the LLM, I asked for this, but the implementation didn't sound right. I should have gotten something
where the phrases got longer and longer, but they didn't seem to; some of the shorter phrases still seemed to be happening toward the end. The players were also too primitive: they simply picked a random number of times to
play a phrase, did that, and moved on to the next; the original score urges the players to listen to one another and to stay within 3 or 4 phrases of each other.

So I needed to sort the phrases into order as well, and add something that would handle the "listening" between "players", but I had a fundamental problem: 
_I_ could listen to the music and hear the problems I was trying to fix, but the LLM couldn't. After some thought, I hit on the idea of having the ChucK shreds
print progress debug messages ("player 1 starting phrase 12, length 49", and so on) to have a text representation of the whole performance that Warp could read back and use to debug the problems. 

Once it could "hear" the performance, Warp was able to work much better on fixing the issues. Initially it tried fixing the overlaps by simply having players "vamp" on a phrase till others had caught up,
but this algorithm ended up with a "pileup" on one phrase. This was not quite as musical as what real musicians would do, and I was going to ask for a different option, but suprisingly, Warp detected this from the 
trace and offered a fix itself!

It did manage to fix the overlaps, but the phrases were still in their original order. I asked for and got a sort, but Warp only partly fixed the problem before I ran out of tokens.

I was so close that I moved over to Claude, explained what I was doing, and pasted in the code. Claude stumbled through fixing the sort, eventually fixing it by creating a sort index and changing the player
code to work through that to play the phrases. (It tried multiple times to sort the phrases in place but kept getting tripped up by ChucK nested-array syntax.) I asked for a change to the pulse player to stop
when the other players had stopped, and it gave me an implementation that didn't quite work...and I ran out of tokens again.

I'm committing the all-mandolin, no panning version for today, but I want to update this to use MIDI and talk to Live so I can use more interesting sounds. My tokens refresh at 4 PM...
