#!/usr/bin/env bash

# ------------------------------------------------------------
# Script para substituir todos os arquivos .bk2 de uma pasta
# pelo arquivo dummy.bk2 baixado do GitHub.
# ------------------------------------------------------------

set -euo pipefail   # Aborta em erro, variável não definida ou pipe failure

# URL RAW do arquivo dummy.bk2 (o link "blob" do GitHub não serve para download direto)
DUMMY_URL="https://raw.githubusercontent.com/llbranco/arksurvivalascended_zero_movies/main/dummy.bk2"
DUMMY_FILE="dummy.bk2"

echo "Baixando $DUMMY_FILE ..."
# -L segue redirecionamentos; -o salva com o nome desejado
curl -L -o "$DUMMY_FILE" "$DUMMY_URL"

# Verifica se o download foi bem-sucedido (arquivo existe e não está vazio)
if [[ ! -s "$DUMMY_FILE" ]]; then
    echo "ERRO: Falha ao baixar $DUMMY_FILE ou o arquivo está vazio." >&2
    exit 1
fi

echo "Substituindo todos os arquivos .bk2 na pasta atual..."

# Percorre todos os arquivos com extensão .bk2 no diretório atual
for bk2 in *.bk2; do
    # Se não houver nenhum arquivo .bk2, o glob não expande e o loop tenta usar o literal "*.bk2"
    [[ -e "$bk2" ]] || continue

    # Não sobrescreve o próprio dummy (caso ele já exista na pasta)
    if [[ "$bk2" == "$DUMMY_FILE" ]]; then
        continue
    fi

    # Copia o dummy sobre o arquivo original, preservando o nome
    cp -f "$DUMMY_FILE" "$bk2"
    echo "  -> $bk2 substituído"
done

echo "Concluído. Todos os .bk2 foram substituídos pelo dummy."
