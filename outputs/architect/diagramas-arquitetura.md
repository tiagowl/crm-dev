# Diagramas de Arquitetura - CRM para Desenvolvedor Autônomo

## 1. Arquitetura Geral do Sistema

### 1.1 Visão de Alto Nível

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLIENTE (Browser)                        │
│                    React + Vite + TypeScript                     │
│                      (Frontend SPA)                              │
└────────────────────────────┬────────────────────────────────────┘
                             │ HTTPS/REST API
                             │ (JSON)
┌────────────────────────────▼────────────────────────────────────┐
│                      API GATEWAY                                 │
│                      (Fastify Server)                            │
│                  ┌──────────────────┐                            │
│                  │  Authentication  │                            │
│                  │     Middleware   │                            │
│                  └──────────────────┘                            │
└────────────────────────────┬────────────────────────────────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
┌───────────────▼──────────┐  ┌──────────▼──────────────┐
│   APPLICATION LAYER      │  │   INFRASTRUCTURE        │
│   (Use Cases)            │  │   (Repositories)        │
│                          │  │                         │
│  - CreateClient          │  │  - ClientRepository     │
│  - UpdateClient          │  │  - ProposalRepository   │
│  - MoveClientStatus      │  │  - PaymentRepository    │
│  - CreateProposal        │  │  - UserRepository       │
│  - RegisterPayment       │  │                         │
└───────────────┬──────────┘  └──────────┬──────────────┘
                │                        │
                └────────────┬───────────┘
                             │
                ┌────────────▼────────────┐
                │   DOMAIN LAYER          │
                │   (Entities & Rules)    │
                │                         │
                │  - Client               │
                │  - Proposal             │
                │  - Payment              │
                │  - Installment          │
                │  - User                 │
                └────────────┬────────────┘
                             │
                ┌────────────▼────────────┐
                │   DATABASE              │
                │   PostgreSQL (Neon)     │
                │                         │
                │  - clients              │
                │  - proposals            │
                │  - payments             │
                │  - installments         │
                │  - users                │
                └─────────────────────────┘
```

---

## 2. Arquitetura do Backend (Clean Architecture)

### 2.1 Estrutura de Camadas

```
backend/
├── src/
│   ├── domain/                    # Camada de Domínio (Innermost)
│   │   ├── entities/             # Entidades de negócio
│   │   │   ├── Client.ts
│   │   │   ├── Proposal.ts
│   │   │   ├── Payment.ts
│   │   │   ├── Installment.ts
│   │   │   └── User.ts
│   │   ├── value-objects/        # Value Objects
│   │   │   ├── Email.ts
│   │   │   ├── Money.ts
│   │   │   └── Status.ts
│   │   ├── repositories/         # Interfaces (Abstrações)
│   │   │   ├── IClientRepository.ts
│   │   │   ├── IProposalRepository.ts
│   │   │   ├── IPaymentRepository.ts
│   │   │   └── IUserRepository.ts
│   │   └── services/             # Serviços de Domínio
│   │       ├── PaymentStatusCalculator.ts
│   │       └── ClientStatusService.ts
│   │
│   ├── application/              # Camada de Aplicação
│   │   ├── use-cases/           # Casos de Uso
│   │   │   ├── client/
│   │   │   │   ├── CreateClientUseCase.ts
│   │   │   │   ├── UpdateClientUseCase.ts
│   │   │   │   ├── GetClientUseCase.ts
│   │   │   │   └── ListClientsUseCase.ts
│   │   │   ├── proposal/
│   │   │   │   ├── CreateProposalUseCase.ts
│   │   │   │   └── UpdateProposalStatusUseCase.ts
│   │   │   └── payment/
│   │   │       ├── RegisterPaymentUseCase.ts
│   │   │       └── UpdateInstallmentStatusUseCase.ts
│   │   ├── dto/                  # Data Transfer Objects
│   │   │   ├── CreateClientDTO.ts
│   │   │   └── CreateProposalDTO.ts
│   │   └── mappers/              # Mappers Domain <-> DTO
│   │       ├── ClientMapper.ts
│   │       └── ProposalMapper.ts
│   │
│   ├── infrastructure/           # Camada de Infraestrutura (Outermost)
│   │   ├── database/            # Acesso a Dados
│   │   │   ├── knex/            # Configuração Knex
│   │   │   │   └── connection.ts
│   │   │   └── repositories/    # Implementações
│   │   │       ├── ClientRepository.ts
│   │   │       ├── ProposalRepository.ts
│   │   │       └── PaymentRepository.ts
│   │   ├── auth/                # Autenticação
│   │   │   ├── jwt.ts
│   │   │   └── password.ts
│   │   └── external/            # Integrações externas (futuro)
│   │       └── email/
│   │
│   └── presentation/            # Camada de Apresentação
│       ├── http/               # Controllers HTTP
│       │   ├── routes/
│       │   │   ├── client.routes.ts
│       │   │   ├── proposal.routes.ts
│       │   │   └── payment.routes.ts
│       │   ├── controllers/
│       │   │   ├── ClientController.ts
│       │   │   ├── ProposalController.ts
│       │   │   └── PaymentController.ts
│       │   └── middleware/
│       │       ├── auth.middleware.ts
│       │       └── error.middleware.ts
│       └── validators/         # Validação de entrada
│           ├── client.validator.ts
│           └── proposal.validator.ts
│
├── tests/                      # Testes
│   ├── unit/
│   ├── integration/
│   └── e2e/
│
└── package.json
```

### 2.2 Fluxo de Dependências

```
Presentation Layer
    ↓ (depende de)
