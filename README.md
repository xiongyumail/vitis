# vitis

Vitis installed into a docker image for CI purposes.

## Install

1. Clone

```
git clone --recursive https://github.com/xiongyumail/vitis.git
```
2. Install docker.io

```
sudo apt install docker.io
```

3. Go to Xilinx official website to download Vitis: https://china.xilinx.com/support/download/index.html/content/xilinx/zh/downloadNav/vitis.html

4. Copy the Vitis installation package `FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256.tar.gz` to `tools/vitis`.

```bash
cd tools/vitis
mkdir install_vitis
cp install_config.txt install_vitis/
tar zxvf FPGAs_AdaptiveSoCs_Unified_2023.2_1013_2256.tar.gz -C install_vitis
```

## Running

```
./vitis.sh
```
