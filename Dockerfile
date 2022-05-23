ARG PYTHON_VERSION=3.8

################## ARGUMENTS/Environments ##########
ARG BUILD_DATE
ARG BUILD_VERSION
ARG LICENSE="Apache-2.0"
ARG POSTPROCESSING_VARIANT_CALLS_VERSION
ARG VCS_REF

# set up user
ARG USER=nonroot
RUN useradd --create-home --no-log-init --system --user-group ${USER}
USER ${USER}
ARG HOME=/home/${USER}
WORKDIR ${HOME}/app

LABEL org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${BUILD_VERSION} \
    org.opencontainers.image.licenses=${LICENSE} \
    org.opencontainers.image.version.pvs=${POSTPROCESSING_VARIANT_CALLS_VERSION} \
    org.opencontainers.image.source.pv="https://pypi.org/project/postprocessing_variant_calls" \
    org.opencontainers.image.vcs-url="https://github.com/msk-access/postprocessing_variant_calls.git" \
    org.opencontainers.image.vcs-ref=${VCS_REF}

LABEL org.opencontainers.image.description="This container uses python3.9.7 as the base image to build \
    PostProcessing Varaint Calls version ${POSTPROCESSING_VARIANT_CALLS_VERSION}"

################## INSTALL ##########################

WORKDIR /app
ADD . /app

# install postprocessing_variant_calls 

RUN apt-get update && apt-get install --no-install-recommends -y gcc g++ zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && make deps-install