Application Layer
    ↓ (depende de)
Domain Layer
    ↑ (implementado por)
Infrastructure Layer
```

**Regra**: Dependências apontam sempre para dentro (Domain é independente)

---

## 3. Arquitetura do Frontend

### 3.1 Estrutura do Frontend

```
frontend/
├── src/
│   ├── components/             # Componentes React
│   │   ├── ui/                # Componentes do shadcn/ui
│   │   │   ├── button.tsx
│   │   │   ├── input.tsx
│   │   │   └── table.tsx
│   │   ├── layout/            # Layout Components
│   │   │   ├── Sidebar.tsx
│   │   │   ├── Header.tsx
│   │   │   └── Layout.tsx
│   │   ├── features/          # Feature Components
│   │   │   ├── clients/
│   │   │   │   ├── ClientList.tsx
│   │   │   │   ├── ClientForm.tsx
│   │   │   │   └── ClientCard.tsx
│   │   │   ├── pipeline/
│   │   │   │   └── KanbanBoard.tsx
│   │   │   └── proposals/
│   │   │       └── ProposalForm.tsx
│   │   └── shared/            # Componentes Compartilhados
│   │       ├── Loading.tsx
│   │       └── ErrorMessage.tsx
│   │
│   ├── pages/                 # Páginas/Rotas
│   │   ├── Login.tsx
│   │   ├── Dashboard.tsx
│   │   ├── Clients.tsx
│   │   ├── Pipeline.tsx
│   │   ├── Proposals.tsx
│   │   └── Financial.tsx
│   │
│   ├── hooks/                 # Custom Hooks
│   │   ├── useAuth.ts
│   │   ├── useClients.ts
│   │   ├── useProposals.ts
│   │   └── useKanban.ts
│   │
│   ├── services/              # API Services
│   │   ├── api.ts             # Axios/Fetch config
│   │   ├── client.service.ts
│   │   ├── proposal.service.ts
│   │   └── auth.service.ts
│   │
│   ├── store/                 # Estado Global (se necessário)
│   │   └── authStore.ts
│   │
│   ├── types/                 # TypeScript Types
│   │   ├── client.types.ts
│   │   ├── proposal.types.ts
│   │   └── api.types.ts
│   │
│   ├── utils/                 # Utilitários
│   │   ├── formatters.ts
│   │   ├── validators.ts
│   │   └── constants.ts
│   │
│   ├── App.tsx
│   └── main.tsx
│
└── package.json
```

### 3.2 Fluxo de Dados Frontend

```
Component (UI)
    ↓ (chama)
Custom Hook
    ↓ (chama)
Service (API)
    ↓ (HTTP Request)
Backend API
    ↓ (Response)
Service
    ↓ (processa)
Hook (atualiza estado)
    ↓ (notifica)
Component (re-render)
```

---

## 4. Diagrama de Fluxo de Dados

### 4.1 Fluxo: Criar Novo Cliente

```
┌──────────┐
│  Browser │
└────┬─────┘
     │ 1. Submit Form
     ▼
┌──────────────────┐
│  ClientForm.tsx  │
│  (Frontend)      │
└────┬─────────────┘
     │ 2. useClients hook
     ▼
┌──────────────────┐
│ client.service.ts│
│  (Frontend)      │
└────┬─────────────┘
     │ 3. POST /api/clients
     ▼
┌──────────────────┐
│  Fastify Server  │
│  (Backend)       │
└────┬─────────────┘
     │ 4. Auth Middleware
     ▼
