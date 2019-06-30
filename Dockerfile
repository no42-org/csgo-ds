FROM no42org/steamcmd

ENV STEAM_USER "steam"
ENV STEAM_CSGO_DIR "/home/steam/csgo-ds"
ENV STEAM_CSGO_APP_ID "740"
ENV GSLT "YOUR_GSLT_TOKEN"

COPY containerfs/entrypoint.sh /

RUN mkdir "${STEAM_CSGO_DIR}"

USER steam

WORKDIR "${STEAM_CSGO_DIR}"

CMD [ "/entrypoint.sh" ]

EXPOSE 27015/tcp 27015/udp
