import { create } from 'venom-bot';
import express from 'express';

const app = express();
app.use(express.json());

let clientInstance = null;

create({
  session: 'whatsapp-session',
  headless: true,
})
  .then((client) => {
    clientInstance = client;
    console.log('✅ WhatsApp pronto!');
  })
  .catch((err) => {
    console.error('Errore avvio Venom:', err);
  });

app.post('/send', async (req, res) => {
  const { to, message } = req.body;

  if (!clientInstance) {
    return res.status(500).json({ error: 'Client WhatsApp non pronto' });
  }

  try {
    await clientInstance.sendText(to, message);
    res.json({ success: true });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Server attivo sulla porta ${PORT}`));
