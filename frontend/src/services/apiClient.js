import axios from 'axios';

// Base URL for the API, using environment variable or fallback to localhost
const API_BASE = import.meta.env.VITE_API_BASE || 'http://localhost:4000';

// Create a reusable Axios instance for API requests
export const apiClient = axios.create({
  baseURL: API_BASE,                  // Base URL for all requests
  headers: {
    'Content-Type': 'application/json'  // Default headers for JSON payloads
  }
});

