FROM julia:1.10.3

ENV USER redam94
ENV USER_HOME_DIR /home/${USER}
ENV JULIA_DEPOT_PATH ${USER_HOME_DIR}/.julia
ENV NOTEBOOK_DIR ${USER_HOME_DIR}/notebooks
ENV MY_GIT_REPO "https://github.com/redam94/julia_slider_repo.git"
ENV JULIA_PKG_USE_CLI_GIT true

RUN useradd -m -d ${USER_HOME_DIR} ${USER} \
    && mkdir -p ${NOTEBOOK_DIR}

COPY . ${USER_HOME_DIR}/
WORKDIR ${USER_HOME_DIR}


RUN apt-get update && apt-get install -y \
    curl tar git vim &&\
    mkdir -p ${USER_HOME_DIR}/.julia/environments/v1.10/ &&\
    cp ./*.toml ${USER_HOME_DIR}/.julia/environments/v1.10/ &&\
    julia -e "import Pkg; Pkg.activate(); Pkg.instantiate(); Pkg.precompile();" &&\
    chown -R ${USER} ${USER_HOME_DIR} && \
    git clone ${MY_GIT_REPO} ./notebooks && \
    chown -R ${USER} ./notebooks

USER ${USER}
EXPOSE 8080


CMD ["julia", "--project=.", "-e", "using PlutoSliderServer; PlutoSliderServer.run_git_directory(\"notebooks\")"]