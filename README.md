# my-omarchy-dotfiles
My personal dotfiles/configs for my omarchy setup
These exist in case I ever screw up in the future :D

I am not sure if these will work if you don't run Omarchy, you can probably get it to work. If you do use Omarchy, these should work if you drop em in the right place & have the dependencies installed

*I will also not provide Support.*

Libraries i used to get this to look the way it looks:
###### https://github.com/jvc84/wayves/tree/main
`wayves` (equalizer bars in toolbar)
needs -> `python, bc, cava`

`spark` (generates spark graphs ▁▂▄▆█ in the commandline)

Everything else comes preinstalled with Omarchy (hyprland, waybar, walker, etc.)

Extensively used https://github.com/luke-beep/awesome-nord for the color scheme, as well as a 'Nord' Omarchy theme which comes preinstalled with most of those listed Official Ports

Some of the changes I made to waybar:
* Included the built-in `wlr/taskbar` module which displays my open windows in a dock at the bottom of the screen
* Included the built-in `mpris` module which lets me interact with any music/media that's being played, as well as display some information about it
* 5 custom 'spark' modules at the top to monitor CPU, GPU, RAM & Internet Speeds at a glance
* Custom 'start menu' module which currently just reloads my configs
* Current Time & Date moved to bottom-right & Temperature for my region
* Modified the 3 indicator scripts that come with Omarchy to be more visibe. Screen Recording module now displays the File Size of the recording.
* 3 custom 'color' modules at the bottom-right that let me interact with css colors directly from my bottom bar (lighten / darken the shade, slightly expandable). They automatically show/hide themselves when appropriate by modifying one txt file that holds the last color you copied

I also extensively changed the styling & css for the most part, so everything is a little more distinct

Probably missed something, sorry