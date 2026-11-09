FROM dart:3.14.0-315.3.beta@sha256:3c00b0d2f2221fdf1689cac1fb18665283854cde7fab1aad2af1cb309ca3ac21

RUN apt-get update && apt-get install -y --no-install-recommends curl gpg ca-certificates \
    # Install the GitHub CLI. \
    && curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt-get update \
    && apt-get install -y --no-install-recommends gh \
    # Pin the v15.34.0 version of Firebase CLI due to https://github.com/firebase/firebase-tools/issues/11335. \
    && curl -fsSL https://firebase.tools/bin/linux/v15.34.0 -o /usr/local/bin/firebase \
    && echo "e6e271a8050b70f92725e4349faf9a586ff12e1d4b57deb751e86211a107f644  /usr/local/bin/firebase" | sha256sum -c - \
    && chmod 755 /usr/local/bin/firebase \
    # Clean up unnecessary remnants after dependency installation. \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
