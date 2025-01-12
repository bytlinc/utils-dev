# Git Profile Switcher

A simple utility script to switch between different Git/GitHub profiles. This is particularly useful when you need to manage multiple GitHub accounts (e.g., work and personal) on the same machine.

## Installation

1. Create the configuration file:
```bash
touch ~/.git-profiles
chmod 600 ~/.git-profiles
```

2. Create the script:
```bash
curl -o ~/switch-git-profile.sh https://raw.githubusercontent.com/yourusername/repo/main/switch-git-profile.sh
chmod +x ~/switch-git-profile.sh
```

3. (Optional) Add the script to your PATH:
```bash
sudo mv ~/switch-git-profile.sh /usr/local/bin/switch-git-profile
```

## Configuration

1. Edit your `~/.git-profiles` file with your GitHub profiles. Here's a sample configuration:

```ini
[work]
name=John Doe
email=john.doe@company.com
username=johndoe-work
token=ghp_xxxxxxxxxxxxxxxxxxxx

[personal]
name=John Doe
email=john@gmail.com
username=johndoe
token=ghp_yyyyyyyyyyyyyyyyyyyy

[opensource]
name=John Doe
email=john.opensource@gmail.com
username=johndoe-opensource
token=ghp_zzzzzzzzzzzzzzzzzzzz
```

Make sure to:
- Replace the tokens with your actual GitHub Personal Access Tokens
- Keep the file permissions restricted (`chmod 600 ~/.git-profiles`)
- Use the correct profile names in square brackets `[profile-name]`

## Usage

Switch to a profile by providing the profile name:

```bash
# If added to PATH
switch-git-profile work
switch-git-profile personal

# Or if running from the original location
~/switch-git-profile.sh work
~/switch-git-profile.sh personal
```

To see available profiles:
```bash
switch-git-profile
```

## Getting GitHub Tokens

1. Go to GitHub → Settings → Developer Settings → Personal Access Tokens → Tokens (classic)
2. Click "Generate new token"
3. Select the necessary scopes:
   - `repo` (Full control of private repositories)
   - `workflow` (if you need to trigger GitHub Actions)
4. Copy the generated token and add it to your `.git-profiles` file

## Security Notes

- The `.git-profiles` file contains sensitive information. Keep it secure and never share it.
- The file permissions are set to `600` to ensure only you can read it.
- The script will check and warn you if the file permissions are too loose.
- Consider using a password manager or keychain for even better security.

## Troubleshooting

### Permission Denied
```bash
chmod 600 ~/.git-profiles
chmod +x ~/switch-git-profile.sh
```

### Profile Not Found
- Check if the profile name in the command matches exactly with the name in square brackets in your `.git-profiles` file
- Check if your `.git-profiles` file is properly formatted

### Authentication Failed
- Verify your GitHub token is valid and has the necessary permissions
- Check if the token is correctly copied into the `.git-profiles` file
- Ensure there are no extra spaces or newlines in the token

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is licensed under the MIT License - see the LICENSE file for details.