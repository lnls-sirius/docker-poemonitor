# Author: Paulo Baraldi Mausbach
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM python:3.6.8-stretch

#======================#
# Install dependencies #
#======================#

#Install python module "requests"

RUN pip3.6 install requests

#Update the image to the latest packages

RUN apt-get update

#Install EPICS base


RUN apt-get -y install libreadline-gplv2-dev                        &&\
    cd /opt                                                         &&\
    mkdir epics-R3.15.6                                             &&\
    cd epics-R3.15.6                                                &&\
    wget https://epics.anl.gov/download/base/base-3.15.6.tar.gz     &&\
    tar -xvzf base-3.15.6.tar.gz                                    &&\
    rm base-3.15.6.tar.gz                                           &&\
    mv base-3.15.6 base                                             &&\
    cd base                                                         &&\
    make

#Definition of EPICS environment variables

ENV PATH=/opt/epics-R3.15.6/base/bin/linux-x86_64:$PATH
ENV EPICS_BASE=/opt/epics-R3.15.6/base
ENV EPICS_HOST_ARCH=linux-x86_64

#Install pcaspy dependecies

RUN apt-get -y install swig

#Install pcaspy

RUN pip3.6 install pcaspy

#Mount directory where host data will be shared

RUN mkdir /usr/local/poemonitor-ioc

WORKDIR /usr/local/poemonitor-ioc

CMD python3 poemonitor-ioc.py
