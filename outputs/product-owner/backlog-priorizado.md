# Backlog Priorizado - CRM para Desenvolvedor Autônomo

## Metodologia de Priorização

A priorização foi feita considerando:
- **Valor de Negócio**: Impacto direto na operação do desenvolvedor autônomo
- **Esforço de Desenvolvimento**: Complexidade técnica estimada em Story Points
- **Dependências**: Features que precisam estar prontas antes de outras
- **Riscos**: Funcionalidades críticas para MVP

---

## Sprint 1 - Fundação (MVP Mínimo Viável)

### Objetivo do Sprint
Estabelecer a base do sistema com autenticação e gestão básica de clientes.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-001 | Login no Sistema | Muito Alta | 3 | Base de segurança - bloqueia tudo |
| US-002 | Cadastrar Novo Cliente | Muito Alta | 5 | Funcionalidade core do CRM |
| US-003 | Visualizar Lista de Clientes | Muito Alta | 3 | Necessário para acessar dados cadastrados |
| **Subtotal Sprint 1** | | | **11** | |

---

## Sprint 2 - Pipeline Visual

### Objetivo do Sprint
Implementar visualização e gestão do pipeline de vendas com Kanban.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-006 | Visualizar Pipeline em Kanban | Muito Alta | 8 | Diferencial competitivo - visão visual do pipeline |
| US-007 | Atualizar Status do Cliente no Pipeline | Muito Alta | 5 | Interatividade essencial do Kanban |
| **Subtotal Sprint 2** | | | **13** | |

---

## Sprint 3 - Gestão de Propostas

### Objetivo do Sprint
Permitir criação e gestão de propostas comerciais.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-009 | Criar Nova Proposta | Muito Alta | 5 | Essencial para formalizar vendas |
| US-010 | Visualizar Propostas | Alta | 3 | Necessário para acompanhamento |
| US-011 | Atualizar Status da Proposta | Alta | 2 | Tracking de aceitação/rejeição |
| **Subtotal Sprint 3** | | | **10** | |

---

## Sprint 4 - Controle Financeiro Básico

### Objetivo do Sprint
Implementar controle financeiro essencial com registro de pagamentos.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-013 | Registrar Pagamento Combinado | Alta | 3 | Base do controle financeiro |
| US-014 | Configurar Parcelas de Pagamento | Alta | 5 | Necessário para projetos parcelados |
| US-015 | Registrar Status de Pagamento | Muito Alta | 5 | Controle crítico de recebimentos |
| **Subtotal Sprint 4** | | | **13** | |

---

## Sprint 5 - Melhorias e Refinamentos

### Objetivo do Sprint
Adicionar funcionalidades de edição, filtros e melhorias na experiência.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-004 | Editar Informações do Cliente | Alta | 3 | Necessário para manutenção de dados |
| US-008 | Filtrar Clientes por Status | Média | 3 | Melhoria na usabilidade |
| US-012 | Editar Proposta | Média | 3 | Correção de propostas antes de enviar |
| **Subtotal Sprint 5** | | | **9** | |

---

## Sprint 6 - Sistema de Alertas

### Objetivo do Sprint
Implementar sistema proativo de alertas e cobranças.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-017 | Configurar Lembrete Automático de Cobrança | Alta | 5 | Automatização importante |
| US-018 | Visualizar Status Visual de Inadimplência | Alta | 3 | Identificação rápida de problemas |
| **Subtotal Sprint 6** | | | **8** | |

---

## Sprint 7 - Dashboard e Histórico

### Objetivo do Sprint
Adicionar visão consolidada e histórico completo.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-016 | Visualizar Dashboard Financeiro | Alta | 8 | Visão executiva consolidada |
| US-019 | Visualizar Histórico de Cobranças | Média | 5 | Contexto histórico importante |
| US-020 | Registrar Nova Tentativa de Cobrança | Média | 3 | Rastreabilidade de comunicação |
| **Subtotal Sprint 7** | | | **16** | |

---

## Sprint 8 - Finalização e Limpeza

### Objetivo do Sprint
Features auxiliares e finalização.

| ID | User Story | Prioridade | Story Points | Justificativa |
|----|------------|------------|--------------|---------------|
| US-005 | Excluir Cliente | Média | 2 | Funcionalidade auxiliar de manutenção |
| **Subtotal Sprint 8** | | | **2** | |

---

## Resumo do Roadmap

| Sprint | Foco | Story Points | Acumulado |
|--------|------|--------------|-----------|
| Sprint 1 | Fundação | 11 | 11 |
| Sprint 2 | Pipeline Visual | 13 | 24 |
| Sprint 3 | Gestão de Propostas | 10 | 34 |
| Sprint 4 | Controle Financeiro | 13 | 47 |
| Sprint 5 | Melhorias | 9 | 56 |
| Sprint 6 | Alertas | 8 | 64 |
| Sprint 7 | Dashboard | 16 | 80 |
| Sprint 8 | Finalização | 2 | 82 |
| **TOTAL** | | **82** | |

---

## MVP (Minimum Viable Product)

### Definição
O MVP inclui as funcionalidades mínimas para o sistema ser utilizável:

**Sprints MVP:** Sprint 1 + Sprint 2 + Sprint 3 + Sprint 4

**Funcionalidades MVP:**
- ✅ Autenticação
- ✅ CRUD de Clientes
- ✅ Pipeline Kanban
- ✅ Gestão de Propostas
- ✅ Controle Financeiro Básico

**Story Points MVP:** 47 pontos

**Justificativa:**
Com essas funcionalidades, o desenvolvedor autônomo já consegue:
- Gerenciar seus clientes
- Acompanhar o pipeline de vendas visualmente
- Criar e acompanhar propostas
- Controlar recebimentos básicos

---

## Riscos e Dependências

### Dependências Técnicas Críticas
1. **US-001 (Login)** → Bloqueia todas as outras features
2. **US-002 (Cadastrar Cliente)** → Necessário para US-006, US-009, US-013
3. **US-006 (Kanban)** → Pode ser desenvolvido em paralelo após US-003
4. **US-009 (Proposta)** → Depende de US-002 (Cliente)
5. **US-013 (Pagamento)** → Depende de US-009 (Proposta)

### Riscos Identificados
1. **Complexidade do Kanban (US-006)**: Maior risco técnico - requer drag & drop
2. **Sistema de Alertas Automáticos (US-017)**: Pode requerer background jobs
3. **Dashboard Financeiro (US-016)**: Agregação de dados pode ser complexa

### Mitigações
- Priorizar Kanban no Sprint 2 para validar viabilidade técnica
- Sistema de alertas pode começar manual e evoluir para automático
- Dashboard pode ser simplificado inicialmente com queries básicas

---

## Métricas de Sucesso

### Por Sprint
- **Velocity**: Acompanhar story points completados
- **Defeitos**: Taxa de bugs por sprint
- **Satisfação**: Feedback do usuário (desenvolvedor autônomo)

### MVP
- **Adoção**: Uso contínuo após lançamento
- **Funcionalidades Utilizadas**: Quais features são mais usadas
- **Melhorias Solicitadas**: Priorizar baseado no feedback real

