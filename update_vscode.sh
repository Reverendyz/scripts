#!/bin/sh

curl -Ls "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -o vscode.deb

sudo dpkg -i vscode.deb

rm vscode.deb