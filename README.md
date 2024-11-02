# Fly.io Unifi

A single container to run the Unifi Network Application on Fly.io.

Note that the Unifi Network Application requires self signed certs, there is no non-cert option. This has two effects with fly.io:

- If you're using the Fly.io Proxy it cannot verify the certificates and refuses to connect. If there was an option to ignore self signed certs this would be fine. Everything tells you this is insecure, but the in-transit encryption only exists within the machine.
- If you're using tcp passthrough, where you're connecting to the Unifi Network Application's port 8443 directly over the internet, your browser will refuse to connect to a self signed certificate as a global domain. There is no fix for this.

Therefore this service uses haproxy as a reverse proxy to connect to the Unifi Network Application on port 8443 and ignore the self signed cert, and present that without certificates on port 8081.

## Setup

### Launch

You will need to create your instance first. Do not use the default app name.

```bash
flyctl launch --name <app name>
```

### Volumes

You will need to create a data volume for the config data

```bash
flyctl volumes create unifi_data
```
