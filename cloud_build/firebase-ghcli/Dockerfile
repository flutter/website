FROM dart:3.12.0-327.4.beta@sha256:5306c1008b585f0fbcf23aa0d7145b8f65cd7bd8c63dce4b8038684c11c79833

# Install prerequisite dependencies.
RUN apt-get update && apt-get install -y --no-install-recommends curl gpg ca-certificates

# Install the GitHub CLI.
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
RUN apt-get update \
    && apt-get install -y --no-install-recommends gh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the latest version of firebase-tools globally.
RUN curl -sL https://firebase.tools | bash
