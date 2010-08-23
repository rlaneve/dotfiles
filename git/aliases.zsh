alias gl='git pull --rebase --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gp='git push origin HEAD'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git checkout -b $1'
alias gs='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

# Adds, commits, and pushes everything. Example: 'gpa "This is easy as pie!"'
# Hat tip: http://mattsears.com/2008/8/11/quick-git-add-commit-push-and-deploy
gpa() {
    # Check if the repo is dirty
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]
        then
        echo ""
    else
        if [[ $st == "nothing to commit (working directory clean)" ]]
            then
            echo "Nothing to push"
        else
            # Make sure there is a message with the commit
            if [ -z "$1" ]
                then
                echo "You must specify a message with your commit"
                return
            fi

            # Commit all the changes by default
            echo "Adding new files to Git repository"
            git add .

            echo "Commiting to local Git repository"
            git commit -a -m "$1"

            # Push changes if a remote repository exists
            if git remote | grep -q "origin"
                then
                echo "Pushing changes to remote repository"
                git push origin HEAD
            fi
        fi
    fi
}