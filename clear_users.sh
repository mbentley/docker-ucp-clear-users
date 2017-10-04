#!/bin/bash

set -e

if [ -z "${UCP_FQDN}" ] || [ -z "${DTR_FQDN}" ] || [ -z "${USERNAME}" ] || [ -z "${PASSWORD}" ]
then
  echo "Error: missing one of the following environment variables: UCP_FQDN, DTR_FQDN, USERNAME, PASSWORD"
  exit 1
fi

USER_LIST="$(curl -sk -X GET -u "${USERNAME}":"${PASSWORD}" "https://${UCP_FQDN}/enzi/v0/accounts/?filter=all&limit=10000000000" | jq -r '.accounts | .[] | select(.isOrg==false) | .name')"

echo "The following users will be removed:"
echo "${USER_LIST}" | grep -v admin

read -n 1 -s -r -p "Press any key to continue"; echo -e "\n\n"

for i in ${USER_LIST}
do
  if [ "${i}" != "admin" ]
  then
    echo "Removing UCP user ${i}"
    curl -k -X DELETE --header "Accept: application/json" -u "${USERNAME}":"${PASSWORD}" "https://${UCP_FQDN}/enzi/v0/accounts/${i}" || true
  fi
done
