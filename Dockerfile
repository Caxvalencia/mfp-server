FROM openjdk:8-jdk-slim

# Documentation https://mobilefirstplatform.ibmcloud.com/downloads/#developer-kit

ENV MFP_RELEASE=IF202007141941
ENV MFP_VERSION=8.0.0.0
ENV MFP_SERVE_DOWNLOAD=https://github.com/MobileFirst-Platform-Developer-Center/MobileFirst-Developer-Kit/releases/download/${MFP_RELEASE}/mobilefirst-deved-devkit-mac-${MFP_VERSION}.zip

WORKDIR "/mfp"

# INSTALL UNZIP AND CURL
RUN apt-get update && apt-get install -y -qq \
    aufs-tools \
    automake \
    build-essential \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# DOWNLOAD MFP-DEVKIT
RUN curl -fsSL -o mfp-server.zip $MFP_SERVE_DOWNLOAD &&\
    unzip -q "./mfp-server.zip" &&\
    rm "./mfp-server.zip" &&\
    chmod +x run.sh

# DOWNLOAD AWS-CLI
RUN curl -fsSL -o awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.0.42.zip &&\
    unzip -q "./awscliv2.zip" &&\
    rm "./awscliv2.zip" &&\
    chmod +x ./aws/install &&\
    ./aws/install -i /usr/local/aws-cli -b /usr/local/bin

EXPOSE 9080

CMD [ "./mfp-server/bin/server", "run", "mfp" ]