- install

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/{사용자}/.profile

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
```

- uninstall
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

sudo rm -rf /home/linuxbrew
```
