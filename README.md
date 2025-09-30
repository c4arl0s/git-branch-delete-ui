# 🗂️ Git Branch Delete UI

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell: Bash](https://img.shields.io/badge/Shell-Bash-4EAA25)](https://www.gnu.org/software/bash/)

> An interactive tool to safely and easily delete Git branches

## 📖 Description

`git-branch-delete-ui.sh` is a bash script that provides an intuitive graphical interface to delete Git branches interactively. The script uses `dialog` to create a user-friendly interface that allows you to select multiple branches and confirm their deletion before executing the action.

### ✨ Features

- 🔍 **Automatic detection**: Automatically identifies all available branches
- 🛡️ **Smart protection**: Automatically excludes `main`, `master` branches and the current branch
- ✅ **Safety confirmation**: Asks for confirmation before deleting selected branches
- 🎯 **Multiple selection**: Allows selecting multiple branches to delete in a single operation
- 📊 **Informative messages**: Provides clear feedback with success, warning, and error messages
- 🔄 **Repository validation**: Verifies that the current directory is a valid Git repository

## 🚀 Installation

### Prerequisites

The script requires `dialog` for the graphical interface:

#### macOS
```bash
brew install dialog
```

#### Ubuntu/Debian
```bash
sudo apt-get install dialog
```

#### CentOS/RHEL
```bash
sudo yum install dialog
```

### Setup

1. **Download the script:**
```bash
curl -O https://raw.githubusercontent.com/c4arl0s/git-branch-delete-ui/main/git-branch-delete-ui.sh
```

2. **Make the script executable:**
```bash
chmod +x git-branch-delete-ui.sh
```

3. **Optional: Add to PATH**
```bash
# Add to ~/.bashrc or ~/.zshrc
export PATH="$PATH:/path/to/your/script"
```

## 📋 Usage

### Basic usage

```bash
./git-branch-delete-ui.sh
```

### Example workflow

1. **Navigate to your Git repository:**
```bash
cd /path/to/your/repository
```

2. **Run the script:**
```bash
./git-branch-delete-ui.sh
```

3. **Select the branches:**
   - The script will display a list of available branches
   - Use arrow keys to navigate
   - Press space to select/deselect branches
   - Press Tab to move between options

4. **Confirm deletion:**
   - The script will ask for confirmation before deleting
   - Select "Yes" to proceed or "No" to cancel

## 🖼️ Screenshot

<img width="600" alt="Git Branch Delete UI Interface" src="https://github.com/user-attachments/assets/ab33d8bc-e216-44c5-9429-ff92e2646204">

## 🔧 Script Features

### Important branch protection

The script automatically excludes:
- The current branch (where you're working)
- The `main` branch
- The `master` branch

### System messages

- 🔴 **Errors**: Displayed in red with timestamp
- 🟡 **Warnings**: Displayed in yellow with timestamp  
- 🟢 **Success**: Displayed in green when the operation is successful

### Validations

- ✅ Verifies that you're in a valid Git repository
- ✅ Confirms that there are branches available to delete
- ✅ Asks for confirmation before executing `git branch -D`

## 🛠️ Development

### Code structure

```bash
# Configuration variables
readonly CURRENT_BRANCHES_MSG='Current Branches to remove, select them:'
readonly DIDNT_SELECT_BRANCH_MSG='You did not select any branch'
# ... more variables

# Main functions
error()          # Error handling
warning()        # Warning handling  
clean_branches() # Branch filtering
are_you_sure_msg() # User confirmation

# Main logic
# Repository validation → Branch retrieval → 
# Filtering → User interface → Confirmation → Deletion
```

## 🐛 Troubleshooting

### Error: "dialog: command not found"
```bash
# Install dialog according to your operating system
brew install dialog  # macOS
sudo apt install dialog  # Ubuntu/Debian
```

### Error: "Current directory is not a git repository"
```bash
# Make sure you're in a directory with a Git repository
cd /path/to/your/git/repository
git status  # Verify it's a valid repo
```

### No branches appear to delete
- Verify you have local branches (not just remote ones)
- Make sure you're not on a branch without other local branches
- The script excludes `main`, `master` and the current branch

## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

## 🤝 Contributing

Contributions are welcome. Please:

1. Fork the project
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 👨‍💻 Author

**Carlos Santiago Cruz**
- GitHub: [@c4arl0s](https://github.com/c4arl0s)
- [View more bash scripts](https://github.com/c4arl0s#bash-scripts)

## 📚 Additional Resources

- [Official Git documentation](https://git-scm.com/doc)
- [Dialog manual](https://invisible-island.net/dialog/)
- [Bash scripting guide](https://tldp.org/LDP/abs/html/)

---

⭐ **Like this script?** Give it a star!
