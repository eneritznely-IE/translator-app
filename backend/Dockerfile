# Use official Elixir image
FROM elixir:1.15-alpine

# Install Hex + Rebar (build tools)
RUN mix local.hex --force && \
    mix local.rebar --force

# Set workdir
WORKDIR /app

# Copy mix files and install deps first (for caching)
COPY mix.exs mix.lock ./
RUN mix deps.get

# Copy the rest of the code
COPY . .

# Expose default Elixir port
EXPOSE 4000

# Start the app
CMD ["mix", "run", "--no-halt"]