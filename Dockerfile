FROM debian:12-slim AS install

ARG TARGETARCH
ARG TEMPORAL_CLI_VERSION

ADD https://github.com/temporalio/cli/releases/download/v${TEMPORAL_CLI_VERSION}/temporal_cli_${TEMPORAL_CLI_VERSION}_linux_${TARGETARCH}.tar.gz /temporal-cli.tar.gz
RUN tar -xvf /temporal-cli.tar.gz -C /bin/ temporal && \
    chmod +x /bin/temporal

FROM gcr.io/distroless/base-debian12:nonroot

COPY --from=install /bin/temporal /bin/temporal

EXPOSE 7233/tcp 8233/tcp

ENTRYPOINT [ "temporal" ]

CMD [ "server", "start-dev", "--ip=0.0.0.0" ]
