import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import Translator from './Translator';
import * as translateService from '../services/translateService';
import { vi } from 'vitest';

describe('Translator Component', () => {
  beforeEach(() => {
    // Mock the translate function with a small delay
    vi.spyOn(translateService, 'translate').mockImplementation(
      (text, target) =>
        new Promise((resolve) =>
          setTimeout(() => resolve({ translations: [{ text: `${text} in ${target}` }] }), 50)
        )
    );
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  test('renders textarea, language select and translate button', () => {
    render(<Translator />);
    expect(screen.getByPlaceholderText(/Write something/i)).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /Translate/i })).toBeInTheDocument();
    expect(screen.getByLabelText(/Translate to:/i)).toBeInTheDocument();
  });

  test('translates text when clicking the button', async () => {
    render(<Translator />);
    const input = screen.getByPlaceholderText(/Write something/i);
    const select = screen.getByLabelText(/Translate to:/i);
    const button = screen.getByRole('button', { name: /Translate/i });

    fireEvent.change(input, { target: { value: 'Hello' } });
    fireEvent.change(select, { target: { value: 'ES' } });
    fireEvent.click(button);

    // Wait for the translated result to appear
    const result = await screen.findByText('Hello in ES');
    expect(result).toBeInTheDocument();

    // After translation, the button should return to its normal state
    await waitFor(() => {
      expect(button).toHaveTextContent(/Translate/i);
      expect(button).not.toBeDisabled();
    });
  });

  test('shows loading state while translating', async () => {
    render(<Translator />);
    const input = screen.getByPlaceholderText(/Write something/i);
    const select = screen.getByLabelText(/Translate to:/i);
    const button = screen.getByRole('button', { name: /Translate/i });

    fireEvent.change(input, { target: { value: 'Hello' } });
    fireEvent.change(select, { target: { value: 'ES' } });
    fireEvent.click(button);

    // Wait explicitly for the button to show "Translating..."
    await waitFor(() => {
      expect(button).toHaveTextContent(/Translating.../i);
      expect(button).toBeDisabled();
    });

    // Wait for the result to appear
    const result = await screen.findByText('Hello in ES');
    expect(result).toBeInTheDocument();
  });

  test('displays error message if translation fails', async () => {
    // Mock translate function to throw an error
    vi.spyOn(translateService, 'translate').mockImplementationOnce(() => {
      throw new Error('API error');
    });

    render(<Translator />);
    const input = screen.getByPlaceholderText(/Write something/i);
    const button = screen.getByRole('button', { name: /Translate/i });

    fireEvent.change(input, { target: { value: 'Hello' } });
    fireEvent.click(button);

    // Expect the error message to appear
    const errorMessage = await screen.findByText(/Error: API error/i);
    expect(errorMessage).toBeInTheDocument();
  });
});
