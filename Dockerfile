FROM jupyter/datascience-notebook:python-3.9.5

ARG CONDA_ENV=/opt/conda
ARG HOME_DIR=/home/jovyan

USER root

RUN apt-get update && \
    apt-get install -y vim openssh-client rsync

COPY requirements.txt ${HOME_DIR}/
#Installing dependencies
RUN conda install --yes --prefix $CONDA_ENV -c conda-forge --file ${HOME_DIR}/requirements.txt

WORKDIR /

#Retrieving and installing awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.4.16.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN rm awscliv2.zip
RUN ./aws/install

#Automatically retrieving and installing the newest version of pyjs9 available
RUN LOCATION=$(curl -s "https://api.github.com/repos/ericmandel/pyjs9/releases/latest" | grep "tag_name" | sed 's/\"//g' | sed 's/ //g' | sed 's/tag_name://g' | sed 's/,//g'); curl -L -o result.tar.gz "https://github.com/ericmandel/pyjs9/archive/refs/tags/$LOCATION.tar.gz" 
RUN mkdir ./pyjs9
RUN tar xvf result.tar.gz -C ./pyjs9 --strip-components=1
RUN pip3 install ./pyjs9

#Copying entrypoint, requirements, and demo files over 
COPY start-jupyter-argus.sh /usr/local/bin
COPY astropy-fits-demo.ipynb ${HOME_DIR}
COPY s3-fits-demo.ipynb ${HOME_DIR}
COPY s3-list-demo.ipynb ${HOME_DIR}
COPY pyjs9-demo.ipynb ${HOME_DIR}
COPY pyjs9-demo-socketio.ipynb ${HOME_DIR}


USER $NB_USER
WORKDIR ${HOME_DIR}

ENTRYPOINT start-jupyter-argus.sh 
