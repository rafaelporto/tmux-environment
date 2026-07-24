# Referência tmux

Referência prática de comandos, atalhos e funcionalidades do tmux.

> **O prefixo desta config é `Ctrl-a`** (remapeado do padrão `Ctrl-b`). Todos os atalhos abaixo usam `prefix` para indicar `Ctrl-a`.

---

## Conceitos Fundamentais

| Termo | Descrição |
|-------|-----------|
| **Session** | Coleção nomeada de janelas. Sobrevive à desconexão do terminal. |
| **Window** | Uma tela dentro de uma sessão, contendo um ou mais panes. |
| **Pane** | Área retangular de terminal dentro de uma janela. |
| **Client** | Terminal conectado ao servidor tmux. |

---

## Comandos CLI

### Sessões

```bash
tmux                          # Iniciar nova sessão sem nome
tmux new -s <nome>            # Iniciar nova sessão com nome
tmux attach                   # Conectar à última sessão
tmux attach -t <nome>         # Conectar a uma sessão pelo nome
tmux ls                       # Listar sessões ativas
tmux kill-session -t <nome>   # Encerrar uma sessão
tmux kill-server              # Encerrar todas as sessões e o servidor
```

### Janelas

```bash
tmux new-window               # Criar nova janela
tmux rename-window <nome>     # Renomear janela atual
```

### Servidor

```bash
tmux source-file ~/.tmux.conf # Recarregar config sem reiniciar
```

---

## Atalhos de Teclado

### Sessão

| Atalho | Ação |
|--------|------|
| `prefix + d` | Desconectar da sessão (detach) |
| `prefix + s` | Navegar e trocar de sessão (visão em árvore) |
| `prefix + $` | Renomear sessão atual |
| `prefix + (` | Ir para a sessão anterior |
| `prefix + )` | Ir para a próxima sessão |

### Janelas

| Atalho | Ação |
|--------|------|
| `prefix + c` | Criar nova janela |
| `prefix + ,` | Renomear janela atual |
| `prefix + w` | Navegar por janelas (visão em árvore) |
| `prefix + n` | Ir para a próxima janela |
| `prefix + p` | Ir para a janela anterior |
| `prefix + 0–9` | Ir para janela pelo número |
| `prefix + &` | Fechar janela atual (com confirmação) |

### Panes

| Atalho | Ação |
|--------|------|
| `prefix + %` | Dividir verticalmente (esquerda/direita) |
| `prefix + "` | Dividir horizontalmente (cima/baixo) |
| `prefix + h/j/k/l` | Navegar entre panes (estilo vim, nesta config) |
| `prefix + setas` | Navegar entre panes (padrão) |
| `prefix + o` | Ir para o próximo pane |
| `prefix + q` | Exibir números dos panes (pressione o número para ir) |
| `prefix + z` | Alternar zoom no pane atual (tela cheia) |
| `prefix + {` | Trocar pane com o anterior |
| `prefix + }` | Trocar pane com o próximo |
| `prefix + x` | Fechar pane atual (com confirmação) |
| `prefix + !` | Transformar pane em janela própria |

### Redimensionar Panes

| Atalho | Ação |
|--------|------|
| `prefix + Ctrl-seta` | Redimensionar pane (passo pequeno) |
| `prefix + Alt-seta` | Redimensionar pane (passo grande) |

### Layouts de Pane

| Atalho | Ação |
|--------|------|
| `prefix + Alt-1` | Horizontal uniforme |
| `prefix + Alt-2` | Vertical uniforme |
| `prefix + Alt-3` | Horizontal principal |
| `prefix + Alt-4` | Vertical principal |
| `prefix + Alt-5` | Mosaico |
| `prefix + Space` | Alternar entre layouts |

Para voltar dois painéis lado a lado a uma divisão igual de 50/50, execute `select-layout even-horizontal` no prompt de comando (`even-vertical` se estiverem um acima do outro).

### Modo de Cópia (vi)

Esta config usa teclas vi (`mode-keys vi`).

| Atalho | Ação |
|--------|------|
| `prefix + [` | Entrar no modo de cópia |
| `prefix + ]` | Colar do buffer |
| `q` | Sair do modo de cópia |
| `h/j/k/l` | Mover cursor |
| `w / b` | Pular palavra para frente / trás |
| `0 / $` | Início / fim da linha |
| `g / G` | Ir para o topo / fim |
| `/` | Buscar para frente |
| `?` | Buscar para trás |
| `n / N` | Próximo / anterior resultado da busca |
| `Space` | Iniciar seleção |
| `Enter` | Copiar seleção e sair |
| `v` | Alternar seleção retangular |

### Diversos

