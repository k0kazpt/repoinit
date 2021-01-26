# {{ project_name }}

[![pre-commit badge][pre-commit-badge]][pre-commit] [![Conventional commits badge][conventional-commits-badge]][conventional-commits] [![Keep a Changelog v1.1.0 badge][keep-a-changelog-badge]][keep-a-changelog] [![MIT License Badge][license-badge]][license]

# Overview
The repository and it's dependencies can be automatically setup by running an interactive script, that will run a makefile according to the interactive choices made.

When this script finishes, the repository will be ready to use!

# Getting started

After git cloning this repo:
1. Run:
    ```bash
    .first-setup/start.sh
    ```
2. Choose option "1":
    ```
    ### START USING YOUR REPOSITORY ###
    (to abort, Ctrl-C)
    -> Please choose the repo type you
    -> want to configure or to rebuild
    -> the configuration!
    What do you want to do?
    1) First Time Setup
    2) Reset config
    #? 1
    ```
3. Choose the which repository type you wish to configure:
    ```
    Which type of repository will this be?
    1) generic
    2) terraform
    #? 1
    ```
4. If at any time you are asked for sudo privileges, input your password accordingly (you will only be asked once):
    ```
    [sudo] password for XXXXX:
    ```
5. When presented with the following question (git-chglog configuration):
    ```
    ? What is the URL of your repository?
    ```
   fill this and all following questions with the presented default values:
    ```
    ? What is the URL of your repository? https://github.com/k0kazpt/test-cookiecutter
    ? What is your favorite style? github
    ? Choose the format of your favorite commit message <type>(<scope>): <subject>
    ? What is your favorite template style? keep-a-changelog
    ? Do you include Merge Commit in CHANGELOG? Yes
    ? Do you include Revert Commit in CHANGELOG? Yes
    ? In which directory do you output configuration files and templates? .chglog
    ```
6. ✔ Finished!! ✔
    ```
    -> Repo setup successfull!
    ```

## To reset and reconfigure
1. Run:
    ```bash
    .first-setup/start.sh
    ```
2. Choose option "2":
    ```
    ### START USING YOUR REPOSITORY ###
    (to abort, Ctrl-C)
    -> Please choose the repo type you
    -> want to configure or to rebuild
    -> the configuration!
    What do you want to do?
    1) First Time Setup
    2) Reset config
    #? 2
    ```
3. You'll be shown the following message:
    ```
    -> Resetting repository metadata:
    rm -f ../.repo_metadata/.DONE 2>/dev/null
    rm -f ../.repo_metadata/.repo_* 2>/dev/null
    -> To reconfigure, run ./first-setup/start.sh again!
    ```
4. To reconfigure, follow the instructions in [Getting started](#Getting-started)

***
# References
## conventional commits
https://www.conventionalcommits.org/

## pre-commit hooks

Read the [pre-commit hooks](docs/pre-commit-hooks.md) document for more info.

## git-chglog

Read the [git-chglog](docs/git-chlog.md) document for more info.

[pre-commit]: https://github.com/pre-commit/pre-commit
[pre-commit-badge]: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
[conventional-commits-badge]: https://img.shields.io/badge/Conventional%20Commits-1.0.0-green.svg
[conventional-commits]: https://conventionalcommits.org
[keep-a-changelog-badge]: https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735
[keep-a-changelog]: https://keepachangelog.com/en/1.0.0/
[license]: ./LICENSE
[license-badge]: https://img.shields.io/badge/license-MIT-green.svg
[changelog]: ./CHANGELOG.md
[changelog-badge]: https://img.shields.io/badge/changelog-Keep%20a%20Changelog%20v1.1.0-%23E05735
