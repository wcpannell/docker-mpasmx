# docker-mpasmx
Dockerized Microchip MPASM compiler with prjMakefilesGenerator

# Usage
The resultant docker container can be used with your CI/CD software to build MPASM Assembly projects.

For manual usage:
  1) Build container
```shell
docker build -t mpasmx
```
  2) Launch container
```bash
docker run --rm -di --name mpasmx_1 mpasmx
```
  3) Copy in your source
```bash
docker cp my_code/ mpasmx_1:/app
```
  4) Build
```bash
docker exec mpasmx_1 bash -c "cd /app && prjMakefilesGenerator . && make"
```
  5) Get your build artifacts
```bash
docker cp mpasmx_1:/app/dist .
docker cp mpasmx_1:/app/debug .
```
  6) Clean up
```bash
docker stop mpasmx_1
```

# A note on licensing
This Unlicense release covers only the Dockerfile and build scripts.
Software contained in the resultant image has other usage and restrictions
MPASM and MPLABX are copyrights of Microchip and are under propreitary license.
These scripts download Microchip software from their public release URLS and use
Microchip's Free license tier.