| Atalho | Ação |
|--------|------|
| `prefix + ?` | Exibir todos os atalhos |
| `prefix + :` | Abrir prompt de comando tmux |
| `prefix + t` | Exibir relógio |
| `prefix + ~` | Exibir mensagens do tmux |
| `prefix + r` | Recarregar config (nesta config) |
| `prefix + Ctrl-l` | Limpar a tela (nesta config — envia `C-l` ao shell, já que `Ctrl-l` é capturado pelo vim-tmux-navigator) |
| `prefix + Ctrl-k` | Limpar o scrollback do pane (nesta config — executa `clear-history`; preserva o contexto de uma app em execução, ex. Claude Code) |
| `prefix + D` | Dividir o pane lado a lado (nesta config — o novo painel à direita fica com 1/3 da largura, o original mantém 2/3) |

---

## Prompt de Comando

Pressione `prefix + :` para abrir o prompt de comando do tmux. Comandos úteis:

```
new-window -n <nome>          # Nova janela com nome
split-window -h               # Dividir horizontalmente
split-window -v               # Dividir verticalmente
kill-pane                     # Fechar pane atual
resize-pane -D/U/L/R <n>      # Redimensionar pane em n células
swap-window -t <n>            # Mover janela atual para posição n
move-window -t <sessão>:<n>   # Mover janela para outra sessão
set-option -g mouse on        # Ativar mouse em tempo de execução
```

---

## Suporte ao Mouse

O mouse está **ativado** nesta config (`set -g mouse on`).

Com o mouse ativado:
- Clique em um pane para focar
- Arraste bordas de panes para redimensionar
- Clique nas abas de janelas para trocar
- Role o scroll para entrar no modo de cópia automaticamente (scrollback)
- A roda é repassada a apps de tela alternativa (ex. Claude Code em fullscreen), rolando o conteúdo *delas*

**Atenção — seleção de texto:** com o mouse ligado, arrastar seleciona para o buffer do tmux, contornando a seleção/cópia nativa do terminal. Para selecionar no modo do próprio terminal, segure `Option`/`Alt` (macOS, iTerm2/Terminal.app) enquanto arrasta.

Para desativar em tempo de execução:

```
prefix + :  →  set-option -g mouse off
```

---

## Referência Rápida de Configuração

### Opções

```bash
set -g <opção> <valor>        # Definir opção global
setw -g <opção> <valor>       # Definir opção de janela (alias: set-window-option)
set -s <opção> <valor>        # Definir opção de servidor
```

### Opções Comuns

```bash
set -g base-index 1           # Iniciar numeração de janelas em 1
set -g renumber-windows on    # Renumerar janelas ao fechar uma
set -g history-limit 50000    # Tamanho do buffer de scrollback
set -g display-time 2000      # Duração de mensagens na status bar (ms)
set -g status-position top    # Mover status bar para o topo
set -g mouse on               # Ativar suporte ao mouse
setw -g mode-keys vi          # Usar teclas vi no modo de cópia
```

### Sintaxe de Atalhos

```bash
bind <tecla> <comando>        # Atalho com prefix
bind -n <tecla> <comando>     # Atalho sem prefix
bind -T copy-mode-vi <tecla> send-keys -X <ação>  # Atalho no modo de cópia
unbind <tecla>                # Remover um atalho
```

---

## Variáveis de Ambiente

| Variável | Finalidade |
|----------|------------|
| `TMUX` | Definida quando dentro de uma sessão tmux (contém o caminho do socket) |
| `TMUX_PANE` | ID do pane atual (ex: `%0`) |
| `$TERM` | Deve ser `screen-256color` ou `tmux-256color` dentro do tmux |

---

## TPM — Gerenciador de Plugins

| Atalho | Ação |
|--------|------|
| `prefix + I` | Instalar novos plugins |
| `prefix + U` | Atualizar plugins instalados |
| `prefix + Alt-u` | Remover plugins não utilizados |

Plugins são declarados no `.tmux.conf`:

```bash
set -g @plugin 'owner/repo'
```

O TPM deve ser inicializado no **final** do `.tmux.conf`:

```bash
run '~/.config/tmux/plugins/tpm/tpm'
```

---

## Padrões Úteis

### Dois terminais na mesma sessão, janelas independentes (Session Grouping)

Conectar dois clientes à **mesma sessão** faz ambos espelharem a mesma janela. Para que cada terminal possa navegar por janelas de forma independente, crie uma segunda sessão vinculada à original:

```bash
# Terminal 1 — cria a sessão
tmux new -s work

# Terminal 2 — cria sessão vinculada (session grouping)
tmux new-session -t work
```

Resultado:
- Cada terminal navega por janelas de forma independente
- O conteúdo dos panes é compartilhado (mesmo processo rodando)
- Criar ou fechar janelas em um terminal reflete no outro

### Enviar um comando para todos os panes de uma janela

```
prefix + :  →  setw synchronize-panes on
```

