# arksurvivalascended_zero_movies
this project aim to make zero byte movies for Ark Survival Ascended, in order to optimize and save space


for better performance keep those files:
ASA_Logo_Loop
ASA_Background_Loop
LoadingScreen
ARKTitle
ARKTitleMenu_1080 (for 1080p or lower monitor) ARKTitleMenu_2160 (for 1080p or higher monitor)


# Broken Clipboard Paste on Arch based systems (arch, cachyos etc)
To resolve issues with CTRL+C and CTRL+V not working in Linux (especially with Wayland), use these commands:

``` sudo pacman -S xclip ```

``` paru -Ss clipboard-sync```

``` systemctl --user enable --now clipboard-sync ```

or

```PROTON_ENABLE_WAYLAND=1``` on launch parameter*

<img width="838" height="595" alt="image" src="https://github.com/user-attachments/assets/3a465020-8e8e-41ea-a5ad-14a06eef311f" />

For me, using this method causes some keys to not work in the game, but using it is important for importing [building templates](https://wikily.gg/ark-survival-ascended/building-templates)



[source](https://forums.eveonline.com/t/proton-on-wayland-broken-clipboard-paste-potential-fix-for-it/499995)
