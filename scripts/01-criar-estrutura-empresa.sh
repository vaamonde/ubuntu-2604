#!/bin/bash
#
# Script: 01-criar-estrutura-empresa.sh
# Autor: Robson Vaamonde
# Projeto: Curso GRÁTIS de GNU/Linux Ubuntu Server 26.04.x LTS - Segurança e Hardening
# Procedimentos em TI: http://procedimentosemti.com.br
# Bora para Prática: http://boraparapratica.com.br
#
# Objetivo: Criar uma estrutura de diretórios e arquivos simulando o ambiente
# real de uma empresa fictícia (departamentos, documentos, planilhas, relatórios
# e políticas), servindo de CENÁRIO BASE (Backup Completo/Full) para os testes
# de Backup Completo, Incremental e Diferencial utilizando o BorgBackupServer.
#
# Diretório de destino: /dados
# Data de criação: 12/09/2026
# Versão: 0.01
# Testado e homologado no GNU/Linux Ubuntu Server 26.04.x LTS
#
# Documentação Oficial do BorgBackup: https://borgbackup.readthedocs.io/
# Projeto BorgBackupServer: https://github.com/marcpope/borgbackupserver
#
# OBSERVAÇÃO IMPORTANTE: execute este script SEMPRE PRIMEIRO. Depois de criado
# o cenário base, faça o PRIMEIRO Backup Completo (Full) com o Borg, e só então
# utilize o script: 02-simular-alteracoes.sh para gerar mudanças e testar os
# Backups Incremental e Diferencial.
#
set -euo pipefail

# ==============================================================================
# Bloco de Variáveis Globais
# ==============================================================================
BASE_DIR="/dados"
EMPRESA="TechCorp Solutions Ltda"
CNPJ="12.345.678/0001-90"
DATA_ATUAL=$(date '+%d/%m/%Y %H:%M:%S')

# Lista dos Departamentos da Empresa fictícia (simulação)
DEPARTAMENTOS=(
  "00-diretoria"
  "01-financeiro"
  "02-recursos_humanos"
  "03-tecnologia_informacao"
  "04-comercial_vendas"
  "05-juridico"
  "06-marketing"
  "07-producao_operacoes"
  "08-compras_suprimentos"
  "09-qualidade"
)

# Subdiretórios padrão presentes em cada Departamento
SUBDIRETORIOS=("documentos" "contratos" "relatorios" "planilhas" "politicas")

# ==============================================================================
# Função: verificar_permissao
# Verifica se o script está sendo executado com privilégios de root (sudo),
# necessário para criar a estrutura diretamente em /dados
# ==============================================================================
verificar_permissao() {
  if [ "$(id -u)" -ne 0 ]; then
    echo "⚠️  Este script precisa ser executado com privilégios de root (sudo)."
    echo "    Exemplo: sudo ./01-criar-estrutura-empresa.sh"
    exit 1
  fi
}

# ==============================================================================
# Função: criar_diretorio_base
# Cria o diretório raiz /dados e os diretórios de apoio (logs e scripts)
# ==============================================================================
criar_diretorio_base() {
  echo "📁 Criando diretório base: ${BASE_DIR}"
  mkdir -pv "${BASE_DIR}"/logs
  mkdir -pv "${BASE_DIR}"/scripts_controle

  cat > "${BASE_DIR}/README.txt" <<EOF
==============================================================
Estrutura de Dados Corporativos - ${EMPRESA}
CNPJ: ${CNPJ}
==============================================================
Este diretório (${BASE_DIR}) simula o ambiente real de
armazenamento de arquivos de uma empresa, distribuído por
departamentos, para fins didáticos de testes de Backup
(Completo, Incremental e Diferencial) com o BorgBackupServer.

Estrutura de Departamentos:
$(for d in "${DEPARTAMENTOS[@]}"; do echo "  - ${d}"; done)

Gerado automaticamente em: ${DATA_ATUAL}
==============================================================
EOF

  cat > "${BASE_DIR}/politica_seguranca_empresa.txt" <<EOF
POLÍTICA DE SEGURANÇA DA INFORMAÇÃO
${EMPRESA} - CNPJ: ${CNPJ}
Versão: 1.0 - Data: ${DATA_ATUAL}

1. Todos os dados corporativos devem ser armazenados em /dados.
2. Backups Completos (Full) devem ser executados semanalmente.
3. Backups Incrementais devem ser executados diariamente.
4. Backups Diferenciais podem ser executados a cada 3 dias.
5. Todo colaborador deve seguir a Política de Senhas Fortes.
6. Acesso remoto somente via VPN ou SSH com autenticação 2FA.
7. Auditorias trimestrais de conformidade e hardening (CIS Benchmark).
EOF

  echo "[${DATA_ATUAL}] Estrutura base criada em ${BASE_DIR}" >> "${BASE_DIR}/logs/auditoria.log"
}