Repita com `off` para desativar. Útil para rodar o mesmo comando em múltiplos servidores simultaneamente.

### Terminal flutuante sobreposto (display-popup)

Abre um terminal flutuante sobre o que você está fazendo, sem sair da janela atual:

```
prefix + :  →  display-popup -E
```

Para mapear a um atalho no `.tmux.conf`:

```bash
bind g display-popup -E
```

### Salvar output do pane em arquivo (pipe-pane)

Captura tudo que é exibido no pane atual em um arquivo de log:

```
prefix + :  →  pipe-pane -o 'cat >> ~/tmux.log'
```

Execute o mesmo comando novamente para parar a captura.

### Mover um pane para outra janela (join-pane)

O inverso do `prefix + !`. Incorpora um pane de outra janela na janela atual:

```
prefix + :  →  join-pane -s <sessão>:<janela>.<pane>
```

Exemplo — trazer o pane 1 da janela 2 da sessão atual:

```
join-pane -s :2.1
```

### Compartilhar sessão com outro usuário (mesmo servidor)

Dois usuários diferentes podem se conectar ao mesmo socket tmux para colaboração em tempo real:

```bash
# Usuário A — inicia o tmux com socket compartilhado
tmux -S /tmp/shared new -s pair

# Conceder acesso ao socket
chmod 777 /tmp/shared

# Usuário B — conecta via socket compartilhado
tmux -S /tmp/shared attach -t pair
```

Ambos os usuários veem e controlam a mesma sessão. Útil para pair programming no terminal.

### Montar um ambiente de dev completo com script

Um script shell que cria uma sessão, abre janelas nomeadas e executa comandos em cada uma — todo o seu ambiente com um único comando:

```bash
#!/usr/bin/env bash
SESSION="dev"

tmux new-session -d -s $SESSION -n editor
tmux send-keys -t $SESSION:editor "nvim ." Enter

tmux new-window -t $SESSION -n server
tmux send-keys -t $SESSION:server "npm run dev" Enter

tmux new-window -t $SESSION -n logs
tmux send-keys -t $SESSION:logs "tail -f app.log" Enter

tmux attach -t $SESSION
```

### Enviar teclas para um pane sem navegar até ele (send-keys)

Execute um comando em qualquer pane sem sair do atual:

```bash
tmux send-keys -t <sessão>:<janela>.<pane> "comando" Enter
```

Exemplo — enviar um comando para o pane 0 da janela 2 da sessão `work`:

```bash
tmux send-keys -t work:2.0 "git status" Enter
```

É a base para automação e scripts com tmux.

### Seletor fuzzy de sessões/janelas com fzf

Seletor interativo combinando `tmux ls` e `fzf`:

```bash
tmux attach -t $(tmux ls -F '#S' | fzf)
```

Para trocar de janela dentro de uma sessão:

```bash
tmux select-window -t $(tmux list-windows -F '#I: #W' | fzf | cut -d: -f1)
```

Mapeie a um atalho para acesso rápido:

```bash
bind f run-shell "tmux attach -t \$(tmux ls -F '#S' | fzf --tmux)"
```

### Renomear janela automaticamente com o comando em execução

```bash
set -g automatic-rename on
set -g automatic-rename-format '#{b:pane_current_path}'
```

### Persistir sessões após crashes e reinicializações

Ativo nesta config via [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) e [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum):

```bash
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @resurrect-capture-pane-contents 'on'
set -g @resurrect-strategy-nvim 'session'

set -g @continuum-restore 'on'
set -g @continuum-save-interval '15'
```

- **Auto-save**: o continuum salva o estado completo da sessão a cada 15 minutos, em segundo plano.
- **Auto-restore**: o último estado salvo é restaurado automaticamente na próxima vez que o tmux é iniciado — sem precisar fazer nada.
- `prefix + Ctrl-s` — Salvar sessão manualmente
- `prefix + Ctrl-r` — Restaurar sessão manualmente
- O scrollback dos panes é capturado (`@resurrect-capture-pane-contents`). Sessões do `nvim` são reabertas via sua própria estratégia de sessão.
- Restaurar traz de volta janelas, panes e diretórios de trabalho — **não** retoma o estado interno de um programa em execução (ex: uma conversa em andamento no Claude Code); o pane reabre no diretório certo para você reiniciar a ferramenta lá.

---

## Referências

- [Página de manual do tmux](https://man.openbsd.org/tmux) — Referência completa de comandos e opções
- [tmux no GitHub](https://github.com/tmux/tmux) — Código-fonte e releases
- [Wiki do tmux](https://github.com/tmux/tmux/wiki) — Guia de início, uso avançado, receitas
- [TPM](https://github.com/tmux-plugins/tpm) — Gerenciador de plugins
- [tmux-plugins org](https://github.com/tmux-plugins) — Plugins da comunidade
