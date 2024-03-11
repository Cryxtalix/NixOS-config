# SSH Git Server

## Initial nix setup
To run a simple SSH git server, import /modules/git-daemon.nix in your system host of choice. Add a public SSH key for use with the git server into the keys folder, and edit the git-daemon.nix file with the reference to your new public key file. Run the rebuild command.

## Managing repositories
Repositories are stored in the /srv/git folder, which is owned exclusively by the git user. No other user accounts can access that folder, while the git user does not provide any shell access. We do not want users of the git server to make any changes to the server. Therefore we have to use the root account to add/remove repositories.

To add a new repository, login to the root user with `sudo -i` or `sudo su`. Go to /srv/git and run `git init --bare myProject.git` to create a blank repo with the same name as your project. The myProject.git folder and all the files within are currently owned by root and cannot be accessed by the git user, so we run `chown -R git:git myProject.git/` to change ownership to the git user.

Back in our project folder, add a new git remote by running `git remote add home git@[server_ip]:/srv/git/myProject.git`, where "home" is the name we choose for this remote. Alternatively, we can edit the .git/config file inside the project folder.

Finally, run `git push home [branch_name]` and the project will be pushed to the git server.

To remove a repository, simply delete the myProject.git folder at /srv/git as root.