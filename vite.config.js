import { defineConfig, loadEnv } from 'vite';

export default defineConfig(({ mode }) => {
  // Lataa ympäristömuuttujat .env-tiedostosta
  const env = loadEnv(mode, process.cwd(), '');

  console.log('Ladatut ympäristömuuttujat:', env); // Debug-tuloste

  return {
    define: {
      'import.meta.env': env
    }
  };
});
