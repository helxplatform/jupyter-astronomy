FROM jupyter/datascience-notebook:python-3.9.5

ARG CONDA_ENV=/opt/conda
ARG HOME_DIR=/home/jovyan

USER root

RUN apt-get update && \
    apt-get install -y vim openssh-client rsync

WORKDIR /
COPY awscli-2.4.16.zip /awscliv2.zip
RUN unzip awscliv2.zip
RUN rm awscliv2.zip
RUN ./aws/install

COPY start-jupyter-argus.sh /usr/local/bin

USER $NB_USER
WORKDIR ${HOME_DIR}

RUN conda install --yes --prefix $CONDA_ENV -c conda-forge \
        ipython \
        ipywidgets

RUN conda install pip

RUN /opt/conda/bin/pip3 install python-otter otter-grader

RUN conda install astropy
COPY astropy-fits-demo.ipynb ${HOME_DIR}
COPY s3-fits-demo.ipynb ${HOME_DIR}
COPY s3-list-demo.ipynb ${HOME_DIR}

RUN conda install boto3

#RUN pip3 install git+https://github.com/ericmandel/pyjs9.git#egg=pyjs9
#RUN pip3 install socketio

ENTRYPOINT start-jupyter-argus.sh 
