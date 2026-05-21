FROM dart:3.12.0@sha256:3d1b19886b288807b42020ede8f1f9ea7753c91c17c27479ee9e7bf584289a34

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates \
    # Install the latest version of firebase-tools globally. \
    && curl -sL https://firebase.tools | bash \
    # Clean up unnecessary remnants after dependency installation. \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
