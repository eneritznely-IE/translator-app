import Translator from './pages/Translator';
import Container from './components/Container';

export default function App(){
  return (
    <Container style={{backgroundColor: "#049f9d"}}>
      <header style={{ marginBottom: 24 }}>
        <h1>Translator</h1>
      </header>
      <Translator />
    </Container>
  )
}
