FROM ghcr.io/foundry-rs/foundry:latest

# Switch to root to install dependencies
USER root

# Install curl for healthcheck and other utilities
RUN apt-get update && \
    apt-get install -y curl netcat-openbsd jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for anvil data
WORKDIR /anvil

# Create a healthcheck script
COPY healthcheck.sh /anvil/healthcheck.sh
RUN chmod +x /anvil/healthcheck.sh

# Copy startup script with configurable options
COPY start-anvil.sh /anvil/start-anvil.sh
RUN chmod +x /anvil/start-anvil.sh

# Expose the default Anvil port
EXPOSE 8545

# Add healthcheck
HEALTHCHECK --interval=5s --timeout=3s --start-period=5s --retries=3 \
    CMD /anvil/healthcheck.sh

# Use the startup script as entrypoint
ENTRYPOINT ["/anvil/start-anvil.sh"]

# Default command can be overridden
CMD []