# ==============================================================================
# Função: gerar_lista_funcionarios
# Gera um arquivo de controle de funcionários do departamento (simulação)
# ==============================================================================
gerar_lista_funcionarios() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/documentos/lista_funcionarios.txt" <<EOF
CONTROLE DE FUNCIONÁRIOS - Departamento: ${dept_nome}
${EMPRESA}
Atualizado em: ${DATA_ATUAL}
--------------------------------------------------------------
Matrícula | Nome                   | Cargo            | Status
--------------------------------------------------------------
0001      | Ana Souza              | Analista Pleno   | Ativo
0002      | Bruno Lima             | Coordenador      | Ativo
0003      | Carla Mendes           | Assistente       | Ativo
0004      | Diego Ferreira         | Estagiário       | Ativo
--------------------------------------------------------------
Total de Colaboradores: 4
EOF
}

# ==============================================================================
# Função: gerar_relatorio_mensal
# Gera um relatório mensal fictício para o departamento
# ==============================================================================
gerar_relatorio_mensal() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/relatorios/relatorio_mensal.txt" <<EOF
RELATÓRIO MENSAL DE ATIVIDADES
Departamento: ${dept_nome}
${EMPRESA}
Período de Referência: $(date '+%m/%Y')
Gerado em: ${DATA_ATUAL}
--------------------------------------------------------------
Resumo das atividades executadas no período:
  - Reunião de alinhamento realizada nas segundas-feiras.
  - Indicadores de desempenho (KPIs) dentro da meta estabelecida.
  - Nenhuma pendência crítica registrada até o momento.
--------------------------------------------------------------
Status Geral: CONCLUÍDO
EOF
}

# ==============================================================================
# Função: gerar_planilha_orcamento
# Gera um arquivo de controle orçamentário simplificado (texto simulando CSV)
# ==============================================================================
gerar_planilha_orcamento() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/planilhas/controle_orcamento.csv" <<EOF
item;descricao;valor_previsto;valor_realizado;departamento
1;Material de Escritorio;1500.00;1320.50;${dept_nome}
2;Licencas de Software;3200.00;3200.00;${dept_nome}
3;Treinamentos;2000.00;1750.00;${dept_nome}
4;Manutencao de Equipamentos;900.00;860.00;${dept_nome}
EOF
}

# ==============================================================================
# Função: gerar_ata_reuniao
# Gera uma ata de reunião fictícia do departamento
# ==============================================================================
gerar_ata_reuniao() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/documentos/ata_reuniao.txt" <<EOF
ATA DE REUNIÃO - Departamento: ${dept_nome}
${EMPRESA}
Data: ${DATA_ATUAL}
--------------------------------------------------------------
Participantes: Líder do Departamento e Equipe.
Pauta:
  1. Revisão das metas do trimestre.
  2. Alinhamento de prioridades da semana.
  3. Pontos de melhoria de processo.

Deliberações:
  - Aprovado o plano de ação apresentado pela equipe.
  - Próxima reunião agendada para a semana seguinte.
--------------------------------------------------------------
EOF
}

