FROM ubuntu:14.04

COPY config/prosody_xmpp_server/prosody.cfg.lua  src/setup_prosody_xmpp_server.sh /
RUN chmod +x setup_prosody_xmpp_server.sh && ./setup_prosody_xmpp_server.sh
