FROM dart:3.14.0-315.3.beta@sha256:3c00b0d2f2221fdf1689cac1fb18665283854cde7fab1aad2af1cb309ca3ac21

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
