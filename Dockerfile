FROM mcr.microsoft.com/devcontainers/base:debian AS assemble

# -------------------------
# Install required packages
# -------------------------
USER root
RUN apt-get update -y &&\
    apt-get install -y --no-install-recommends ca-certificates perl wget perl-modules libfontconfig1 fontconfig sudo &&\
    rm -rf /var/lib/apt/lists/*



# ---------------
# Install texlive
# ---------------
ARG SCHEME
ARG YEAR="2024"
ARG ARCH="aarch64-linux"
ARG MIRROR="https://mirror.ctan.org/systems/texlive/tlnet/"
WORKDIR /tmp
RUN wget "${MIRROR}/install-tl-unx.tar.gz" && \
    tar -xzf install-tl-unx.tar.gz &&\
    perl install-tl-*/install-tl --no-interaction --scheme=$SCHEME --location $MIRROR &&\
    chown -R vscode:vscode /usr/local/texlive
ENV PATH="$PATH:/usr/local/texlive/$YEAR/bin/$ARCH"



# --------------------
# Install latexindent (cpanm fails, but should not stop the build)
# --------------------
RUN cpan -i App::cpanminus &&\
    cpanm YAML::Tiny File::HomeDir Unicode::GCString Log::Log4perl Log::Dispatch::File || exit 0



# -------------------------
# Install latex, latexmk, latexindent and specified packages
# -------------------------
USER vscode
ARG TEX_PACKAGES
RUN tlmgr install latex latex-bin latexmk latexindent ${TEX_PACKAGES}
