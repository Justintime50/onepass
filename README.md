<div align="center">

# 1Pass

1Password CLI wrapper for easy credential retrieval.

[![Build](https://github.com/Justintime50/1pass/workflows/build/badge.svg)](https://github.com/Justintime50/1pass/actions)
[![Licence](https://img.shields.io/github/license/justintime50/1pass)](LICENSE)

<img src="assets/showcase.png" alt="Showcase">

</div>

Need access to your 1Password credentials from the command line? `1Pass` is the perfect companion making retrieving credentials or 1Password details a breeze.

1Pass wraps the [1Password CLI](https://support.1password.com/command-line/) making retrieving credentials incredibly simple. Automate your scripts, quickly grab credential details, or use 1Password as a secrets store while leaving security to the pros.

## Install

```bash
# Before using 1Pass, you'll need to install 1Password CLI and jq
brew install --cask 1password-cli
brew install jq

# Setup the tap
brew tap justintime50/formulas

# Install 1Pass
brew install 1pass
```

## Usage

Before using 1Pass, login to the 1Password CLI for the first time:

```bash
# Signin to 1Password CLI
op signin example.1password.com wendy_appleseed@1password.com
```

Once you've signed in for the first time, use any of the following 1Pass commands.

**NOTE:** Currently, every request must be authenticated and will prompt for your master password.

```bash
# Signin
1pass signin

# Signout
1pass signout

# Forget
1pass forget

# List Account Details
1pass list_account_details

# List Vault Item Titles (optional: argument is vault name)
1pass list_item_titles 'My Vault Name'

# List Item Details (required: argument is item name)
1pass list_item_details Gmail

# List an Item's Login Details (required: argument is item name)
1pass list_item_login Gmail

# List an Item's OTP (required: argument is item name)
1pass list_item_otp Gmail

# List Vaults
1pass list_vaults

# List Vault Details (required: argument is vault name)
1pass list_vault_details 'My Vault Name'
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

Use 1Pass in your Python scripts:

```python
import json
import subprocess

output = subprocess.check_output(
    '1pass list_item_login Gmail',
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
