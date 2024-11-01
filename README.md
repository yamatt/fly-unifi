# Fly.io Unifi

A single container to run the Unifi Network Application on Fly.io

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
