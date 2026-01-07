# Documentação de Requisitos - CRM para Desenvolvedor Autônomo

## 1. Visão Geral do Projeto

### 1.1 Objetivo
Desenvolver um sistema CRM (Customer Relationship Management) customizado para auxiliar desenvolvedores autônomos/freelancers na gestão de clientes, pipeline de vendas, propostas comerciais e controle financeiro.

### 1.2 Contexto de Negócio
Desenvolvedores autônomos frequentemente enfrentam desafios na organização de:
- Múltiplos clientes e projetos simultâneos
- Pipeline de vendas e acompanhamento de oportunidades
- Propostas comerciais e negociações
- Controle de recebimentos e cobranças

Este sistema visa centralizar todas essas informações em uma plataforma única e intuitiva.

---

## 2. Objetivos de Negócio

### 2.1 Objetivos Principais
1. **Centralização de Informações**: Todas as informações de clientes, propostas e pagamentos em um único lugar
2. **Visibilidade do Pipeline**: Visualização clara do status de cada oportunidade/projeto
3. **Controle Financeiro**: Acompanhamento preciso de recebimentos e inadimplência
4. **Automação**: Reduzir trabalho manual através de alertas automáticos e lembretes

### 2.2 Métricas de Sucesso
- Redução do tempo gasto em gestão administrativa
- Aumento na taxa de conversão de propostas (através de melhor acompanhamento)
- Redução de inadimplência (através de alertas proativos)
- Melhoria na organização e produtividade do desenvolvedor

---

## 3. Usuários-Alvo (Personas)

### 3.1 Persona Principal
**Nome**: Desenvolvedor Autônomo/Freelancer

**Características**:
- Trabalha de forma independente (sem equipe)
- Gerencia múltiplos clientes simultaneamente (3-10 clientes ativos)
- Precisa de flexibilidade e mobilidade
- Conhecimento técnico médio a alto

**Necessidades**:
- Sistema simples e intuitivo (não precisa ser complexo como CRMs empresariais)
- Foco em funcionalidades essenciais
- Visualização rápida do status de projetos/clientes
- Controle financeiro básico mas eficiente

**Frustrações com Soluções Atuais**:
- CRMs empresariais são muito complexos e caros
- Planilhas Excel são desorganizadas e propensas a erros
- Falta de integração entre diferentes aspectos (clientes, propostas, pagamentos)

---

## 4. Funcionalidades Principais

### 4.1 Autenticação e Segurança
- Sistema de login seguro
- Proteção de dados do usuário
- Sessão persistente

### 4.2 Gestão de Clientes
- Cadastro completo de clientes (PF/PJ)
- Informações de contato (email, WhatsApp)
- Segmentação de clientes
- Observações técnicas (stack, nível técnico)
- CRUD completo (Create, Read, Update, Delete)

### 4.3 Pipeline de Vendas (Kanban)
- Visualização em board Kanban com 6 estágios:
  1. Lead
  2. Primeiro Contato
  3. Reunião
  4. Proposta Enviada
  5. Negociação
  6. Fechado
- Drag and drop para atualizar status
- Filtros e busca

### 4.4 Gestão de Propostas
- Criação de propostas comerciais
- Vinculação com clientes
- Campos: descrição, valor, prazo, forma de pagamento
- Status: enviada / aceita
- Histórico de propostas

### 4.5 Controle Financeiro
- Registro de valor combinado por projeto
- Configuração de parcelas de pagamento
- Status de pagamento (pago, pendente, atrasado)
- Dashboard financeiro consolidado
- Cálculo automático de inadimplência

### 4.6 Sistema de Alertas
- Lembretes automáticos de cobrança
- Status visual de inadimplência
- Histórico de tentativas de cobrança
- Notificações proativas

---

## 5. Restrições e Limitações

### 5.1 Restrições Técnicas

#### Stack Tecnológica Definida
- **Frontend**: 
  - React com Vite
  - TypeScript
  - Shadcn UI (design system)
  - Lucide Icons
  - Componentes específicos: sidebar-07, Data Table

- **Backend**:
  - Fastify (framework web)
  - Knex.js (query builder)
  - TypeScript
  - Arquitetura: Clean Architecture, DDD, Repository Pattern

- **Banco de Dados**:
  - PostgreSQL (Neon - serverless Postgres)

