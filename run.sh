#!/bin/bash
# Run both backend (Elixir) and frontend (React) concurrently

# Start backend
cd backend
if [ -f ".env" ]; then
  export $(grep -v '^#' .env | xargs)  # Load .env variables
fi
mix deps.get
echo "Starting backend on port ${PORT:-4000}..."
mix run --no-halt &

# Start frontend
cd ../frontend
npm install
echo "Starting frontend on http://localhost:5173..."
npx vite