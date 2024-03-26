
<details>
<summary><strong>How to install Chrome from the command line</strong></summary>

```console
$ wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
$ gpg --no-default-keyring \
        --keyring /etc/apt/keyrings/google-chrome.gpg \
        --import /tmp/google.pub
$ echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
$ sudo apt-get update -y; sudo apt-get install -y google-chrome-stable
```

</details>