# ==============================================================================
# Função: gerar_contrato
# Gera um contrato fictício (apenas para departamentos que fazem sentido)
# ==============================================================================
gerar_contrato() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/contratos/contrato_fornecedor_001.txt" <<EOF
CONTRATO DE PRESTAÇÃO DE SERVIÇOS Nº 001/2026
CONTRATANTE: ${EMPRESA} (CNPJ ${CNPJ})
Departamento Responsável: ${dept_nome}
Data de Assinatura: ${DATA_ATUAL}
--------------------------------------------------------------
Objeto: Prestação de serviços especializados conforme escopo
técnico anexo, com vigência de 12 (doze) meses, podendo ser
renovado mediante acordo entre as partes.
--------------------------------------------------------------
Status: EM VIGOR
EOF
}

# ==============================================================================
# Função: gerar_politica_departamento
# Gera um arquivo de política interna simples do departamento
# ==============================================================================
gerar_politica_departamento() {
  local dept_path="$1"
  local dept_nome="$2"
  cat > "${dept_path}/politicas/politica_interna.txt" <<EOF
POLÍTICA INTERNA - Departamento: ${dept_nome}
${EMPRESA}
Versão: 1.0 - Data: ${DATA_ATUAL}
--------------------------------------------------------------
1. Cumprir os prazos definidos no planejamento setorial.
2. Reportar incidentes de segurança imediatamente à TI.
3. Manter documentos sensíveis apenas nas pastas autorizadas.
EOF
}

# ==============================================================================
# Função: criar_departamentos
# Percorre a lista de Departamentos, cria os subdiretórios padrão e popula
# cada um com os arquivos de simulação (baseline para o Backup Completo)
# ==============================================================================
criar_departamentos() {
  local total_arquivos=0
  local total_diretorios=0

  for dept in "${DEPARTAMENTOS[@]}"; do
    local dept_path="${BASE_DIR}/${dept}"
    local dept_nome
    dept_nome=$(echo "${dept#*-}" | tr '_' ' ')

    echo "🏢 Criando departamento: ${dept}"
    for sub in "${SUBDIRETORIOS[@]}"; do
      mkdir -pv "${dept_path}/${sub}"
      total_diretorios=$((total_diretorios + 1))
    done

    gerar_lista_funcionarios "${dept_path}" "${dept_nome}"
    gerar_relatorio_mensal "${dept_path}" "${dept_nome}"
    gerar_planilha_orcamento "${dept_path}" "${dept_nome}"
    gerar_ata_reuniao "${dept_path}" "${dept_nome}"
    gerar_contrato "${dept_path}" "${dept_nome}"
    gerar_politica_departamento "${dept_path}" "${dept_nome}"

    total_arquivos=$((total_arquivos + 6))
    echo "[${DATA_ATUAL}] Departamento criado: ${dept}" >> "${BASE_DIR}/logs/auditoria.log"
  done

  echo ""
  echo "✅ Estrutura corporativa criada com sucesso em: ${BASE_DIR}"
  echo "   Departamentos criados : ${#DEPARTAMENTOS[@]}"
  echo "   Diretórios criados    : ${total_diretorios}"
  echo "   Arquivos gerados      : ${total_arquivos}"
}

# ==============================================================================
# Função: exibir_resumo_final
# Exibe a árvore de diretórios criada e orienta sobre o próximo passo
# ==============================================================================
exibir_resumo_final() {
  echo ""
  echo "--------------------------------------------------------------"
  echo "📦 Estrutura pronta para o PRIMEIRO Backup Completo (Full)."
  echo "--------------------------------------------------------------"
  if command -v tree >/dev/null 2>&1; then
    tree -L 3 "${BASE_DIR}"
  else
    find "${BASE_DIR}" -maxdepth 3 | sort
  fi
  echo "--------------------------------------------------------------"
  echo "➡️  PRÓXIMO PASSO: execute o Backup Completo (Full) com o Borg."
  echo "   Exemplo: borg create --stats --progress /caminho/repo::full-\$(date +%Y-%m-%d) ${BASE_DIR}"
  echo "   Depois execute: sudo ./02-simular-alteracoes.sh incremental"
  echo "   ou             : sudo ./02-simular-alteracoes.sh diferencial"
  echo "--------------------------------------------------------------"
}

# ==============================================================================
# Execução Principal do Script
# ==============================================================================
verificar_permissao
criar_diretorio_base
criar_departamentos
exibir_resumo_final
