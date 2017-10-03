docker-ucp-clear-users
======================


Remove all UCP users and DTR user namespaces *except* for the admin account:

```
docker run -it --rm \
  -e UCP_FQDN=ucp.example.com \
  -e DTR_FQDN=dtr.example.com \
  -e USERNAME=admin \
  -e PASSWORD=password \
  mbentley/ucp-clear-users:latest
```
