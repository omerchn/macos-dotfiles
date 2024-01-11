# .dotfiles

To initilize in a new computer, run:
```bash
git clone --separate-git-dir=~/.cfg https://github.com/omercohen990/.dotfiles ~
```

or to clone to a tmp folder:
```bash
git clone --separate-git-dir=$HOME/.cfg https://github.com/omercohen990/.dotfiles $HOME/cfg-tmp
rm -r ~/cfg-tmp/
```

then run:
```bash
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
config config --local status.showUntrackedFiles no
```
