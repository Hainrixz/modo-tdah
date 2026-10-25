#!/usr/bin/env sh
# Portions Copyright (c) 2026 Enrique Rocha (@soyenriquerocha) - see LICENSE for original authors
# SPDX-License-Identifier: MIT
# id: er-3c24cb00
# Hook de SessionStart: inyecta el ruleset completo de modo-tdah cuando el usuario
# se dio de alta creando $CLAUDE_CONFIG_DIR/.modo-tdah-always (por defecto ~/.claude).
# Nunca bloquea el arranque de sesión: cualquier fallo sale con 0.
#
# POSIX sh puro para que corra en cualquier lado donde Claude Code ejecute un hook
# de comando (sh en macOS/Linux, Git Bash en Windows) sin depender de que haya un
# Node en el PATH.

claude_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
flag_path="$claude_dir/.modo-tdah-always"

# Solo dispara si el usuario se dio de alta.
[ -f "$flag_path" ] || exit 0

# $0 es la ruta absoluta del script que Claude Code sustituye en hooks.json, así que
# resolvemos SKILL.md relativo a ella en vez de confiar en una variable de entorno.
script_dir=$(dirname -- "$0")
skill_path="$script_dir/../skills/modo-tdah/SKILL.md"
[ -f "$skill_path" ] || exit 0

# Quita el bloque de frontmatter YAML del inicio (--- ... --- al principio del archivo).
body=$(awk '
  NR == 1 && $0 ~ /^---[[:space:]]*$/ { in_fm = 1; next }
  in_fm && $0 ~ /^---[[:space:]]*$/   { in_fm = 0; next }
  !in_fm                              { print }
' "$skill_path") || exit 0

printf 'MODO ADHD ACTIVO (siempre encendido). Las reglas de abajo aplican a todas las respuestas. Decir "modo normal" lo apaga en esta sesión; borrar %s lo apaga para siempre.\n\n%s\n' \
  "$flag_path" "$body"
