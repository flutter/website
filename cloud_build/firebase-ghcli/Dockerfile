FROM dart:3.13.0@sha256:8b6175f6c6b89aaf31ffdace4a22d17715c07f1cf3a772dadb10c658f779e23d

RUN apt-get update && apt-get install -y --no-install-recommends curl gpg ca-certificates \
    # Install the GitHub CLI. \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    # Install the latest version of firebase-tools globally. \
    && curl -sL https://firebase.tools | bash \
    # Clean up unnecessary remnants after dependency installation. \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
