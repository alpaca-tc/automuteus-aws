Deploy automuteus to EC2

## Usage

```sh
# Login aws via CLI
$ aws configure

# Deploy automuteus to AWS EC2
$ terraform init
$ terraform apply -var="discord_bot_token=YOUR_DISCORD_API_TOKEN"

# Add ssh key for debug if you want
$ terraform apply -var="discord_bot_token=YOUR_DISCORD_API_TOKEN" -var="ssh_public_key=$(cat ~/.ssh/id_rsa.pub)"
```
