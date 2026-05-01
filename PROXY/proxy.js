/**
 * proxy.js — Mini proxy SOAP para Protheus
 * Resolve o bloqueio de CORS ao chamar o WebService direto do navegador.
 *
 * Instalação:
 *   npm install express cors node-fetch@2
 *
 * Uso:
 *   PROTHEUS_URL=http://SEU_SERVIDOR:8080/ws/WSFORNECEDOR node proxy.js
 *
 * O HTML deve apontar para: http://localhost:3000/soap-proxy
 */

const express  = require('express');
const cors     = require('cors');
const fetch    = require('node-fetch');

const app  = express();
const PORT = process.env.PORT || 3000;

// URL do WebService Protheus — ajuste via variável de ambiente ou edite aqui
const PROTHEUS_WS_URL = process.env.PROTHEUS_URL || 'http://localhost:8080/ws/WSFORNECEDOR';

// Libera CORS para qualquer origem (restrinja em produção)
app.use(cors());

// Recebe o corpo como texto puro (SOAP é XML)
app.use(express.text({ type: ['text/xml', 'application/xml', 'application/soap+xml'], limit: '2mb' }));

app.post('/soap-proxy', async (req, res) => {
  const soapAction    = req.headers['soapaction'] || '';
  const authorization = req.headers['authorization'] || '';

  console.log(`[proxy] → Encaminhando para ${PROTHEUS_WS_URL}`);
  console.log(`[proxy]   SOAPAction: ${soapAction}`);
  if (authorization) console.log('[proxy]   Authorization: Basic ***');

  const reqHeaders = {
    'Content-Type': 'text/xml; charset=utf-8',
    'SOAPAction':   soapAction,
  };
  if (authorization) reqHeaders['Authorization'] = authorization;

  try {
    const response = await fetch(PROTHEUS_WS_URL, {
      method:  'POST',
      headers: reqHeaders,
      body: req.body,
      // timeout de 30 segundos
      timeout: 30000,
    });

    const responseText = await response.text();

    console.log(`[proxy] ← Status Protheus: ${response.status}`);

    res.status(response.status)
       .set('Content-Type', 'text/xml; charset=utf-8')
       .send(responseText);

  } catch (err) {
    console.error('[proxy] Erro ao conectar no Protheus:', err.message);
    res.status(502).send(`
      <error>
        <message>Proxy não conseguiu conectar ao Protheus</message>
        <detail>${err.message}</detail>
        <url>${PROTHEUS_WS_URL}</url>
      </error>
    `);
  }
});

// Health-check simples
app.get('/health', (_req, res) => res.json({ status: 'ok', target: PROTHEUS_WS_URL }));

app.listen(PORT, () => {
  console.log(`\n✔  Proxy SOAP rodando em http://localhost:${PORT}/soap-proxy`);
  console.log(`   Encaminhando para: ${PROTHEUS_WS_URL}`);
  console.log(`   Defina PROTHEUS_URL para mudar o alvo sem editar o arquivo.\n`);
});