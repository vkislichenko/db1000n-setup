#!/bin/sh

# schedule db1000n
CRONJOBS=$(cat << EOF
$SYSTEM_REBOOT_SCHEDULE_EXPRESSION reboot
@reboot $DB1000N_DEPLOY_COMMAND > /dev/null 2>&1
$DB1000N_REDEPLOY_SCHEDULE_EXPRESSION $DB1000N_REDEPLOY_COMMAND > /dev/null 2>&1
EOF
)

# schedule telegram notification
if [ $TELEGRAM_NOTIFY_ENABLED -eq 1 ] && [ $TELEGRAM_NOTIFY_SCHEDULE_ENABLED -eq 1 ]; then
  CRONJOBS=$(cat << EOF
$CRONJOBS
$TELEGRAM_NOTIFY_SCHEDULE_EXPRESSION $TELEGRAM_NOTIFY_COMMAND > /dev/null 2>&1
EOF
  )
fi

echo "$CRONJOBS"
#echo "$CRONJOBS" >> /root/cronjob