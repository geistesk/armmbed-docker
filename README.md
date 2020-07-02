# ARMmbed Docker

Dockerfile to work with [mbed-cli][] and [yotta][].

```bash
# Clone and switch to this repository

# Build the Docker container
docker build -t arm-build-env .

# Switch to your project
docker run --rm -it -v `pwd`:/app arm-build-env bash
```


[mbed-cli]:https://github.com/ARMmbed/mbed-cli
[yotta]:https://github.com/ARMmbed/yotta
