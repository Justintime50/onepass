<div align="center">

# OnePass

1Password CLI wrapper for easy credential retrieval.

[![Build](https://github.com/Justintime50/onepass/workflows/build/badge.svg)](https://github.com/Justintime50/onepass/actions)
[![Licence](https://img.shields.io/github/license/justintime50/onepass)](LICENSE)

<img src="assets/showcase.png" alt="Showcase">

</div>

Need access to your 1Password credentials from the command line? `OnePass` is the perfect companion making retrieving credentials or 1Password details a breeze.

OnePass wraps the [1Password CLI](https://support.1password.com/command-line/) making retrieving credentials incredibly simple. Automate your scripts, quickly grab credential details, or use 1Password as a secrets store while leaving security to the pros.

## Install

```bash
# Before using OnePass, you'll need to install 1Password CLI and jq
brew install --cask 1password-cli
brew install jq

# Setup the tap
brew tap justintime50/formulas

# Install OnePass
brew install onepass
```

## Usage

Before using OnePass, login to the 1Password CLI for the first time:

```bash
# Signin to 1Password CLI
op signin example.1password.com wendy_appleseed@1password.com
```

Once you've signed in for the first time, use any of the following OnePass commands.

**NOTE:** Currently, every request must be authenticated and will prompt for your master password.

```bash
# Signin
onepass signin

# Signout
onepass signout

# Forget
onepass forget

# List Account Details
onepass list_account_details

# List Vault Item Titles (optional: argument is vault name)
onepass list_item_titles 'My Vault Name'

# List Item Details (required: argument is item name)
onepass list_item_details Gmail

# List an Item's Login Details (required: argument is item name)
onepass list_item_login Gmail

# List an Item's OTP (required: argument is item name)
onepass list_item_otp Gmail

# List Vaults
onepass list_vaults

# List Vault Details (required: argument is vault name)
onepass list_vault_details 'My Vault Name'
```

**Sample Output**

Using the commands above produce direct access to JSON objects without all the fluff. Get right to your login credentials when you need them:

```javascript
{
   "username" : "email@example.com",
   "otp" : "123456",
   "url" : "https://accounts.example.com",
   "password" : "1234567890"
}
```

### Python Implementation

Use OnePass in your Python scripts:

```python
import json
import subprocess
import os


PASSWORD = os.getenv('ONEPASSWORD_MASTER_PASSWORD')

output = subprocess.check_output(
    f'echo "$PASSWORD" | onepass list_item_login Gmail',
    stdin=None,
    stderr=None,
    shell=True
)

output_json = json.loads(output)

print(json.dumps(output_json['username']))
```

## Reference

* [1Password CLI Signin](https://support.1password.com/command-line-reference/#signin)

## Attribution

* Icons made by <a href="https://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a>
