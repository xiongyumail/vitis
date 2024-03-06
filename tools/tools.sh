#!/bin/bash
WORK_PATH=$(cd $(dirname $0); pwd)
TEMP_PATH=~/workspace/.tmp/${MY_NAME}
echo "WORK_PATH: ${WORK_PATH}"
echo "TEMP_PATH: ${TEMP_PATH}"

sudo apt-get update

if [ ! -d "${TEMP_PATH}" ]; then
   mkdir -p ${TEMP_PATH}
fi
cd ${TEMP_PATH}
if [ ! -d ".config" ]; then
   mkdir .config
fi
if [ ! -d ".tools" ]; then
   mkdir .tools
fi

cd ${TEMP_PATH}/.config
if [ ! -d ".config" ]; then
   mkdir .config
   sudo rm -rf ~/.config
   sudo ln -s $PWD/.config ~/.config
fi
if [ ! -d ".tmux" ]; then
   mkdir .tmux
   sudo rm -rf ~/.tmux
   sudo ln -s $PWD/.tmux ~/.tmux
fi
if [ ! -d ".local" ]; then
   mkdir .local
   sudo rm -rf ~/.local
   sudo ln -s $PWD/.local ~/.local
fi
if [ ! -d ".ipython" ]; then
   mkdir .ipython
   sudo rm -rf ~/.ipython
   sudo ln -s $PWD/.ipython ~/.ipython
fi
if [ ! -d ".pki" ]; then
   mkdir .pki
   sudo rm -rf ~/.pki
   sudo ln -s $PWD/.pki ~/.pki
fi
if [ ! -d ".cache" ]; then
   mkdir .cache
   sudo rm -rf ~/.cache
   sudo ln -s $PWD/.cache ~/.cache
fi
if [ ! -d ".Xilinx" ]; then
   mkdir .Xilinx
   sudo rm -rf ~/.Xilinx
   sudo ln -s $PWD/.Xilinx ~/.Xilinx
fi

# vitis
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
            build-essential \
            libxtst6 \
            libglib2.0-0 \
            libsm6 \
            libxi6 \
            libxrender1 \
            libxrandr2 \
            libfreetype6 \
            libfontconfig \
            lsb-release \
            xterm \
            libnss3 \
            libasound2 \
            libegl1 \
            libncurses-dev \
            cmake \
            libidn11-dev \
            cpio \
            unzip \
            rsync \
            bc \
            qemu-user-static \
            debootstrap \
            kpartx \
            dosfstools \
            libcanberra-gtk-module \
     	    vim-gtk \
            openjdk-8-jre-zero \
            libtinfo5 \
            libxrender-dev \
            libxtst-dev 

if [ ! -f "${TEMP_PATH}/.tools/vitis" ]; then
   cd ${WORK_PATH}
   cd vitis
   mkdir ${TEMP_PATH}/vitis
   mkdir install_vitis
   cp install_config.txt install_vitis/
   tar zxvf Xilinx_Unified_2020.1_0602_1208.tar.gz -C install_vitis
   ls install_vitis && sudo install_vitis/*/xsetup --agree 3rdPartyEULA,WebTalkTerms,XilinxEULA --batch Install --config install_vitis/install_config.txt --location ${TEMP_PATH}/vitis/Xilinx
   sudo rm -rf install_vitis
   cp Xilinx.lic ~/.Xilinx/
   echo "source ${TEMP_PATH}/vitis/Xilinx/Vitis/2020.1/settings64.sh" >> ${HOME}/.bashrc
   echo "export VITIS_PATH=${TEMP_PATH}/vitis/Xilinx/Vitis/2020.1/bin" >> ${HOME}/.bashrc
   echo "Vitis install ok" >> ${TEMP_PATH}/.tools/vitis
fi

# tmux
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
   tmux
if [ ! -f "${TEMP_PATH}/.tools/tmux" ]; then
   cd ${WORK_PATH}
   cd tmux
   ln -s $PWD/.tmux.conf ~/.tmux.conf
   ln -s $PWD/.vimrc ~/.vimrc
   echo "export TMUX_PATH=${TEMP_PATH}/tmux" >> ${HOME}/.bashrc
   echo "tmux install ok" >> ${TEMP_PATH}/.tools/tmux
fi

sudo apt-get clean
sudo apt-get autoclean
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*
sudo rm -rf /var/cache/*
sudo rm -rf /var/lib/apt/lists/*
