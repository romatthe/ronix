{ pkgs, ... }:
{
    fonts.fontconfig.enable = true;
    fonts.fontconfig.allowBitmaps = true;
    fonts.fontconfig.useEmbeddedBitmaps = true;
    fonts.enableFontDir = true;
    fonts.enableGhostscriptFonts = true;

    fonts.fonts = with pkgs; [
        apple-color-emoji
        emacs-all-the-icons-fonts
        jetbrains-mono
        nerdfonts
        noto-fonts
    ];

    fonts.fontconfig = {
        defaultFonts = {
            emoji = [ "Apple Color Emoji" ];
            monospace = [ "Jetbrains Mono" ];
            sansSerif = [ "Noto Sans" ];
        };
    };
}