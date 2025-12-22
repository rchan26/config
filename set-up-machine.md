# Setting up a machine

Some general setup steps and useful links when moving to a new machine.

## SSH key setup

- Generate new SSH key: see https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
- Add SSH Key to GitHub

## GPG key setup

- Generate a new GPG key: see https://docs.github.com/en/authentication/managing-commit-signature-verification/generating-a-new-gpg-key
- Add GPG key to GitHub
- Tell Git about the signing key: see https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key

## Set up oh-my-zsh

- Intall oh-my-zsh: see https://ohmyz.sh/#install
- May also need to install zsh first
- Use `.zshrc` config in repo

## Set up Conda

- Install Conda: see https://www.anaconda.com/docs/getting-started/miniconda/install
- Disable automatic activation of the `base` environment: `conda config --set auto_activate_base false`

## Set up uv

- Install uv: see https://docs.astral.sh/uv/getting-started/installation/
