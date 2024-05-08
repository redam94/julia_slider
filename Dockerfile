FROM julia:1.10.3

ENV USER pluto
ENV USER_HOME_DIR /home/${USER}
ENV JULIA_DEPOT_PATH ${USER_HOME_DIR}/.julia
ENV NOTEBOOK_DIR ${USER_HOME_DIR}/notebooks
ENV JULIA_NUM_THREADS 100
ENV MY_GIT_REPO "https://github.com/redam94/julia_slider.git"

RUN useradd -m -d ${USER_HOME_DIR} ${USER} \
    && mkdir -p ${NOTEBOOK_DIR}

COPY . ${USER_HOME_DIR}/
WORKDIR ${USER_HOME_DIR}

RUN mkdir -p /home/pluto/.julia/environments/v1.10/ &&\
    cp ./*.toml /home/pluto/.julia/environments/v1.10/ &&\
    julia -e "import Pkg; Pkg.activate(); Pkg.instantiate(); Pkg.precompile();" &&\
    chown -R ${USER} ${USER_HOME_DIR} && \
    apt-get update && apt-get install -y \
    curl tar git vim &&\
    git clone ${MY_GIT_REPO} ./notebooks

USER ${USER}

EXPOSE 8080

CMD [ "julia", "-e", "using PlutoSliderServer; PlutoSliderServer.run_git_directory(\"./notebooks\")"]