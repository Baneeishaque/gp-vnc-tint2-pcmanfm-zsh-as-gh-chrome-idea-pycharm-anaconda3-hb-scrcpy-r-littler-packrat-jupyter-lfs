FROM baneeishaque/gitpod-full-tint2-pcmanfm-zsh-as-gh-chrome-idea-pycharm-anaconda3-as-canary-handbrake-1366x625

RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9 \
 && sudo apt-add-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/" -y \
 && curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash \
 && sudo apt update \
 && sudo apt install -y \
     scrcpy r-base-dev git-lfs \
 && sudo rm -rf /var/lib/apt/lists/*

ENV ADB=$ANDROID_SDK_ROOT/platform-tools/adb

RUN sudo R -e "install.packages(c('littler', 'docopt'))" \
 && sudo ln -s /usr/local/lib/R/site-library/littler/bin/r /usr/local/bin/r \
 && sudo ln -s /usr/local/lib/R/site-library/littler/examples/install2.r /usr/local/bin/install2.r

RUN sudo install2.r --error packrat

RUN jupyter-lab --generate-config

RUN sed -i "s/# c.ServerApp.ip = 'localhost'/c.ServerApp.ip = '0.0.0.0'/g" /home/gitpod/.jupyter/jupyter_lab_config.py
