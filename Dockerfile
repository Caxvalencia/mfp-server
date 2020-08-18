FROM openjdk:8-jdk-alpine3.9

# Documentation https://mobilefirstplatform.ibmcloud.com/downloads/#developer-kit

ENV MFP_RELEASE=IF202007141941
ENV MFP_VERSION=8.0.0.0
ENV MFP_SERVE_DOWNLOAD=https://github.com/MobileFirst-Platform-Developer-Center/MobileFirst-Developer-Kit/releases/download/${MFP_RELEASE}/mobilefirst-deved-devkit-mac-${MFP_VERSION}.zip

WORKDIR "/mfp"

# INSTALL ZIP AND CURL
RUN apk update && apk upgrade &&\
    apk --no-cache add curl unzip &&\
    rm -rf /var/cache/apk/* &&\
    # DOWNLOAD MFP-DEVKIT
    curl -fsSL -o mfp-server.zip $MFP_SERVE_DOWNLOAD &&\
    unzip -q "./mfp-server.zip" &&\
    rm "./mfp-server.zip" &&\
    chmod +x run.sh

EXPOSE 9080

CMD [ "./mfp-server/bin/server", "run", "mfp" ]