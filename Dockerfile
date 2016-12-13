FROM jupyter/all-spark-notebook
MAINTAINER Kirill Morozov <kir.morozov@gmail.com>

USER root
RUN apt-get update && \
    apt-get upgrade --yes && \
    apt-get install --yes mc git make cmake build-essential libboost-all-dev libstdc++6

USER $NB_USER

RUN cd ~ && \
    git clone --branch=stable https://github.com/bigartm/bigartm.git && \
    cd bigartm && \
    mkdir build && cd build && \
    cmake .. && \
    PATH=/opt/conda/envs/python2/bin:$PATH make && \
    cd ~/bigartm/3rdparty/protobuf-3.0.0/python && \
    python setup.py install && \
    /opt/conda/envs/python2/bin/python setup.py install && \
    cd ~/bigartm/python && \
    python setup.py install && \
    /opt/conda/envs/python2/bin/python setup.py install

ENV ARTM_SHARED_LIBRARY /home/jovyan/bigartm/build/src/artm/libartm.so

RUN conda install --quiet --yes gensim pandas-datareader && \
    conda upgrade --quiet --yes --all && \
    conda install --quiet --yes -n python2 gensim pandas-datareader&& \
    conda upgrade --quiet --yes -n python2 --all

RUN ln -sfn /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/conda/envs/python2/lib/libstdc++.so && \
    ln -sfn /usr/lib/x86_64-linux-gnu/libstdc++.so.6 /opt/conda/envs/python2/lib/libstdc++.so.6


RUN pip install nbimporter jupyter_contrib_nbextensions --upgrade && \
    PATH=/opt/conda/envs/python2/bin:$PATH pip install nbimporter jupyter_contrib_nbextensions --upgrade

RUN pip install --pre statsmodels dismalpy --upgrade && \
    PATH=/opt/conda/envs/python2/bin:$PATH pip install --pre statsmodels dismalpy --upgrade

