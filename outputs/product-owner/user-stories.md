# User Stories - CRM para Desenvolvedor Autônomo

## Personas Identificadas

### Persona Principal
**Desenvolvedor Autônomo/Freelancer**
- Profissional que trabalha de forma independente
- Gerencia múltiplos clientes simultaneamente
- Precisa de controle financeiro e de pipeline de vendas
- Necessita acompanhar o status de cada projeto/cliente

---

## User Stories

### EPIC 1: Autenticação e Segurança

#### US-001: Login no Sistema
**Como** desenvolvedor autônomo  
**Eu quero** fazer login no sistema  
**Para que** eu possa acessar meus dados de forma segura e privada

**Prioridade:** Muito Alta  
**Story Points:** 3

---

### EPIC 2: Gestão de Clientes

#### US-002: Cadastrar Novo Cliente
**Como** desenvolvedor autônomo  
**Eu quero** cadastrar um novo cliente com suas informações completas  
**Para que** eu possa ter um registro organizado de todos os meus contatos comerciais

**Informações necessárias:**
- Nome / Empresa
- Tipo (Pessoa Física / Pessoa Jurídica)
- Contatos (email, WhatsApp)
- Segmento do cliente
- Observações técnicas (stack tecnológica, nível técnico)

**Prioridade:** Muito Alta  
**Story Points:** 5

#### US-003: Visualizar Lista de Clientes
**Como** desenvolvedor autônomo  
**Eu quero** visualizar todos os meus clientes em uma tabela  
**Para que** eu possa acessar rapidamente as informações de qualquer cliente

**Prioridade:** Muito Alta  
**Story Points:** 3

#### US-004: Editar Informações do Cliente
**Como** desenvolvedor autônomo  
**Eu quero** editar as informações de um cliente existente  
**Para que** eu possa manter os dados atualizados conforme o relacionamento evolui

**Prioridade:** Alta  
**Story Points:** 3

#### US-005: Excluir Cliente
**Como** desenvolvedor autônomo  
**Eu quero** excluir um cliente do sistema  
**Para que** eu possa remover registros que não são mais relevantes

**Prioridade:** Média  
**Story Points:** 2

---

### EPIC 3: Gestão de Pipeline (Status do Cliente)

#### US-006: Visualizar Pipeline em Kanban
**Como** desenvolvedor autônomo  
**Eu quero** visualizar meus clientes em um board Kanban com diferentes estágios  
**Para que** eu possa ter uma visão clara do status de cada oportunidade/projeto

**Colunas do Kanban:**
- Lead
- Primeiro Contato
- Reunião
- Proposta Enviada
- Negociação
- Fechado

**Prioridade:** Muito Alta  
**Story Points:** 8

#### US-007: Atualizar Status do Cliente no Pipeline
**Como** desenvolvedor autônomo  
**Eu quero** arrastar um cliente entre diferentes colunas do Kanban  
**Para que** eu possa acompanhar a evolução do relacionamento de forma visual e intuitiva

**Prioridade:** Muito Alta  
**Story Points:** 5

#### US-008: Filtrar Clientes por Status
**Como** desenvolvedor autônomo  
**Eu quero** filtrar os clientes por status no pipeline  
**Para que** eu possa focar em clientes em estágios específicos (ex: todos em negociação)

**Prioridade:** Média  
**Story Points:** 3

---

### EPIC 4: Gestão de Propostas

#### US-009: Criar Nova Proposta
**Como** desenvolvedor autônomo  
**Eu quero** criar uma proposta para um cliente  
**Para que** eu possa formalizar uma oferta de serviço de forma estruturada

**Informações da Proposta:**
- Cliente vinculado
- Descrição do serviço
- Valor
- Prazo de entrega
- Forma de pagamento
- Status (enviada / aceita)

**Prioridade:** Muito Alta  
**Story Points:** 5

#### US-010: Visualizar Propostas
**Como** desenvolvedor autônomo  
**Eu quero** visualizar todas as minhas propostas em uma lista  
**Para que** eu possa acompanhar o status de cada proposta enviada

**Prioridade:** Alta  
**Story Points:** 3

#### US-011: Atualizar Status da Proposta
**Como** desenvolvedor autônomo  
**Eu quero** atualizar o status de uma proposta  
**Para que** eu possa registrar quando uma proposta foi aceita ou rejeitada

**Prioridade:** Alta  
**Story Points:** 2

#### US-012: Editar Proposta
**Como** desenvolvedor autônomo  
**Eu quero** editar uma proposta antes de enviá-la  
**Para que** eu possa fazer ajustes nos valores e condições

**Prioridade:** Média  
**Story Points:** 3

---

### EPIC 5: Controle Financeiro

#### US-013: Registrar Pagamento Combinado
**Como** desenvolvedor autônomo  
**Eu quero** registrar o valor total combinado para um projeto  
**Para que** eu tenha controle do valor esperado de recebimento

**Prioridade:** Alta  
**Story Points:** 3

#### US-014: Configurar Parcelas de Pagamento
**Como** desenvolvedor autônomo  
**Eu quero** configurar como o pagamento será parcelado  
**Para que** eu possa acompanhar cada parcela individualmente

**Prioridade:** Alta  
**Story Points:** 5

#### US-015: Registrar Status de Pagamento
**Como** desenvolvedor autônomo  
**Eu quero** marcar cada parcela como paga, pendente ou atrasada  
**Para que** eu tenha controle financeiro preciso

**Status possíveis:**
- Pago
- Pendente
- Atrasado

**Prioridade:** Muito Alta  
**Story Points:** 5

#### US-016: Visualizar Dashboard Financeiro
**Como** desenvolvedor autônomo  
**Eu quero** visualizar um resumo financeiro no dashboard  
**Para que** eu possa ter uma visão geral rápida da minha situação financeira

**Informações:**
- Total recebido
- Total pendente
- Total atrasado
- Próximas cobranças

**Prioridade:** Alta  
**Story Points:** 8

---

### EPIC 6: Sistema de Alertas e Cobranças

#### US-017: Configurar Lembrete Automático de Cobrança
**Como** desenvolvedor autônomo  
**Eu quero** configurar alertas automáticos antes do vencimento de parcelas  
**Para que** eu possa cobrar os clientes de forma proativa

**Prioridade:** Alta  
**Story Points:** 5

#### US-018: Visualizar Status Visual de Inadimplência
**Como** desenvolvedor autônomo  
**Eu quero** ver visualmente quais clientes estão inadimplentes  
**Para que** eu possa identificar rapidamente problemas de pagamento

**Prioridade:** Alta  
**Story Points:** 3

#### US-019: Visualizar Histórico de Cobranças
**Como** desenvolvedor autônomo  
**Eu quero** visualizar o histórico completo de cobranças de um cliente  
**Para que** eu possa ter contexto sobre o relacionamento financeiro

**Prioridade:** Média  
**Story Points:** 5

#### US-020: Registrar Nova Tentativa de Cobrança
**Como** desenvolvedor autônomo  
**Eu quero** registrar quando envio um lembrete de cobrança  
**Para que** eu tenha histórico de comunicação com o cliente

**Prioridade:** Média  
**Story Points:** 3

---

## Resumo por Épico

| Épico | User Stories | Total Story Points |
|-------|--------------|-------------------|
| Autenticação e Segurança | 1 | 3 |
| Gestão de Clientes | 4 | 13 |
| Gestão de Pipeline | 3 | 16 |
| Gestão de Propostas | 4 | 13 |
| Controle Financeiro | 4 | 21 |
| Sistema de Alertas | 4 | 16 |
| **TOTAL** | **20** | **82** |

