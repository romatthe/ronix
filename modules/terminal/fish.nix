{ pkgs, ... }:

{
    programs.fish.enable = true;

    # Aliases
    programs.fish.shellAbbrs = {
        # TODO Configure bat
        "cat" = "bat";
        # TODO Configure delta
        "diff" = "delta";
    };
}