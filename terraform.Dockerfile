FROM debian:bookworm-slim

ARG TERRAFORM_VERSION=1.9.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl unzip ca-certificates && \
    curl -fsSL -o /tmp/terraform.zip \
      "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && \
    unzip /tmp/terraform.zip -d /usr/local/bin && \
    rm /tmp/terraform.zip && \
    apt-get purge -y unzip && \
    rm -rf /var/lib/apt/lists/*

COPY entry_point.sh /entry_point.sh
RUN chmod +x /entry_point.sh

ENTRYPOINT ["/entry_point.sh"]
CMD ["bash"]
