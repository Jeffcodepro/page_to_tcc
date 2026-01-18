# Copilot / AI agent instructions — page_to_tcc

Breve guia para agentes AI que vão editar ou ajudar neste repositório Rails 7.

1) Big picture
- Tipo: Rails 7 monolito (server-rendered) com Hotwire/Stimulus para JS leve.
- Linguagem/versão: Ruby 3.3.5 (ver `Gemfile`). Rails ~> 7.1 (ver `Gemfile`).
- Banco: PostgreSQL (ver `config/database.yml`).
- Deploy containerizado: existe `Dockerfile` e `bin/docker-entrypoint` (produção usa env vars para senha e secrets).

2) Arquitetura e fluxos importantes
- Views server-rendered: `app/views/*` — UI principal é gerada no servidor.
- JS: importmap + Stimulus. Controllers estão em `app/javascript/controllers` e são carregados por `app/javascript/controllers/index.js`.
- Styles: Sprockets + SCSS em `app/assets/stylesheets/` com partials `config/` e `components/` (padrão Le Wagon).
- Formulários: `simple_form` com configuração Bootstrap em `config/initializers/simple_form_bootstrap.rb`.
- Rotas: app começa em `pages#home` (veja `config/routes.rb`).

3) Comandos de desenvolvimento e workflows (exemplos concretos)
- Setup dev (local):
  - `bin/setup` — instala gems, prepara DB e limpa tmp/logs (veja `bin/setup`).
  - `bin/rails db:prepare` — cria/migrates/seed conforme necessário.
- Rodar app localmente:
  - `bin/rails server` (padrão porta 3000)
  - Ou via Docker: `docker build -t page_to_tcc .` e `docker run -e PAGE_TO_TCC_DATABASE_PASSWORD=... -p 3000:3000 page_to_tcc` (Dockerfile já define entrypoint `bin/docker-entrypoint`).
- Testes: Minitest (`bin/rails test` / `bundle exec rails test`). System tests usam Capybara/Selenium (ver `Gemfile` grupo :test).
- Assets: pré-compilação em produção é feita no Dockerfile via `bin/rails assets:precompile` com `SECRET_KEY_BASE_DUMMY=1` para evitar erro sem chave.

4) Convenções e padrões do projeto
- Importmap: não há Node/Yarn/webpack; adicione controllers JS em `app/javascript/controllers/*_controller.js` e registre via `importmap` (veja `app/javascript/controllers/index.js`).
- SCSS: organize variáveis em `app/assets/stylesheets/config/*` e componentes em `app/assets/stylesheets/components/*`.
- Simple Form + Bootstrap: use os wrappers definidos em `config/initializers/simple_form_bootstrap.rb` (ex.: `:vertical_form`, `:horizontal_form`).
- Layouts: page wrapper e elementos principais em `app/views/layouts/application.html.erb` (usar Turbo/Turbo Frames quando necessário).

5) Integrações e pontos de atenção
- Banco: espera PostgreSQL localmente ou via `DATABASE_URL`. Em produção, senha via `PAGE_TO_TCC_DATABASE_PASSWORD`.
- Assets/Imagem: ActiveStorage não está habilitado por padrão (ver `Gemfile` — `image_processing` está comentado).
- Caching: `bootsnap` usado no build para acelerar boots (ver `Dockerfile` e `Gemfile`).

6) Como um agente deve atuar aqui (regras práticas)
- Faça mudanças pequenas e testáveis: prefira editar um controller/view/stylesheet por PR.
- Não introduza ferramentas Node/Yarn sem necessidade — projeto usa importmap.
- Ao alterar assets em produção, verifique Dockerfile e fluxo de pré-compilação (`SECRET_KEY_BASE_DUMMY` no Dockerfile).
- Ao tocar em DB/schema, inclua uma migration; rode `bin/rails db:migrate` localmente e atualize `db/schema.rb`.
- Para mudanças JS, registre controllers em `app/javascript/controllers/index.js` e atualize `config/importmap.rb` se adicionar pacotes externos.

7) Arquivos de referência rápidos (exemplos citados)
- Rotas e root: config/routes.rb
- Stimulus entry: app/javascript/controllers/index.js
- SCSS padrão: app/assets/stylesheets/application.scss
- Simple Form config: config/initializers/simple_form_bootstrap.rb
- Docker build/run: Dockerfile, bin/docker-entrypoint
- Setup local: bin/setup

8) Checklist mínimo para PRs gerados por AI
- Existe teste cobrindo mudança (ou explicação porque não é necessário).
- `bin/setup` e `bin/rails test` passam localmente (ou instruções para reproduzir via Docker).
- Não altere credenciais; use variáveis de ambiente.

Se algo estiver incompleto ou você quiser que eu inclua exemplos de código/trechos de arquivos específicos, diga quais partes quer que eu detalhe.
