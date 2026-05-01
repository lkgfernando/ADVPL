# Documentação — Proxy SOAP para Protheus

## O que é o proxy?

O `proxy.js` é um servidor Node.js simples que fica entre o navegador e o Protheus.
Ele resolve o bloqueio de **CORS** que impede o HTML de chamar o WebService diretamente.

```
[cadastro-fornecedor.html] → [proxy.js :3000] → [Protheus :8091]
```

---

## Pré-requisitos

| Item | Versão mínima | Como verificar |
|---|---|---|
| Node.js | 14+ | `node --version` |
| npm | 6+ | `npm --version` |

Se não tiver o Node.js instalado, baixe em: https://nodejs.org

---

## Instalação (apenas na primeira vez)

**1. Crie uma pasta para o proxy:**
```
D:\PROXY\
```

**2. Copie o arquivo `proxy.js` para essa pasta.**

**3. Abra o PowerShell ou CMD dentro da pasta e instale as dependências:**
```powershell
npm install express cors node-fetch@2
```

Aguarde a instalação. Deve aparecer algo como:
```
added 3 packages in 2s
```

---

## Como rodar

### PowerShell
```powershell
$env:PROTHEUS_URL="http://127.0.0.1:8091/ws/ZWSFORN.apw"; node proxy.js
```

### CMD (Prompt de Comando)
```cmd
set PROTHEUS_URL=http://127.0.0.1:8091/ws/ZWSFORN.apw && node proxy.js
```

### Resposta esperada no terminal:
```
✔  Proxy SOAP rodando em http://localhost:3000/soap-proxy
   Encaminhando para: http://127.0.0.1:8091/ws/ZWSFORN.apw
   Defina PROTHEUS_URL para mudar o alvo sem editar o arquivo.
```

---

## Configuração do HTML

Com o proxy rodando, abra o `cadastro-fornecedor.html` no navegador e preencha:

| Campo | Valor |
|---|---|
| **Endpoint** | `http://localhost:3000/soap-proxy` |
| **Usuário** | Seu usuário do Protheus |
| **Senha** | Sua senha do Protheus |

Clique em **Salvar** para guardar as configurações.

---

## Trocar o ambiente (homologação / produção)

Basta mudar a URL do Protheus na variável `PROTHEUS_URL`:

```powershell
# Homologação
$env:PROTHEUS_URL="http://192.168.1.10:8091/ws/ZWSFORN.apw"; node proxy.js

# Produção
$env:PROTHEUS_URL="http://192.168.1.20:8080/ws/ZWSFORN.apw"; node proxy.js
```

---

## Trocar a porta do proxy

Por padrão o proxy roda na porta **3000**. Para mudar:

```powershell
$env:PORT="4000"; $env:PROTHEUS_URL="http://127.0.0.1:8091/ws/ZWSFORN.apw"; node proxy.js
```

E no HTML atualize o endpoint para `http://localhost:4000/soap-proxy`.

---

## Verificar se o proxy está no ar

Acesse no navegador:
```
http://localhost:3000/health
```

Resposta esperada:
```json
{ "status": "ok", "target": "http://127.0.0.1:8091/ws/ZWSFORN.apw" }
```

---

## Parar o proxy

No terminal onde o proxy está rodando pressione:
```
Ctrl + C
```

---

## Erros comuns

| Erro | Causa | Solução |
|---|---|---|
| `Cannot find module 'express'` | Dependências não instaladas | Rode `npm install express cors node-fetch@2` |
| `EADDRINUSE: address already in use` | Porta 3000 ocupada | Troque a porta com `$env:PORT="4001"` |
| `ECONNREFUSED` | Protheus não está acessível | Verifique se o Protheus está rodando e a URL está correta |
| `Failed to fetch` no HTML | Proxy não está rodando | Suba o proxy antes de usar o HTML |
| `CORS error` no HTML | Acessando Protheus direto sem proxy | Use `http://localhost:3000/soap-proxy` no campo endpoint |

---

## Rodar o proxy automaticamente no Windows (opcional)

Para não precisar abrir o terminal toda vez, crie um arquivo `iniciar-proxy.bat` na pasta do proxy:

```bat
@echo off
set PROTHEUS_URL=http://127.0.0.1:8091/ws/ZWSFORN.apw
node proxy.js
pause
```

Dê dois cliques no `.bat` para iniciar o proxy sem precisar abrir o PowerShell.

---

## Estrutura de arquivos

```
D:\PROXY\
├── proxy.js                  ← servidor proxy
├── iniciar-proxy.bat         ← atalho para iniciar (opcional)
└── node_modules\             ← criado automaticamente pelo npm install
```

```
D:\HTML\
└── cadastro-fornecedor.html  ← interface de cadastro
```

---

*Gerado para o projeto zWSForn — Cadastro de Fornecedores SA2 via SOAP Protheus*
