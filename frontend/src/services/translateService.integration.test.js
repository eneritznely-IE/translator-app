import { translate } from './translateService';

describe('Integration test: translateService -> backend', () => {
  const inputText = 'Hello';
  const targetLang = 'ES';

  test('should translate text via the real backend API', async () => {
    const data = await translate(inputText, targetLang);

    // Check that response has expected structure
    expect(data).toHaveProperty('translations');
    expect(Array.isArray(data.translations)).toBe(true);

    // Check the first translation
    const translation = data.translations[0];
    expect(translation).toHaveProperty('text');
    expect(typeof translation.text).toBe('string');
    expect(translation.text.length).toBeGreaterThan(0);

    // Optional: log translation for inspection
    console.log(`Translation: ${translation.text}`);
  });
});