import Translator from './pages/Translator';
import Container from './components/Container';

export default function App(){
  return (
    <Container>
      <header style={{ marginBottom: 24 }}>
        <h1>Translator</h1>
      </header>
      <Translator />
    </Container>
  )
}
