# dotfiles

Dotfiles are how you personalize your system. These are mine.

## Requirements

Set zsh as your login shell:

```bash
chsh -s $(which zsh)
```

## Install

Just run:

```bash
curl -L https://raw.githubusercontent.com/rafaell-lycan/dotfiles/master/bootstrap | sh
```

This will symlink the appropriate files in .dotfiles to your home directory.

Everything is configured and tweaked within `~/.dotfiles`.

## What's Inside

- 📦 Homebrew [packages and cask apps](./Brewfile)
- 🔧 ZSH configuration with custom [aliases](./config/zsh/aliases.sh) and [functions](./config/zsh/functions.sh)
- ⚡️ Git [configuration and aliases](./config/git/gitconfig.symlink)
<!-- - 💻 VS Code [extensions](./config//vscode/install.sh) -->
- 🍎 OSX [preferences](./config/osx/defaults.sh)

## Local Git Configuration

To setup your git credentials correctly you'll need to add a `.gitconfig.local` file to your `$HOME` directory and add the following:

```
[user]
  name = YOUR_GIT_AUTHOR_NAME
  email = YOUR_GIT_AUTHOR_EMAIL
[github]
  user = YOUR_GITHUB_USERNAME
```

or simply

```bash
git config -f ~/.gitconfig.local user.name "YOUR_GIT_AUTHOR_NAME"
git config -f ~/.gitconfig.local user.email "YOUR_GIT_AUTHOR_EMAIL"
```

## GPG (Optional)

You will need to install GPG Keychain for GPG signing to happen automatically. See GPG Tools for more information. There are ways to do this through homebrew, but the setup is a bit much.

You can do this by doing these steps in your `.gitconfig.local`:

```
[user]
  signingKey = ~/.ssh/id_ed25519.pub
[credential]
  helper = osxkeychain
[commit]
  gpgsign = true
[gpg]
  format = ssh
```

or simply

```bash
git config -f ~/.gitconfig.local user.signingkey ~/.ssh/id_ed25519.pub
git config -f ~/.gitconfig.local commit.gpgsign true
git config -f ~/.gitconfig.local gpg.format ssh
```

## License

Dotfiles is copyright © 2014-2024. It is free software, and may be redistributed under the terms specified in the [`LICENSE`] file.

[`LICENSE`]: /LICENSE
