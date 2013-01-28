# Maggick!

## Requirements

 * bash
 * Imagemagick (recent, might need -fx)
 * for animated gifs or icons from the editor: ffmpeg and gifsicle

## Creating unit icons

 1. Extract btn-unit* (and all files from special cases below) from the appropriate MPQ file and throw them in units/dds/
    The MPQ file will be Starcraft II/Mods/Liberty.SC2Mod/Base.SC2Assets for WoL units.
 2. `cd units && bash gen.sh <size>` for <size> in 32, 48, 76
 3. profit.

### Special cases:

There are no unit buttons for buildings, so you should also copy the following files:

btn-building-terran-planetaryfortress.dds
btn-building-protoss-photoncannon.dds
btn-building-terran-bunker.dds
btn-building-zerg-spinecrawler.dds
btn-building-zerg-sporecrawler.dds
btn-building-terran-autoturret.dds
btn-building-terran-missileturret.dds
btn-building-zerg-nydusworm.dds

Note: they're all already there - these copying instructions are for updates, whenever necessary.

Not that it will matter, but I'd recommend using something like midnight commander or total commander to simply exctract every texture and match the two directories (Shift+F2 in total commander) or just write a quick shellscript (which I didn't have to, because I have the awesome total commander on windows.)