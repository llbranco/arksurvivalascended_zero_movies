#!/usr/bin/env bash

# ------------------------------------------------------------
# Script para substituir todos os arquivos .bk2 (recursivamente)
# em Mods, Saved/Cache/Movies e Content/Movies pelo dummy.bk2.
# Pode ser executado de qualquer lugar — os caminhos são
# resolvidos a partir da pasta onde este script está.
# ------------------------------------------------------------

set -euo pipefail

DUMMY_URL="https://raw.githubusercontent.com/llbranco/arksurvivalascended_zero_movies/main/dummy.bk2"
DUMMY_FILE="dummy.bk2"

# Pasta onde este script está (funciona mesmo via symlink)
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

# Pastas-alvo, relativas ao SCRIPT_DIR (assumindo que ele está em
# ARK Survival Ascended/ShooterGame/Content/Movies/)
DEFAULT_DIRS=(
  "$SCRIPT_DIR"                                              # Content/Movies
  "$SCRIPT_DIR/../../../Binaries/Win64/ShooterGame/Mods"     # todos os mods
  "$SCRIPT_DIR/../../../Saved/Cache/Movies"                  # cache de vídeos
)

# Baixa o dummy no diretório do script (não no pwd)
cd "$SCRIPT_DIR"
echo "Baixando $DUMMY_FILE ..."
curl -L -o "$DUMMY_FILE" "$DUMMY_URL"

if [[ ! -s "$DUMMY_FILE" ]]; then
    echo "ERRO: Falha ao baixar $DUMMY_FILE ou o arquivo está vazio." >&2
    exit 1
fi

# Usa pastas passadas por argumento; se não houver, usa as padrão.
if [[ $# -gt 0 ]]; then
    DIRS=("$@")
else
    DIRS=("${DEFAULT_DIRS[@]}")
fi

echo "Substituindo todos os arquivos .bk2 nas pastas..."

for dir in "${DIRS[@]}"; do
    if [[ ! -d "$dir" ]]; then
        echo "AVISO: pasta não encontrada, pulando: $dir" >&2
        continue
    fi

    # Percorre recursivamente todos os .bk2 (inclui subpastas de Mods)
    while IFS= read -r -d '' bk2; do
        # Não sobrescreve o próprio dummy
        if [[ "$(basename "$bk2")" == "$DUMMY_FILE" ]]; then
            continue
        fi

        cp -f "$DUMMY_FILE" "$bk2"
        echo "  -> $bk2 substituído"
    done < <(find "$dir" -type f -name '*.bk2' -print0)
done

echo "Concluído. Todos os .bk2 foram substituídos pelo dummy."
