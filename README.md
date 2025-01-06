![image](https://github.com/user-attachments/assets/d8e39426-0bdd-48ea-a9da-ee73e01634a1)
![image](https://github.com/user-attachments/assets/c41d072d-64d3-4a45-921b-12d5604a04b9)

# My sway minimalist rice

To enjoy this experience:
```bash
sudo pacman -S sway swaylock swaybg swayidle waybar mako pavucontrol brightnessctl playerctl kitty ttf-jetbrains-mono-nerd
paru -S sway-desktop-launcher sway-audio-idle-inhibit swayosd-git
sudo systemctl enable --now swayosd-libinput-backend.service
git clone https://github.com/lasashq/antoine_sway && rm -rf antoine_sway/.git
cp -rf antoine_sway/* ~
reboot
```

My enabled systemd daemons:
Apps:
+ WM: sway
+ Bar: waybar
+ terminal emulator: kitty
+ task manager: btop
+ fetch: nitch (I've added a line to display that my WM is sway XD)
+ music player: yamusic-tui
+ audio-visualliser: cava
+ screensavers: unimatrix, pipes.sh

Theme: catppuccin, Can be found on [catppuccin.com](catppuccin.com). For btop tty theme is used.

Enjoy!

Acknowledgements:

[catppuccin](https://catppuccin.com) - palette, themes for terminal and for many other apps

[nitch](https://github.com/ssleert/nitch) - very beautiful fetch as it seems to me, but not so many options and very complicated configuration)

[owl](https://gitlab.com/prolinux410/owl_dots) - many ideas for this rice (especially, for waybar). 