┌──────────────────┐
│ClientController  │
│  (Backend)       │
└────┬─────────────┘
     │ 5. Validation
     ▼
┌──────────────────┐
│CreateClientUseCase│
│  (Application)   │
└────┬─────────────┘
     │ 6. Business Rules
     ▼
┌──────────────────┐
│ClientRepository  │
│  (Infrastructure)│
└────┬─────────────┘
     │ 7. Knex Query
     ▼
┌──────────────────┐
│  PostgreSQL      │
│  (Neon)          │
└──────────────────┘
```

### 4.2 Fluxo: Atualizar Status no Pipeline (Kanban)

```
┌──────────┐
│  Browser │ Drag & Drop
└────┬─────┘
     │
     ▼
┌──────────────────┐
│  KanbanBoard.tsx │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│  useKanban hook  │
└────┬─────────────┘
     │ PATCH /api/clients/:id/status
     ▼
┌──────────────────┐
│ClientController  │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│UpdateClientStatus│
│    UseCase       │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│ClientRepository  │
│  (Update Status) │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│  PostgreSQL      │
│  UPDATE clients  │
└──────────────────┘
```

---

## 5. Diagrama de Banco de Dados

### 5.1 Modelo Relacional

```
┌─────────────────┐
│     users       │
├─────────────────┤
│ id (PK, UUID)   │
│ email (UNIQUE)  │
│ password_hash   │
│ created_at      │
│ updated_at      │
└────────┬────────┘
         │ 1
         │
         │ N
┌────────▼────────┐
│    clients      │
├─────────────────┤
│ id (PK, UUID)   │
│ user_id (FK)    │
│ nome            │
│ empresa         │
│ tipo (PF/PJ)    │
│ email           │
│ whatsapp        │
│ segmento        │
│ obs_tecnicas    │
│ status (ENUM)   │
│ created_at      │
│ updated_at      │
└────────┬────────┘
         │ 1
         │
         │ N
┌────────▼────────┐      ┌─────────────┐
│   proposals     │      │  payments   │
├─────────────────┤      ├─────────────┤
│ id (PK, UUID)   │      │ id (PK)     │
│ client_id (FK)  │      │ client_id   │
│ descricao       │      │ proposta_id │
│ valor           │      │ valor_total │
│ prazo           │      │ created_at  │
│ forma_pagamento │      └──────┬──────┘
│ status (ENUM)   │             │ 1
│ created_at      │             │
│ updated_at      │             │ N
└─────────────────┘      ┌──────▼──────┐
                         │ installments│
                         ├─────────────┤
                         │ id (PK)     │
                         │ payment_id  │
                         │ numero      │
                         │ valor       │
                         │ vencimento  │
                         │ status      │
                         │ data_pag    │
                         │ created_at  │
                         │ updated_at  │
                         └──────┬──────┘
                                │ 1
                                │
                                │ N
                         ┌──────▼──────┐
                         │  billings   │
                         ├─────────────┤
                         │ id (PK)     │
                         │ parcel_id   │
                         │ data_tent   │
                         │ metodo      │
                         │ observacoes │
                         │ created_at  │
                         └─────────────┘
```

### 5.2 Índices Importantes

```sql
-- Índices para performance
CREATE INDEX idx_clients_user_id ON clients(user_id);
CREATE INDEX idx_clients_status ON clients(status);
CREATE INDEX idx_proposals_client_id ON proposals(client_id);
CREATE INDEX idx_proposals_status ON proposals(status);
CREATE INDEX idx_installments_payment_id ON installments(payment_id);
CREATE INDEX idx_installments_status ON installments(status);
CREATE INDEX idx_installments_vencimento ON installments(data_vencimento);
```

---

## 6. Arquitetura de Segurança

### 6.1 Fluxo de Autenticação

```
┌──────────┐
│  Client  │ POST /api/auth/login
└────┬─────┘ { email, password }
     │
     ▼
┌──────────────────┐
│ AuthController   │
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│  Verify Password │ (bcrypt)
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│ Generate JWT     │
│ { userId, email }│
└────┬─────────────┘
     │
     ▼
┌──────────────────┐
│  Return Token    │
│  { token, user } │
└──────────────────┘
```

### 6.2 Middleware de Autenticação

```
Request
    │
    ▼
┌──────────────────┐
│ Auth Middleware  │
│                  │
│ 1. Extract Token │
│    (Header)      │
│                  │
│ 2. Verify JWT    │
│                  │
│ 3. Get User      │
│    from DB       │
│                  │
│ 4. Attach to     │
│    request.user  │
└────┬─────────────┘
     │
     ▼ (if valid)
