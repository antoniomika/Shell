Shell
===========
### Trying to make the most awesome shell

## Installation Instructions
1. Clone this repo anywhere (most likely in `~/`)
    - `git clone https://github.com/antoniomika/Shell ~/Shell`
2. Change directory into the repo
    - `cd ~/Shell`
3. Run the init script
    - `./init.sh`
4. Run zsh and see if you like it
    - `zsh`
5. Install a patched font for the pretty stuff
    1. Go [here](https://github.com/powerline/fonts) to get fonts (I highly recommend [Source Code Pro](https://github.com/powerline/fonts/raw/master/SourceCodePro/Sauce%20Code%20Powerline%20Regular.otf) and I describe how to set it up)
    2. Once you download the font, click to open it in FontBook, then press the install font button towards the bottom right
    3. Open iTerm's (not gonna describe how to do it in Terminal.app) preferences (CMD+,). Click Profiles.
    4. Click the default profile from the list. Go to the Text tab.
    5. For both `Font` and `Non-ASCII Font`, select Source Code Pro For Powerline Regular (or your font).
    7. The command line should be prettier.
6. If you don't like it, everything is installed locally. You can remove the folders and you're set
    - `rm -rf ~/.config/powerline ~/.logs ~/.oh-my-zsh ~/Shell ~/.zsh_history ~/.zshrc ~/.zsh-update ~/.zcompdump* ~/.z && pip uninstall powerline-status && exit`
7. If you do like it, change your shell!
    - `chsh -s /bin/zsh`

