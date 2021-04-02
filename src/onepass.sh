#!/bin/bash

VAULT=${2:-Private}
ITEM=${2:-PROVIDE_INPUT}
SHORTHAND=my # TODO: Allow this to be configurable

main() {
    signin
    command_router "$1"
    signout
}

signin() {
    # Signin to the 1Password CLI using the "shorthand" approach
    # This requires that you have logged in already with the full set of creds
    eval "$(op signin $SHORTHAND)"
}

signout() {
    # Signout of the 1Password CLI
    op signout
}

forget() {
    # Forget the details of a 1Password account from this device
    op forget "$ACCOUNT"
}

list_account_details() {
    # Get the authenticated account's details
    op get account
}

list_item_titles() {
    # Get all item's titles by vault
    op list items --vault "$VAULT" | jq -r '[.[].overview.title]'
}

list_item_details() {
    # Get an item's full info by title
    op get item "$ITEM" | json_pp
}

list_item_login() {
    # Get item's login details by title
    # Includes username, password, otp, and url
    op get item "$ITEM" --fields username,password,url | jq --arg otp "$(list_item_otp)" '. + {"otp": $otp}' | json_pp
}

list_item_otp() {
    # Get item's OTP (helper function for list_item_login, does not return JSON)
    op get totp "$ITEM"
}

list_vaults() {
    # Get a list of vaults
    op list vaults | json_pp
}

list_vault_details() {
    # Get all vault details
    op get vault "$VAULT" | json_pp
}

command_router() {
    # Check if the command passed is valid or not. 
    # Run if it is a valid command, warn and exit if it is not.
    if declare -f "$1" > /dev/null
    then
        "$@"
    else
        printf "%s\n" "\"$1\" is not a OnePass command, please try again." >&2
        exit 1
    fi
}

main "$1"
