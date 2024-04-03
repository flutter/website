Some Flutter components require the 
[Rosetta 2 translation process][need-rosetta]
on Macs running [Apple silicon][].
To run all Flutter components on Apple silicon,
install [Rosetta 2][rosetta].

```console
$ sudo softwareupdate --install-rosetta --agree-to-license
```

[Apple silicon]: https://support.apple.com/en-us/HT211814
[rosetta]: https://support.apple.com/en-us/HT211861
[need-rosetta]: {{site.repo.this}}/pull/7119#issuecomment-1124537969
