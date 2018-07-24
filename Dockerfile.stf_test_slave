FROM ubuntu:18.04

# store dependencies and targets in environment variables
ENV TOOLS_DIR="/"
ENV ECLIPSE_HOME=$TOOLS_DIR"eclipse" \
    USER=root \
    VNC_PWD=testpwd \
    COBERTURA_HOME=$TOOLS_DIR"cobertura" \
    STF_WS=$TOOLS_DIR"stf_ws" \
    SCRIPT_DIR=$TOOLS_DIR"scripts" \
    CONFIG_DIR=$TOOLS_DIR"configs" 

COPY src/uri_env.sh src/setup_stf_slave.sh src/setup_utils.sh /
COPY config/stf_slave/xfce4-panel.xml /root/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml
RUN chmod +x setup_stf_slave.sh && ./setup_stf_slave.sh
