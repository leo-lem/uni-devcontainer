FROM mcr.microsoft.com/vscode/devcontainers/python AS base

COPY templates/*.sty /usr/local/texlive/texmf-local/tex/latex/
COPY --chmod=755 --chown=vscode:root templates/newtex.sh /usr/local/bin/newtex
