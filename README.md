# Dylan's .dotfiles

## Clone Repository

```shell
git clone https://github.com/eldyl/.dotfiles.git
git submodule update --init --recursive
```

## Install Stow

Arch
```shell
pacman -Sy stow
```
Debian
```shell
apt-get install stow
```
macOS
```shell
brew install stow
```

## Commonly Used

Set Full Development Environment
```shell
stow -Sv shell wezterm nvim
```
Install Fonts on Linux
```shell
./scripts/stow/stow_fonts.sh
```

## Inspired By

- [tjdevries](https://github.com/tjdevries/tjdevries)
- [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles)
- [jonhoo](https://github.com/jonhoo/configs/tree/master)
