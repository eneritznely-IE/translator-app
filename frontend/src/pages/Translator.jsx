import {useState} from 'react';
import TextArea from '../components/TextArea';
import Container from "../components/Container";
import { translate } from '../services/translateService';
import languages from "../assets/languages.json";

// Translator component
// Allows users to input text, select a target language, and see the translated result.
// Handles loading state and error messages.
export default function Translator(){
  const [input, setInput] = useState('');  // input text from user
  const [target, setTarget] = useState('EN');       // selected target language
  const [loading, setLoading] = useState(false);   // loading indicator
  const [result, setResult] = useState('');       // translated result

  // Handle translation request
  async function handleTranslate(){
    setLoading(true);
    try{
      const data = await translate(input, target);
      // Safely access translation text or fallback to raw data
      setResult(data.translations?.[0]?.text || JSON.stringify(data));
    }catch(err){
      setResult('Error: ' + (err.response?.data?.error || err.message));
    }finally{ 
      setLoading(false); 
    }
  }

  return (
    <Container>
      <div>
        <label htmlFor="inputText" style={{ display: "block", marginBottom: 6 }}>
          Text to translate
        </label>

         {/* Controlled textarea input */}
        <TextArea 
          id="inoutText"
          value={input} 
          onChange={setInput} 
          placeholder="Write something..." 
        />

        {/* Language selection and translate button */}
        <div style={{marginTop:12, display:'flex', alignItems: "center", gap:8}}>
          <label htmlFor="targetSelect">Choose a language</label>
          <select 
            id="targetSelect" 
            value={target} 
            onChange={ (e) => setTarget(e.target.value)}
            style={{padding: 6, borderRadius: 4}}
          >
            {languages.map(({ code, label }) => (
            <option key={code} value={code}>
              {code} ({label})
            </option>
          ))}
          </select>
          <button onClick={handleTranslate} disabled={loading} style={{marginLeft:8, padding: "6px 12px", borderRadius: 4, cursor: loading ? "not-allowed": "pointer"}}>{loading ? 'Translating...' : 'Translate'}</button>
        </div>

        {/* Translation result display */}
        <div style={{marginTop: 16}}>
          <h3>Result</h3>
          <div style={{whiteSpace:'pre-wrap', background:'#f3f3f4', padding:12, borderRadius:6, minHeight: 80}}>{result}</div>
        </div>
      </div>
    </Container>
  )
}
