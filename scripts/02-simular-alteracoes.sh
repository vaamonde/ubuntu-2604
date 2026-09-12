#!/bin/bash
#
# Script: 02-simular-alteracoes.sh
# Autor: Robson Vaamonde
# Projeto: Curso GRÁTIS de GNU/Linux Ubuntu Server 26.04.x LTS - Segurança e Hardening
# Procedimentos em TI: http://procedimentosemti.com.br
# Bora para Prática: http://boraparapratica.com.br
#
# Objetivo: Simular alterações (edição de arquivos existentes, criação de
# novos arquivos e remoção de arquivos antigos) na estrutura corporativa
# criada pelo script: 01-criar-estrutura-empresa.sh, para gerar cenários
# reais de teste de BACKUP INCREMENTAL e BACKUP DIFERENCIAL com o Borg.
#
# Diretório de destino: /dados
# Data de criação: 12/09/2026
# Versão: 0.01
# Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS
#
# Documentação Oficial do BorgBackup: https://borgbackup.readthedocs.io/
#
# CONCEITOS IMPORTANTES:
# - Backup INCREMENTAL: captura apenas o que mudou desde o ÚLTIMO backup
#   (seja ele Full ou o Incremental anterior). Por isso, você deve rodar
#   este script e o backup do Borg TODA VEZ que quiser gerar um novo ponto.
# - Backup DIFERENCIAL: captura tudo o que mudou desde o ÚLTIMO Backup
#   COMPLETO (Full), acumulando as alterações. Por isso, para testar o
#   Diferencial corretamente, NÃO faça um novo Backup Completo entre as
#   execuções deste script - apenas continue rodando o modo "diferencial"
#   e criando novos arquivos de backup do tipo diferencial no Borg.
#
# USO:
#   sudo ./02-simular-alteracoes.sh incremental   -> gera uma mudança pequena
#   sudo ./02-simular-alteracoes.sh diferencial   -> gera uma mudança maior/acumulada
#   sudo ./02-simular-alteracoes.sh completo      -> gera uma mudança ampla (opcional)
#
set -euo pipefail

BASE_DIR="/dados"
DATA_ATUAL=$(date '+%d/%m/%Y %H:%M:%S')
TIMESTAMP=$(date '+%Y%m%d-%H%M%S')
MODO="${1:-incremental}"

# ==============================================================================
# Função: verificar_permissao
# ==============================================================================
verificar_permissao() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "⚠️  Este script precisa ser executado com privilégios de root (sudo)."
    echo "    Exemplo: sudo ./02-simular-alteracoes.sh incremental"
    exit 1
  fi
}

# ==============================================================================
# Função: verificar_estrutura
# Confirma que a estrutura base já existe antes de tentar alterá-la
# ==============================================================================
verificar_estrutura() {
  if [ ! -d "${BASE_DIR}" ]; then
    echo "❌ O diretório ${BASE_DIR} não existe."
    echo "   Execute primeiro: sudo ./01-criar-estrutura-empresa.sh"
    exit 1
  fi
}

# ==============================================================================
# Função: listar_departamentos
# Retorna a lista de departamentos já existentes dentro de /dados
# ==============================================================================
listar_departamentos() {
  find "${BASE_DIR}" -maxdepth 1 -mindepth 1 -type d ! -name "logs" ! -name "scripts_controle"
}

# ==============================================================================
# Função: editar_arquivo_existente
# Faz um "append" de uma nova linha em um arquivo já existente, simulando
# uma atualização real de conteúdo (o Borg detecta a mudança pelo hash/mtime)
# ==============================================================================
editar_arquivo_existente() {
  local arquivo="$1"
  if [ -f "${arquivo}" ]; then
    {
      echo ""
      echo "--------------------------------------------------------------"
      echo "[ATUALIZAÇÃO - ${DATA_ATUAL}] (modo: ${MODO})"
      echo "Registro incluído para simular alteração de conteúdo real."
      echo "ID da alteração: ${TIMESTAMP}"
      echo "--------------------------------------------------------------"
    } >> "${arquivo}"
    echo "  ✏️  Editado: ${arquivo}"
  fi
}

# ==============================================================================
# Função: criar_arquivo_novo
# Cria um novo arquivo dentro do departamento informado (documento novo)
# ==============================================================================
criar_arquivo_novo() {
  local dept_path="$1"
  local nome_arquivo="novo_documento_${TIMESTAMP}.txt"
  cat > "${dept_path}/documentos/${nome_arquivo}" <<EOF
NOVO DOCUMENTO GERADO AUTOMATICAMENTE
Modo de Simulação: ${MODO}
Departamento: $(basename "${dept_path}")
Criado em: ${DATA_ATUAL}
--------------------------------------------------------------
Este arquivo representa um documento novo criado após o último
Backup, utilizado para validar a captura de ARQUIVOS NOVOS nos
testes de Backup Incremental e Diferencial.
--------------------------------------------------------------
EOF
  echo "  ➕ Criado: ${dept_path}/documentos/${nome_arquivo}"
}

