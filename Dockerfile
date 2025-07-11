FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu AS base


# Install templates
COPY templates/*.sty /usr/local/texlive/texmf-local/tex/latex/
COPY --chmod=755 --chown=vscode:root templates/newtex.sh /usr/local/bin/newtex



# Fix apt and Install latexindent
RUN echo 'Acquire::http::Pipeline-Depth "0";\nAcquire::http::No-Cache true;\nAcquire::BrokenProxy true;' > /etc/apt/apt.conf.d/99fixbadproxy &&\
    apt-get update && apt-get install -y texlive-extra-utils &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*
