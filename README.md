# Initial Setup
```shell
./app.sh setup
```
- will install software db1000n needs
- will clone db1000n from git
- will schedule db1000n restart

# Run db1000n in docker container
```shell
./app.sh deploy
```


# Enable Telegram Notifications

1. If you did not run setup - copy `.env.example` as `.env`
```shell
cp .env.example .env
```

2. [Create telegram bot](https://core.telegram.org/bots#3-how-do-i-create-a-bot)

3. Update telegram variables in `.env`
```shell
TELEGRAM_NOTIFY_ENABLED=1
TELEGRAM_NOTIFY_TOKEN="YOUR TELEGRAM TOKEN"
TELEGRAM_NOTIFY_CHAT_ID="YOUR TELEGRAM CHAT ID"
```

4. Update crontab
```shell
./app.sh setup-cron
```

### _[OPTIONAL]_ Set telegram notification to run before scheduled db1000n redeploy
1. Disable dedicated telegram notification schedule
```shell
TELEGRAM_NOTIFY_SCHEDULE_ENABLED=0
```
2. Update db1000n redeploy command
```shell
DB1000N_REDEPLOY_COMMAND="${TELEGRAM_NOTIFY_COMMAND} && ${DB1000N_DEPLOY_COMMAND}"
```
3. Update crontab
```shell
./app.sh setup-cron
```