# ==============================================================================
# Função: remover_arquivo_temporario
# Remove um arquivo de rascunho antigo (simula exclusão de dados obsoletos)
# ==============================================================================
remover_arquivo_temporario() {
  local dept_path="$1"
  local arquivo_temp="${dept_path}/documentos/rascunho_temporario.txt"

  # Cria o arquivo temporário na primeira execução, para poder removê-lo depois
  if [ ! -f "${arquivo_temp}" ]; then
    echo "Rascunho temporário - pode ser excluído. Gerado em ${DATA_ATUAL}" > "${arquivo_temp}"
    echo "  ➕ Criado arquivo temporário (será removido em execução futura): ${arquivo_temp}"
  else
    rm -fv "${arquivo_temp}"
    echo "  ➖ Removido: ${arquivo_temp}"
  fi
}

# ==============================================================================
# Função: simular_mudancas
# Aplica as alterações em uma quantidade de departamentos proporcional ao
# modo escolhido (incremental = poucas mudanças / diferencial = mais mudanças)
# ==============================================================================
simular_mudancas() {
  local departamentos=()
  mapfile -t departamentos < <(listar_departamentos)

  local qtd_afetados
  case "${MODO}" in
    incremental)
      qtd_afetados=2
      ;;
    diferencial)
      qtd_afetados=5
      ;;
    completo)
      qtd_afetados=${#departamentos[@]}
      ;;
    *)
      echo "❌ Modo inválido: ${MODO}"
      echo "   Utilize: incremental | diferencial | completo"
      exit 1
      ;;
  esac

  echo "🔄 Simulando alterações no modo: ${MODO} (departamentos afetados: ${qtd_afetados})"
  echo ""

  local contador=0
  for dept_path in "${departamentos[@]}"; do
    if [ "${contador}" -ge "${qtd_afetados}" ]; then
      break
    fi

    echo "📂 Departamento: $(basename "${dept_path}")"
    editar_arquivo_existente "${dept_path}/relatorios/relatorio_mensal.txt"
    editar_arquivo_existente "${dept_path}/planilhas/controle_orcamento.csv"
    criar_arquivo_novo "${dept_path}"
    remover_arquivo_temporario "${dept_path}"
    echo ""

    contador=$((contador + 1))
  done

  echo "[${DATA_ATUAL}] Simulação de alteração executada - modo: ${MODO} (departamentos afetados: ${qtd_afetados})" >> "${BASE_DIR}/logs/auditoria.log"
}

# ==============================================================================
# Função: exibir_orientacao_backup
# Orienta qual comando do Borg deve ser utilizado após a simulação
# ==============================================================================
exibir_orientacao_backup() {
  echo "--------------------------------------------------------------"
  echo "✅ Alterações simuladas com sucesso (modo: ${MODO})."
  echo "--------------------------------------------------------------"
  case "${MODO}" in
    incremental)
      echo "➡️  Agora rode o Backup INCREMENTAL no Borg (referência: último backup):"
      echo "    borg create --stats --progress /caminho/repo::incr-${TIMESTAMP} ${BASE_DIR}"
      ;;
    diferencial)
      echo "➡️  Agora rode o Backup DIFERENCIAL no Borg (referência: último Full):"
      echo "    borg create --stats --progress /caminho/repo::diff-${TIMESTAMP} ${BASE_DIR}"
      echo "    OBSERVAÇÃO: não crie um novo Backup Completo entre as execuções"
      echo "    deste modo, pois o Diferencial acumula as mudanças desde o Full."
      ;;
    completo)
      echo "➡️  Alteração ampla simulada. Você pode gerar um NOVO Backup Completo:"
      echo "    borg create --stats --progress /caminho/repo::full-${TIMESTAMP} ${BASE_DIR}"
      ;;
  esac
  echo "--------------------------------------------------------------"
  echo "🧪 Para testar a RESTAURAÇÃO de um ponto específico:"
  echo "    borg list /caminho/repo"
  echo "    borg extract /caminho/repo::NOME_DO_ARQUIVO --dry-run --list"
  echo "    borg extract /caminho/repo::NOME_DO_ARQUIVO"
  echo "--------------------------------------------------------------"
}

# ==============================================================================
# Execução Principal do Script
# ==============================================================================
verificar_permissao
verificar_estrutura
simular_mudancas
exibir_orientacao_backup
