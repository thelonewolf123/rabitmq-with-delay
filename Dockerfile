FROM rabbitmq:4.2.1-management

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Define the version of the plugin you want to download
ARG PLUGIN_VERSION=4.2.0
ENV PLUGIN_FILE=rabbitmq_delayed_message_exchange-${PLUGIN_VERSION}.ez

# Download the .ez plugin — ensure it’s exactly the right version
RUN curl -fSL "https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v${PLUGIN_VERSION}/${PLUGIN_FILE}" \
    -o /opt/rabbitmq/plugins/${PLUGIN_FILE}

# Fix permissions
RUN chown rabbitmq:rabbitmq /opt/rabbitmq/plugins/${PLUGIN_FILE}

# List plugin directory (for debugging)
RUN ls -lah /opt/rabbitmq/plugins/

# Enable the plugin using the base name (without version suffix)
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# (Optional) clean up, or more config
