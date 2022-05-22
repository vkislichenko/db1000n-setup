#!/bin/bash

HEALTH_URL="https://itarmy.com.ua/check/"
TOTAL=$($DOCKER_COMPOSE_COMMAND -f "$DB1000N_DOCKER_COMPOSE_FILE" logs --tail=1000 | grep -o "Total.*" | tail -n 1 | sed -e 's/[^[:digit:].-MB]/|/g' | tr -s '|' ' ')
TARGETS=$($DOCKER_COMPOSE_COMMAND -f "$DB1000N_DOCKER_COMPOSE_FILE" logs --tail=1000 | tac | sed '/Total/,$!d;/Target/q' | tac | grep -E '(http|https)://.*' | tr -s ' ' | cut -d' ' -f4,12,13 | sed 's/http.*\/\///g' | sort -uk1,1 | sort -k2 -r | head -n 5 | sed 's/ / \`(/' | sed 's/MB/MB)\`/')
VPN_CONFIG=$(ls ${DB1000N_DIRECTORY}/openvpn/ | grep 'modified' | sed 's/.modified//g')

ATTEMPTED=$(echo $TOTAL | cut -d' ' -f 1)
SENT=$(echo $TOTAL | cut -d' ' -f 2)
RECEIVED=$(echo $TOTAL | cut -d' ' -f 3)
DATA=$(echo $TOTAL | cut -d' ' -f 4,5)


message=$(cat << EOF
*Host*: \`$(hostname)\`
%0A
*Requests attempted*: \`$ATTEMPTED\`
%0A
*Requests sent*: \`$SENT\`
%0A
*Responses received*: \`$RECEIVED\`
%0A
*Data sent*: \`$DATA\`
%0A
*VPN config*: \`$VPN_CONFIG\`
%0A
*Top 5 targets by traffic*:
%0A
$TARGETS
EOF
)

keyboard="{\"inline_keyboard\":[[{\"text\":\"Open health report\", \"url\":\"${HEALTH_URL}\"}]]}"

curl -s --data "text=${message}" \
        --data "reply_markup=${keyboard}" \
        --data "chat_id=$TELEGRAM_NOTIFY_CHAT_ID" \
        --data "parse_mode=markdown" \
        "https://api.telegram.org/bot${TELEGRAM_NOTIFY_TOKEN}/sendMessage"
