## Divisora: Private, Automatic and Dynamic portal to other security zones

### Build
```
podman build -t divisora/novnc .
```

### Run
```
# NOTE: See divisora-installer for instructions. Not ment to run manually
podman run --name divisora_novnc -e VNC_SERVER=10.0.0.1:5900 -d -p 10000:6080 divisora/novnc:latest
```