Controller
     │
     ▼ (if invalid)
401 Unauthorized
```

---

## 7. Arquitetura de Deploy

### 7.1 Ambiente de Produção

```
┌─────────────────────────────────────────┐
│         CDN (Vercel/Netlify)            │
│         (Frontend Static)               │
└────────────────┬────────────────────────┘
                 │
                 │ HTTPS
                 │
┌────────────────▼────────────────────────┐
│      API Server (Render/Railway)        │
│      Fastify + Node.js                  │
│                                          │
│  ┌──────────────────────────────────┐   │
│  │   Application                    │   │
│  │   - Use Cases                    │   │
│  │   - Controllers                  │   │
│  └──────────────────────────────────┘   │
└────────────────┬────────────────────────┘
                 │
                 │ Connection Pool
                 │
┌────────────────▼────────────────────────┐
│   PostgreSQL (Neon)                     │
│   - Serverless                          │
│   - Auto-scaling                        │
│   - Backups automáticos                 │
└─────────────────────────────────────────┘
```

### 7.2 Ambientes

```
Development (Local)
    ├── Frontend: localhost:5173 (Vite)
    ├── Backend: localhost:3000 (Fastify)
    └── Database: Neon Dev Instance

Staging
    ├── Frontend: staging.crm-dev.vercel.app
    ├── Backend: crm-api-staging.render.com
    └── Database: Neon Staging Instance

Production
    ├── Frontend: app.crm-dev.com
    ├── Backend: api.crm-dev.com
    └── Database: Neon Production Instance
```

---

## 8. Integrações Futuras

### 8.1 Arquitetura com Integrações

```
┌─────────────────────────────────────────┐
│           Application Core              │
└────────────────┬────────────────────────┘
                 │
    ┌────────────┼────────────┐
    │            │            │
┌───▼────┐  ┌───▼────┐  ┌───▼────┐
│ Email  │  │WhatsApp│  │Payment │
│Service │  │  API   │  │Gateway │
│(Resend)│  │        │  │        │
└────────┘  └────────┘  └────────┘
```

### 8.2 Background Jobs (Futuro)

```
┌─────────────────────────────────────────┐
│      Background Job Service             │
│      (node-cron / Bull Queue)           │
│                                          │
│  ┌──────────────────────────────────┐   │
│  │  Daily Job: Check Installments  │   │
│  │  - Find due installments        │   │
│  │  - Send alerts                  │   │
│  │  - Update status                │   │
│  └──────────────────────────────────┘   │
└─────────────────────────────────────────┘
```

---

## 9. Diagrama de Sequência - Caso de Uso Completo

### 9.1 Criar Proposta e Registrar Pagamento

```
Client    Frontend    Backend API    UseCase    Repository    Database
  │           │            │            │            │            │
  │──Submit──>│            │            │            │            │
  │           │──POST─────>│            │            │            │
  │           │            │──Validate─>│            │            │
  │           │            │            │──Create───>│            │
  │           │            │            │            │──INSERT───>│
  │           │            │            │            │<──Success──│
  │           │            │            │<──Return───│            │
  │           │            │<──Response─│            │            │
  │           │<──200 OK───│            │            │            │
  │<──Update──│            │            │            │            │
  │           │            │            │            │            │
  │──Register Payment────────────────────────────────────────────>│
  │           │──POST─────>│            │            │            │
  │           │            │──Register─>│            │            │
  │           │            │            │──Create───>│            │
  │           │            │            │            │──INSERT───>│
  │           │            │            │            │<──Success──│
  │           │            │            │──Create───>│            │
  │           │            │            │Installments│            │
  │           │            │            │            │──INSERT───>│
  │           │            │            │            │            │
```

---

## 10. Resumo da Arquitetura

### 10.1 Princípios Aplicados

- ✅ **Clean Architecture**: Separação clara de camadas
- ✅ **DDD**: Modelagem orientada ao domínio
- ✅ **Repository Pattern**: Abstração de acesso a dados
- ✅ **Dependency Inversion**: Dependências apontam para dentro
- ✅ **SOLID**: Princípios aplicados em todas as camadas

### 10.2 Benefícios

- **Testabilidade**: Camadas isoladas, fácil mock
- **Manutenibilidade**: Responsabilidades claras
- **Escalabilidade**: Fácil adicionar features
- **Flexibilidade**: Mudanças em infraestrutura não afetam domínio

