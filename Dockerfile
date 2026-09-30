FROM alpine:latest

# Install core network diagnostics utilities
RUN apk add --no-cache \
    bash \
    curl \
    bind-tools \
    iproute2 \
    traceroute \
    tcpdump \
    iputils

WORKDIR /app

# Copy diagnostic script into image
COPY test_connectivity.sh /app/test_connectivity.sh
RUN chmod +x /app/test_connectivity.sh

ENTRYPOINT ["/app/test_connectivity.sh"]
