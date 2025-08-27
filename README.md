# Translator App

A full-stack Translator application allowing users to translate text using the DeepL Free API.

* React frontend with reusable components and modular UI
* Elixir backend with reusable services and clean API structure
* Ready-to-run full-stack application

---

## Project Structure

```
 frontend/
 └─ src/
    ├─ assets/      # Static assets (languages.json)
    ├─ components/  # Reusable UI components
    ├─ pages/       # Page-level components
    ├─ services/    # API/service modules
    └─ styles/      # Global CSS

backend/                  # Elixir Plug + Cowboy app
 ├─ config/               # Configuration files
 ├─ lib/                  # Main application code
 │  └─ translator/
 │     ├─ services/       # Business logic modules (TranslateService)
 │     ├─ router.ex       # HTTP route definitions
 │     └─ application.ex # Application entry point
 └─ .env                  # Environment variables
```

---

## Requirements

* Node >= 16, npm or yarn
* Elixir >= 1.14, Erlang/OTP compatible
* For production: set `DEEPL_API_KEY` to your DeepL Free API key

---

## Run Frontend (React)

```bash
cd frontend
npm install
npx vite
```

* Frontend runs on port 5173 by default
* Expects backend at `http://localhost:4000` (CORS enabled)

---

## Run Backend (Elixir)

```bash
cd backend
mix deps.get
# Set environment variables
export DEEPL_API_KEY="your_deepl_key_here"
# Optionally set PORT (default: 4000)
export PORT=4000
mix run --no-halt
```

* Backend listens on port 4000 by default
* POST requests to `http://localhost:4000/api/translate` with JSON:

```json
{ "text": "...", "target_lang": "ES" }
```

---

## Notes

* Minimal code to run the feature (no tests included)
* Backend integrates with DeepL Free API; ensure `DEEPL_API_KEY` is set