#### Restrições de Design
- Deve seguir design system do shadcn/ui
- Usar componente sidebar-07 para navegação lateral
- Usar Data Table do shadcn/ui para listas
- Ícones do Lucide Icons

### 5.2 Restrições de Negócio
- Sistema voltado para uso individual (não multi-tenant inicialmente)
- Foco em funcionalidades essenciais (MVP first)
- Sem integrações externas na versão inicial (ex: pagamentos, emails)

### 5.3 Limitações Funcionais (MVP)
- Não há gestão de múltiplos usuários/equipes
- Sem integração com sistemas de pagamento
- Sem envio automático de emails (apenas notificações internas)
- Sem relatórios avançados/exportação

---

## 6. Arquitetura e Padrões

### 6.1 Arquitetura do Backend
- **Clean Architecture**: Separação em camadas (domain, use cases, infrastructure)
- **DDD (Domain-Driven Design)**: Modelagem baseada no domínio de negócio
- **Repository Pattern**: Abstração de acesso a dados

### 6.2 Estrutura Esperada do Backend
```
backend/
├── src/
│   ├── domain/          # Entidades e regras de negócio
│   ├── application/     # Casos de uso (use cases)
│   ├── infrastructure/  # Implementações (DB, APIs)
│   └── presentation/    # Controllers/rotas Fastify
```

### 6.3 Estrutura Esperada do Frontend
```
frontend/
├── src/
│   ├── components/      # Componentes React
│   ├── pages/          # Páginas/rotas
│   ├── hooks/          # Custom hooks
│   ├── services/       # Chamadas API
│   └── utils/          # Utilitários
```

---

## 7. Modelo de Dados Conceitual

### 7.1 Entidades Principais

#### Cliente (Client)
- id: UUID
- nome: string
- empresa: string (opcional)
- tipo: enum (PF, PJ)
- email: string
- whatsapp: string (opcional)
- segmento: string (opcional)
- observacoes_tecnicas: text (opcional)
- status: enum (Lead, PrimeiroContato, Reuniao, PropostaEnviada, Negociacao, Fechado)
- created_at: timestamp
- updated_at: timestamp

#### Proposta (Proposal)
- id: UUID
- cliente_id: UUID (FK)
- descricao: text
- valor: decimal
- prazo: date
- forma_pagamento: string
- status: enum (Enviada, Aceita)
- created_at: timestamp
- updated_at: timestamp

#### Pagamento (Payment)
- id: UUID
- cliente_id: UUID (FK)
- proposta_id: UUID (FK, opcional)
- valor_combinado: decimal
- created_at: timestamp

#### Parcela (Installment)
- id: UUID
- pagamento_id: UUID (FK)
- numero_parcela: integer
- valor: decimal
- data_vencimento: date
- status: enum (Pago, Pendente, Atrasado)
- data_pagamento: date (opcional)
- created_at: timestamp
- updated_at: timestamp

#### Cobranca (Billing)
- id: UUID
- parcela_id: UUID (FK)
- data_tentativa: timestamp
- metodo: enum (Email, WhatsApp, Telefone)
- observacoes: text (opcional)

#### Usuario (User)
- id: UUID
- email: string (unique)
- senha_hash: string
- created_at: timestamp

---

## 8. Regras de Negócio

### 8.1 Regras de Cliente
1. Cliente deve ter nome/empresa obrigatório
2. Cliente deve ter tipo (PF ou PJ) obrigatório
3. Cliente deve ter pelo menos um contato (email ou WhatsApp)
4. Status inicial do cliente é "Lead"
5. Status só pode ser alterado para valores válidos do enum

### 8.2 Regras de Proposta
1. Proposta deve estar vinculada a um cliente existente
2. Valor da proposta deve ser maior que zero
3. Prazo deve ser uma data futura
4. Status inicial é "Enviada"
5. Ao aceitar proposta, cliente pode ser atualizado para "Fechado"

### 8.3 Regras de Pagamento
1. Valor combinado deve ser maior que zero
2. Soma de parcelas deve igualar valor combinado (tolerância de centavos)
3. Parcela é considerada "Atrasada" automaticamente se data de vencimento passou e status é "Pendente"
4. Parcela "Paga" não pode voltar para "Pendente" (ou pode com justificativa)

