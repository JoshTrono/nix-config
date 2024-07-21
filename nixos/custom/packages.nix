{pkgs,...}:
{

    environment.systemPackages = with pkgs; [
        lutris
        discord
        vscode
        protonup-qt
        firefox
        git
        gh
    ];
}
