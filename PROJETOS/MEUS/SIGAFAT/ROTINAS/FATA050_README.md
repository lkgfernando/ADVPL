# FATA050 — Consulta de Status de NF-e na SEFAZ

Rotina ADVPL para o módulo **SIGAFAT (Faturamento)** do TOTVS Protheus.
Consulta o status atual de NF-es emitidas diretamente na SEFAZ, a partir dos registros da tabela SF2.

---

## Funcionalidade

1. Exibe tela de parâmetros interativa (SX1 / `Pergunte`) para filtrar por período, número de NF e cliente.
2. Executa query na SF2 (com JOIN em SA1) retornando apenas NF-es que possuam chave de acesso (`F2_CHVNFE`) preenchida.
3. Para cada NF-e encontrada, consulta o status atual na SEFAZ via a chave de 44 dígitos.
4. Exibe os resultados em browse modal com status SEFAZ ao lado do status local.

---

## Como Usar

No **SmartClient**, execute:

```
U_FATA050
```

Preencha os parâmetros na tela exibida e confirme. O resultado aparecerá em um browse com as colunas descritas abaixo.

---

## Parâmetros (SX1 — grupo `FATA050`)

| Ordem | Tipo | Campo    | Descrição              | Default         |
|-------|------|----------|------------------------|-----------------|
| 01    | D    | MV_PAR01 | Data de Emissão De     | Data atual      |
| 02    | D    | MV_PAR02 | Data de Emissão Até    | Data atual      |
| 03    | C    | MV_PAR03 | NF De (9 chars)        | Espaços         |
| 04    | C    | MV_PAR04 | NF Até (9 chars)       | `Chr(255)` × 9  |
| 05    | C    | MV_PAR05 | Cliente De (6 chars)   | Espaços         |
| 06    | C    | MV_PAR06 | Cliente Até (6 chars)  | `Chr(255)` × 6  |

> Os registros no SX1 são criados automaticamente na primeira execução.

---

## Colunas do Browse

| Coluna        | Origem                        |
|---------------|-------------------------------|
| NF            | `SF2.F2_DOC`                  |
| Série         | `SF2.F2_SERIE`                |
| Emissão       | `SF2.F2_EMISSAO`              |
| Cliente       | `SF2.F2_CLIENTE` + `F2_LOJA`  |
| Nome          | `SA1.A1_NOME`                 |
| Chave NF-e    | `SF2.F2_CHVNFE` (truncada)    |
| Status Local  | `SF2.F2_NFESTA`               |
| Status SEFAZ  | Retorno da consulta online    |
| Valor         | `SF2.F2_VALBRUT`              |

---

## Consulta de Status na SEFAZ

A função `fConsultaStatusNFe` tenta obter o status em ordem de prioridade:

1. **`FWNFeSitNF(cChave)`** — função framework padrão (Protheus 12+)
2. **`NFECONSULTA(cChave)`** — fallback para versões anteriores
3. **Status local (`F2_NFESTA`)** — usado quando ambas as funções acima não estão disponíveis ou retornam erro

### Mapeamento de códigos SEFAZ

| Código | Descrição      |
|--------|----------------|
| 100    | Autorizada     |
| 101    | Cancelada      |
| 110    | Denegada       |
| 217    | Não encontrada |
| 301    | Uso denegado   |
| 302    | Rejeição       |

Quando a consulta online não está disponível, o status local é exibido com o sufixo `(local)`.

---

## Estrutura do Arquivo

```
FATA050.prw
│
├── User Function FATA050        — Entry point / orquestrador
├── Static Function ValidPerg    — Cria registros SX1 se ausentes
├── Static Function fMontaResultados — Query BeginSQL em SF2/SA1
├── Static Function fConsultaStatusNFe — Consulta status na SEFAZ
├── Static Function fExibeResultados — Prepara dados para o browse
└── Static Function fExibeBrowse — Renderiza MsDialog + aTBrowse
```

---

## Tabelas Utilizadas

| Tabela | Uso                          |
|--------|------------------------------|
| SF2    | Cabeçalho de NF-e de saída   |
| SA1    | Cadastro de clientes (JOIN)  |
| SX1    | Perguntas / parâmetros       |

---

## Requisitos

- TOTVS Protheus 12 (compatível com versões anteriores via fallback)
- Módulo SIGAFAT habilitado
- Acesso de leitura às tabelas SF2 e SA1
- Acesso de escrita ao SX1 para criação automática das perguntas (opcional — fallback silencioso se negado)
- Conectividade com a SEFAZ para consulta online (fallback local disponível)

---

## Compilação

Compile o arquivo `.prw` pelo **TDS (TOTVS Developer Studio)** ou pela extensão **TOTVS Developer Studio for VS Code**:

1. Abra `FATA050.prw` no IDE
2. Compile (`F11` no TDS ou `Ctrl+Shift+B` no VS Code com extensão TOTVS)
3. Verifique que não há erros de compilação no log
4. Teste com `U_FATA050` no SmartClient

---

## Convenções de Código

- **Notação húngara**: `c` (Character), `d` (Date), `n` (Numeric), `l` (Logical), `a` (Array), `o` (Object)
- **Prefixo `f`** em todas as Static Functions internas
- **`GetArea()` / `RestArea()`** em todas as funções que manipulam áreas de trabalho
- **`Begin Sequence / Recover / End Sequence`** em todos os blocos com risco de erro de runtime
- **`xFilial()`** para filtro por filial nas queries
- **`%table:%`, `%xFilial:%`, `%exp:%`** para macros BeginSQL (portabilidade multi-banco)
- **Protheus.doc** em todas as funções

---

## Autoria

Gerado em 12/03/2026.
Módulo: SIGAFAT — Faturamento
Arquivo: `PROJETOS\MEUS\SIGAFAT\ROTINAS\FATA050.prw`
