FROM openjdk:8-jdk-alpine3.8

ENV TOOLS_DIR="/home/ci" \
    WORKSPACE="/home/ci/saros_src" \
    CONFIG_DIR="/home/ci/saros_src/travis/config" \
    SCRIPT_DIR="/home/ci/saros_src/travis/script" \
    GRADLE_HOME="/home/ci/gradle" \
    STF_WS="/home/ci/stf_ws" \
    ECLIPSE_HOME="/home/ci/eclipse" \
    INTELLIJ_HOME="/home/ci/intellij"

COPY src/uri_env.sh src/setup_ci_build.sh src/setup_gradle.sh src/setup_utils.sh /tmp/
RUN apk add --no-cache bash && \
  chmod +x /tmp/setup_gradle.sh && \
  chmod +x /tmp/setup_ci_build.sh && \
  bash -c "cd /tmp; ./setup_gradle.sh; ./setup_ci_build.sh" \
