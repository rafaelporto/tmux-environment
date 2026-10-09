#!/bin/sh
# Barra de status legivel no console do Linux (VT, TERM=linux), sem afetar outros clientes.
#
# O console nao desenha glifos Nerd Font, e os temas usam os separadores powerline
# (U+E0B0..U+E0B3). Este script le o que o tema acabou de definir, guarda duas versoes de
# cada formato em opcoes @tty-status-* e troca o formato por um condicional por cliente:
# quem esta no console ve a versao sem glifos, os demais (SSH, kitty) a original.
#
# Roda via `run-shell` no .tmux.conf, depois do tema, so com `set -g @tty_ascii on` em
# local.conf. Pode rodar de novo a cada `prefix + r`.
#
# Cobre os temas manuais (tokyonight_*), que escrevem os glifos direto nos formatos. Nos temas
# de plugin (catppuccin, dracula, rose-pine) os glifos ficam em opcoes do plugin, expandidas so
# na hora de desenhar, e este script nao os alcanca.

[ "$(uname -s)" = Linux ] || exit 0

# Separadores cheios somem; os finos viram '|'.
cheio_dir=$(printf '\356\202\260')   # U+E0B0
fino_dir=$(printf '\356\202\261')    # U+E0B1
cheio_esq=$(printf '\356\202\262')   # U+E0B2
fino_esq=$(printf '\356\202\263')    # U+E0B3

condicional='#{?#{==:#{client_termname},linux},'

# envolver <escopo: -g|-gw> <opcao>
envolver() {
  escopo=$1
  opcao=$2
  valor=$(tmux show "$escopo" -v -q "$opcao")

  # Ja envolvido (o tema nao redefiniu esta opcao desde a ultima vez): nada a fazer.
  case $valor in "$condicional"*) return ;; esac

  tty=$(printf '%s' "$valor" | LC_ALL=C sed \
    -e "s/$cheio_dir//g" -e "s/$cheio_esq//g" \
    -e "s/$fino_dir/|/g" -e "s/$fino_esq/|/g")

  tmux set -g "@tty-$opcao-nerd" "$valor"
  tmux set -g "@tty-$opcao-tty" "$tty"
  tmux set "$escopo" "$opcao" "$condicional#{E:@tty-$opcao-tty},#{E:@tty-$opcao-nerd}}"
}

envolver -g status-left
envolver -g status-right
envolver -gw window-status-format
envolver -gw window-status-current-format
