#!/bin/sh

DB1000N_SETUP_DOCUMENT_ROOT="$(dirname $(realpath $0))"
DB1000N_SETUP_APP_COMMAND="$(realpath $0)"

# copy .env.example as .env if it does not exist
[ ! -f ./.env ] && cp ./.env.example ./.env

# include env
. ./.env

command="$1"

case $command in
	setup)
	  . ./setup/software.sh
	  . ./setup/db1000n.sh
		. ./setup/cron.sh
		;;
  setup-cron)
		. ./setup/cron.sh
		;;
  deploy)
		. "$DB1000N_DEPLOY_COMMAND"
		;;
  redeploy)
		. "$DB1000N_REDEPLOY_COMMAND"
		;;
  telegram-notify)
		. "$TELEGRAM_NOTIFY_COMMAND"
		;;
	*)
	  echo "# Run initial setup"
    echo "./app.sh setup"
    echo "# Run only cron setup"
    echo "./app.sh setup-cron"
		echo "# Deploy db1000n (used on reboot)"
		echo "./app.sh deploy"
		echo "# Redeploy db1000n (used to restart already running db1000n)"
    echo "./app.sh redeploy"
    echo "# Send telegram notification"
    echo "./app.sh redeploy"
		echo "# Show this message"
		echo "./app.sh help"
		;;
  esac