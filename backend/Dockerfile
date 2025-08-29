# Use official Elixir image
FROM elixir:1.15-alpine

# Install Hex and Rebar (build tools)
RUN mix local.hex --force && \
    mix local.rebar --force

# Set working directory
WORKDIR /app

# Copy mix files first for caching
COPY mix.exs mix.lock ./

# Install dependencies
RUN mix deps.get

# Copy the rest of the code
COPY . .

# Expose default Elixir port
EXPOSE 4000

# Start the application
CMD ["mix", "run", "--no-halt"]
