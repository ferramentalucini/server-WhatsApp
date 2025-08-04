const express = require("express");
const venom = require("venom-bot");
const app = express();

app.use(express.json());

let client;

venom
  .create(
    'session',
    undefined,
    (status, session) => console.log('Status:', status),
    {
      headless: true,
      useChrome: false,
      args: ['--no-sandbox', '--disable-setuid-sandbox']
    }
  )
  .then((venomClient) => {
    client = venomClient;

    app.post("/send", async (req, res) => {
      const { number, message } = req.body;

      if (!number || !message) {
        return res.status(400).json({ error: "Numero e messaggio obbligatori" });
      }

      try {
        await client.sendText(`${number}@c.us`, message);
        res.json({ success: true });
      } catch (error) {
        res.status(500).json({ error: error.message });
      }
    });

    const PORT = process.env.PORT || 3000;
    app.listen(PORT, () => {
      console.log("Server attivo sulla porta", PORT);
    });
  })
  .catch((e) => console.error("Errore avvio Venom:", e));