### 8.4 Regras de Alertas
1. Alerta só é enviado se parcela está "Pendente"
2. Alerta não é enviado para parcelas já "Pagas"
3. Múltiplos alertas não são enviados no mesmo dia
4. Status visual de inadimplência aparece se cliente tem pelo menos 1 parcela "Atrasada"

---

## 9. Requisitos Não-Funcionais

### 9.1 Performance
- Página deve carregar em menos de 2 segundos
- Operações de CRUD devem responder em menos de 500ms
- Dashboard deve carregar em menos de 3 segundos mesmo com muitos registros

### 9.2 Segurança
- Senhas devem ser hasheadas (bcrypt ou similar)
- Tokens JWT para autenticação
- Validação de dados no backend (não confiar apenas no frontend)
- Proteção contra SQL injection (usar Knex com parameterized queries)

### 9.3 Usabilidade
- Interface intuitiva e auto-explicativa
- Mensagens de erro claras
- Feedback visual em todas as ações (loading, sucesso, erro)
- Layout responsivo (mobile-first)

### 9.4 Compatibilidade
- Navegadores: Chrome, Firefox, Safari, Edge (últimas 2 versões)
- Dispositivos: Desktop, Tablet, Mobile

### 9.5 Manutenibilidade
- Código limpo e bem documentado
- Testes unitários para regras de negócio críticas
- Separação clara de responsabilidades

---

## 10. Dependências e Integrações

### 10.1 Dependências do Projeto
- Neon (banco de dados PostgreSQL serverless)
- Shadcn UI (biblioteca de componentes via MCP no Cursor)
- Lucide Icons (ícones)

### 10.2 Integrações Futuras (Fora do Escopo MVP)
- Envio de emails (ex: SendGrid, Resend)
- Integração com WhatsApp Business API
- Exportação de relatórios (PDF, Excel)
- Integração com sistemas de pagamento

---

## 11. Considerações de Implementação

### 11.1 Ordem de Desenvolvimento Sugerida
1. Setup inicial (projeto, banco, autenticação)
2. CRUD de Clientes
3. Pipeline Kanban
4. Gestão de Propostas
5. Controle Financeiro
6. Sistema de Alertas

### 11.2 Decisões Técnicas Pendentes
- Estratégia de deploy (Render, Vercel, etc.)
- Estratégia de backup do banco de dados
- Política de retenção de dados
- Estratégia de soft delete vs hard delete

### 11.3 Riscos Técnicos
1. **Complexidade do Kanban**: Drag & drop pode ser complexo - considerar biblioteca como dnd-kit
2. **Sistema de Alertas**: Requer background jobs - considerar node-cron ou serviço externo
3. **Performance do Dashboard**: Agregações podem ser lentas - considerar cache ou materialized views

---

## 12. Glossário

- **CRM**: Customer Relationship Management (Gestão de Relacionamento com Cliente)
- **Pipeline**: Sequência de estágios que um cliente/projeto passa até o fechamento
- **Kanban**: Método visual de gestão de trabalho usando cards em colunas
- **PF**: Pessoa Física
- **PJ**: Pessoa Jurídica
- **MVP**: Minimum Viable Product (Produto Mínimo Viável)
- **DDD**: Domain-Driven Design
- **Clean Architecture**: Padrão arquitetural com separação de responsabilidades

---

## 13. Aprovações e Validações

### 13.1 Stakeholder
- **Product Owner**: [Nome do desenvolvedor autônomo]
- **Equipe de Desenvolvimento**: A definir

### 13.2 Validações Necessárias
- ✅ Requisitos foram revisados e aprovados
- ✅ Priorização do backlog foi validada
- ✅ Critérios de aceitação foram definidos
- ✅ Decisões técnicas foram documentadas

---

## 14. Histórico de Versões

| Versão | Data | Autor | Descrição |
|--------|------|-------|-----------|
| 1.0 | [Data atual] | Product Owner | Documento inicial de requisitos |

---

## Anexos

### Anexo A: Referências de Design
- [Shadcn UI Documentation](https://ui.shadcn.com/)
- [Lucide Icons](https://lucide.dev/)
- Componente sidebar-07 do shadcn/ui
- Componente Data Table do shadcn/ui

### Anexo B: Tecnologias
- React: https://react.dev/
- Vite: https://vitejs.dev/
- Fastify: https://www.fastify.io/
- Knex.js: https://knexjs.org/
- Neon: https://neon.tech/

