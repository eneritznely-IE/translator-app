import { apiClient } from "./apiClient";

// translate function
// Sends text and target language to the backend translation API
// Returns the API response data
export async function translate(text, target_lang='EN'){
  // POST request to /api/translate with payload { text, target_lang }
  const res = await apiClient.post('/api/translate', { text, target_lang });
  return res.data;
}