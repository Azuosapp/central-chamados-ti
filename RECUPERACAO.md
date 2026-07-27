# Backup e Recuperação — Central de Chamados TI

Guia prático para (1) manter backup do que importa e (2) reconstruir o projeto do
zero se necessário. **Este arquivo não contém senhas** — apenas onde encontrá-las.

---

## Onde tudo vive (mapa rápido)

| Parte | Onde está | O que é |
|---|---|---|
| Código | **GitHub** (`Queiroz-design/central-chamados-ti-azuos`) | páginas, funções `api/`, agentes, SQLs, README |
| Site no ar | **Vercel** (projeto `central-chamados-ti-azuos`) | hospedagem + variáveis/segredos |
| Dados e login | **Supabase** (projeto do Grupo Azuos) | banco (chamados, inventário, telemetria) + usuários |

Perder o computador **não** perde o projeto — tudo isso está na nuvem. O que você
realmente precisa proteger é o **acesso às 3 contas**.

---

## 1. Proteja o acesso às contas (o mais importante)

Para GitHub, Vercel e Supabase, garanta que você consegue entrar de outro
computador:

- Guarde as senhas num **gerenciador de senhas**.
- Confirme o **e-mail de recuperação** de cada conta.
- Se usar verificação em duas etapas (2FA), **salve os códigos de backup**.

---

## 2. Backup regular dos dados (recomendado)

O Supabase no plano free **não faz backup automático**. Faça cópias de tempos em
tempos (ex.: 1x por mês):

- **Chamados e inventário:** no Painel do TI, use os botões **"Baixar relatório"**
  (chamados) e **"Baixar relatório do departamento"** (inventário). Guarde os CSVs
  num local seguro (Drive, OneDrive, etc.).
- **Cópia do código:** no GitHub, botão verde **Code → Download ZIP**. Guarde o ZIP.
- **Anote onde ficam os segredos** (não os valores): as variáveis estão em
  **Vercel → Settings → Environment Variables** (`SUPABASE_URL`,
  `SUPABASE_SECRET_KEY`, `COLETOR_SECRET`, `UNIFI_WEBHOOK_SECRET`).

---

## 3. Cenários de recuperação

### A) Perdi/troquei de computador (mais comum)
Nada quebra — site, código e dados seguem na nuvem. Para voltar a trabalhar no
novo PC, baixe o código: **GitHub → Code → Download ZIP** (ou "Open with GitHub
Desktop"). Pronto.

### B) Preciso republicar o site (Vercel)
1. Em **vercel.com**, crie um projeto novo ligado ao repositório do GitHub
   (ou use o projeto existente).
2. Em **Settings → Environment Variables**, recrie as 4 variáveis
   (`SUPABASE_URL`, `SUPABASE_SECRET_KEY`, `COLETOR_SECRET`, `UNIFI_WEBHOOK_SECRET`).
3. Faça um **Deploy**.

### C) Preciso recriar o banco (novo projeto Supabase) — recuperação completa
1. Crie um projeto novo no **Supabase**. Anote a nova **Project URL** e a
   **anon key** (Settings → API).
2. **SQL Editor** — rode os arquivos nesta ordem:
   1. `supabase-hardware-inventory.sql`
   2. `supabase-performance-monitoring.sql`
   3. `supabase-network-alerts.sql`
   4. `supabase-rls-seguranca.sql`
   5. `supabase-rls-fechar-coletores.sql`
   6. `supabase-rls-fechar-chamados.sql`
3. **Storage:** crie um bucket **público** chamado `chamados-prints` (guarda os
   prints dos chamados).
4. **Authentication → Users:** recrie os usuários do painel (ex.:
   `admin@azuos.local`) com **Auto Confirm**.
5. **Atualize as referências à nova URL/anon key:**
   - `config.js` (raiz) — `SUPABASE_URL` e `SUPABASE_ANON_KEY`.
   - Se o domínio do site mudar, ajuste as URLs nos agentes
     (`agente-inventario-azuos.ps1`, `agente-desempenho-azuos.ps1`,
     `coletor-hardware-azuos.ps1`, `monitor-desempenho-azuos.ps1`,
     `instalar-inventario-azuos.bat`, `executar-coletor-azuos.bat`).
6. **Vercel → Environment Variables:** aponte `SUPABASE_URL` e
   `SUPABASE_SECRET_KEY` para o novo projeto e faça **Redeploy**.
7. **Restaurar dados** (se tiver os CSVs): importe-os no Supabase
   (Table Editor → Insert → Import data from CSV) nas tabelas correspondentes.

---

## 4. Valores de referência (sem segredos)

- Bucket de prints: `chamados-prints` (público)
- Domínio de login dos usuários: `usuario@azuos.local`
- Variáveis de ambiente (nomes): `SUPABASE_URL`, `SUPABASE_SECRET_KEY`,
  `COLETOR_SECRET`, `UNIFI_WEBHOOK_SECRET`
- A `SUPABASE_SECRET_KEY` (service key) fica em **Supabase → Settings → API**.

> Consulte o `README.md` para a arquitetura completa e o que cada arquivo faz.
