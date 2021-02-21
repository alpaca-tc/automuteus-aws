Deploy automuteus to EC2

## Usage

### 1. Add bot to discord

https://github.com/denverquane/automuteus/blob/master/BOT_README.md

Required permissions

- `Administrator`

or

- `Send Messages`
- `Manage Messages`
- `Embed Links`
- `Use External Emojis`
- `Add Reactions`
- `Mute Members`
- `Deafen Members`

### 2. Deploy automuteus to AWS

```sh
# Login aws via CLI
$ aws configure

# Deploy automuteus to AWS EC2
$ terraform init
$ terraform apply -var="discord_bot_token=YOUR_DISCORD_API_TOKEN"

# Add ssh key for debug if you want
$ terraform apply -var="discord_bot_token=YOUR_DISCORD_API_TOKEN" -var="ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"
```
