FROM baneeishaque/gitpod-full-tint2-pcmanfm-zsh-as-gh-chrome-idea-pycharm-anaconda3-as-canary-handbrake-1366x625

RUN sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     scrcpy | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

ENV ADB=$ANDROID_SDK_ROOT/platform-tools/adb

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9 | tee /tmp/apt.log \
 && sudo apt-add-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" -y | tee -a /tmp/apt.log \
 && sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     r-base-dev | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*

RUN sudo R -e "install.packages(c('littler', 'docopt'))" \
 && sudo ln -s /usr/local/lib/R/site-library/littler/bin/r /usr/local/bin/r \
 && sudo ln -s /usr/local/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r

RUN sudo install2.r --error packrat

RUN jupyter-lab --generate-config

RUN sed -i "s/# c.ServerApp.ip = 'localhost'/c.ServerApp.ip = '0.0.0.0'/g" /home/gitpod/.jupyter/jupyter_lab_config.py

RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

RUN sudo apt update | tee -a /tmp/apt.log \
 && sudo apt install -y \
     git-lfs | tee -a /tmp/apt.log \
 && sudo rm -rf /var/lib/apt/lists/*
