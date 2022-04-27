FROM harbor.cyverse.org/vice/vscode:latest

USER openvscode-server

RUN conda update conda 
RUN conda install -c conda-forge mamba
RUN conda config --set channel_priority strict
COPY environment.yml /home/openvscode-server/ 
RUN mamba env create -f /home/openvscode-server/environment.yml
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/openvscode-server/.bashrc && \
    echo "conda activate geospatial" >> /home/openvscode-server/.bashrc 
SHELL ["/bin/bash", "-c"]     
RUN source /home/openvscode-server/.bashrc