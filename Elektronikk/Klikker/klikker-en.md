<!-- {{{
vim:ts=4:sw=4:sts=4:et:ai:si:fdm=marker:tw=100
}}} -->

A friend of mine wanted turn a symbol for his new ebike. I found one from Ali, it was ok, but it gave a horrible sound when the turn symbol was alight. Finding it was no way to turn that shit off, I opened it and ripped out the piezo element to shut it up for good. All well installed, my friend noted that it'd be nice to know if it was flashing. The lights came with a remote, presumably something 433MHz, but apparently only simplex communication, no feedback whatsoever. So I thought, well, all cars make a click sound, although they stopped using mechanical relays years ago, they still stick to the sound, because that's what people know. Same way as with your iPhone making a sound of the mirror slapping and then the film winding, just because people think that's the way a camera should sound. So, I found a 3,3V relay, connected it to the piezo output and the relay played a very low, lousy, beep when the light was lit. So, guessing this was just a square wave, I added a 220µF cap in parallel with the relay and it worked. I added an 1N4007 in reverse as well as flyback diode, just to save the electronics for a potential strike from the relay. It may not be a very loud click, but it certainy is one! I then made and 3d printed a small box to slightly protect it againstthe elements.

I'm pretty satisfied :)

[Before](https://karlsbakk.net/blinklys/blinklys1.mp4)
[After](https://karlsbakk.net/blinklys/blinklys2.mp4)
