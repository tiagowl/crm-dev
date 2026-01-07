# Documentação Técnica - CRM para Desenvolvedor Autônomo

## 1. Visão Geral Técnica

### 1.1 Stack Tecnológica

#### Frontend
- **Framework**: React 18+
- **Build Tool**: Vite 5+
- **Linguagem**: TypeScript 5+
- **UI Library**: Shadcn/ui (baseado em Radix UI)
- **Ícones**: Lucide React
- **Roteamento**: React Router v6
- **HTTP Client**: Axios ou Fetch API
- **Estado**: React Hooks (Context API se necessário)
- **Formulários**: React Hook Form + Zod

#### Backend
- **Framework**: Fastify 4+
- **Linguagem**: TypeScript 5+
- **ORM/Query Builder**: Knex.js
- **Banco de Dados**: PostgreSQL (Neon)
- **Autenticação**: JWT (jsonwebtoken)
- **Hash de Senha**: bcrypt
- **Validação**: Zod ou Fastify schemas

#### Infraestrutura
- **Frontend Deploy**: Vercel ou Netlify
- **Backend Deploy**: Render ou Railway
- **Database**: Neon (PostgreSQL serverless)
- **Versionamento**: Git (GitHub)

---

## 2. Requisitos do Sistema

### 2.1 Requisitos Mínimos

#### Node.js
- Versão: 18.0.0 ou superior
- LTS recomendado

#### PostgreSQL
- Versão: 14 ou superior
- Neon oferece versão 16

#### Navegadores Suportados
- Chrome (últimas 2 versões)
- Firefox (últimas 2 versões)
- Safari (últimas 2 versões)
- Edge (últimas 2 versões)

---

## 3. Arquitetura Detalhada

### 3.1 Camadas do Backend

#### Domain Layer (Domínio)
**Responsabilidade**: Lógica de negócio pura, independente de tecnologia

**Componentes**:
- **Entities**: Entidades de negócio com seus comportamentos
- **Value Objects**: Objetos imutáveis que representam conceitos
- **Domain Services**: Lógica de negócio que não pertence a uma entidade
- **Repository Interfaces**: Contratos para acesso a dados

**Regras**:
- Não depende de nenhuma outra camada
- Sem dependências externas
- Testável sem mocks complexos

#### Application Layer (Aplicação)
**Responsabilidade**: Orquestrar casos de uso, coordenação de serviços

**Componentes**:
- **Use Cases**: Casos de uso da aplicação
- **DTOs**: Data Transfer Objects para comunicação
- **Mappers**: Conversão entre Domain e DTOs

**Regras**:
- Depende apenas do Domain
- Sem lógica de negócio (delega para Domain)
- Coordena fluxos de trabalho

#### Infrastructure Layer (Infraestrutura)
**Responsabilidade**: Implementações técnicas, acesso a recursos externos

**Componentes**:
- **Repositories**: Implementações concretas dos repositórios
- **Database**: Configuração e conexão com banco
- **External Services**: Integrações externas (email, APIs)

**Regras**:
- Implementa interfaces do Domain
- Pode depender de bibliotecas externas
- Isolado do restante da aplicação

#### Presentation Layer (Apresentação)
**Responsabilidade**: Interface com o mundo externo (HTTP)

**Componentes**:
- **Controllers**: Tratamento de requisições HTTP
- **Routes**: Definição de rotas
- **Middlewares**: Interceptação de requisições
- **Validators**: Validação de entrada

**Regras**:
- Depende da Application Layer
- Não conhece Domain diretamente
- Trata apenas protocolo HTTP

---

## 4. Estrutura de Dados

### 4.1 Entidades do Domínio

#### Client (Cliente)
```typescript
interface Client {
  id: string; // UUID
  userId: string; // UUID
  nome: string;
  empresa?: string;
  tipo: 'PF' | 'PJ';
  email: string;
  whatsapp?: string;
  segmento?: string;
  observacoesTecnicas?: string;
  status: ClientStatus;
  createdAt: Date;
  updatedAt: Date;
}

enum ClientStatus {
  LEAD = 'Lead',
  PRIMEIRO_CONTATO = 'Primeiro Contato',
  REUNIAO = 'Reunião',
  PROPOSTA_ENVIADA = 'Proposta Enviada',
  NEGOCIACAO = 'Negociação',
  FECHADO = 'Fechado'
}
```

#### Proposal (Proposta)
```typescript
interface Proposal {
  id: string; // UUID
  clientId: string; // UUID
  descricao: string;
  valor: number; // Decimal
  prazo: Date;
  formaPagamento: string;
  status: 'Enviada' | 'Aceita';
  createdAt: Date;
  updatedAt: Date;
}
```

#### Payment (Pagamento)
```typescript
interface Payment {
  id: string; // UUID
  clientId: string; // UUID
  proposalId?: string; // UUID
  valorCombinado: number; // Decimal
  installments: Installment[];
  createdAt: Date;
}

interface Installment {
  id: string; // UUID
  paymentId: string; // UUID
  numero: number;
  valor: number; // Decimal
  dataVencimento: Date;
  status: 'Pago' | 'Pendente' | 'Atrasado';
  dataPagamento?: Date;
  createdAt: Date;
  updatedAt: Date;
}
```

### 4.2 Schema do Banco de Dados

#### Tabela: clients
```sql
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  nome VARCHAR(200) NOT NULL,
  empresa VARCHAR(200),
  tipo VARCHAR(2) NOT NULL CHECK (tipo IN ('PF', 'PJ')),
  email VARCHAR(255) NOT NULL,
  whatsapp VARCHAR(20),
  segmento VARCHAR(100),
  observacoes_tecnicas TEXT,
  status VARCHAR(50) NOT NULL DEFAULT 'Lead',
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_clients_user_id ON clients(user_id);
CREATE INDEX idx_clients_status ON clients(status);
```

#### Tabela: proposals
```sql
CREATE TABLE proposals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  descricao TEXT NOT NULL,
  valor DECIMAL(10, 2) NOT NULL CHECK (valor > 0),
  prazo DATE NOT NULL,
  forma_pagamento VARCHAR(100) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'Enviada' CHECK (status IN ('Enviada', 'Aceita')),
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_proposals_client_id ON proposals(client_id);
CREATE INDEX idx_proposals_status ON proposals(status);
```

#### Tabela: payments
```sql
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
  proposal_id UUID REFERENCES proposals(id),
  valor_combinado DECIMAL(10, 2) NOT NULL CHECK (valor_combinado > 0),
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_payments_client_id ON payments(client_id);
```

#### Tabela: installments
```sql
CREATE TABLE installments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  payment_id UUID NOT NULL REFERENCES payments(id) ON DELETE CASCADE,
  numero INTEGER NOT NULL,
  valor DECIMAL(10, 2) NOT NULL CHECK (valor > 0),
  data_vencimento DATE NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'Pendente' CHECK (status IN ('Pago', 'Pendente', 'Atrasado')),
  data_pagamento DATE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_installments_payment_id ON installments(payment_id);
CREATE INDEX idx_installments_status ON installments(status);
CREATE INDEX idx_installments_vencimento ON installments(data_vencimento);
```

---

## 5. APIs e Endpoints

### 5.1 Autenticação

#### POST /api/auth/login
```typescript
Request: {
  email: string;
  password: string;
}

Response: {
  token: string;
  user: {
    id: string;
    email: string;
  }
}
```

#### POST /api/auth/register
```typescript
Request: {
  email: string;
  password: string;
}

Response: {
  token: string;
  user: {
    id: string;
    email: string;
  }
}
```

### 5.2 Clientes

#### GET /api/clients
Lista todos os clientes do usuário autenticado

**Query Params**:
- `status`: Filtrar por status
- `search`: Buscar por nome/empresa
- `page`: Número da página
- `limit`: Itens por página

**Response**:
```typescript
{
  data: Client[];
  pagination: {
    page: number;
    limit: number;
    total: number;
    totalPages: number;
  }
}
```

#### POST /api/clients
Cria novo cliente

**Request Body**:
```typescript
{
  nome: string;
  empresa?: string;
  tipo: 'PF' | 'PJ';
  email: string;
  whatsapp?: string;
  segmento?: string;
  observacoesTecnicas?: string;
}
```

#### PATCH /api/clients/:id/status
Atualiza status do cliente (usado no Kanban)

**Request Body**:
```typescript
{
  status: ClientStatus;
}
```

### 5.3 Propostas

#### GET /api/proposals
Lista propostas do usuário

#### POST /api/proposals
Cria nova proposta

**Request Body**:
```typescript
{
  clientId: string;
  descricao: string;
  valor: number;
  prazo: string; // ISO date
  formaPagamento: string;
}
```

### 5.4 Pagamentos

#### POST /api/payments
Registra pagamento

**Request Body**:
```typescript
{
  clientId: string;
  proposalId?: string;
  valorCombinado: number;
  installments: {
    numero: number;
    valor: number;
    dataVencimento: string; // ISO date
  }[];
}
```

#### PATCH /api/installments/:id/status
Atualiza status de parcela

**Request Body**:
```typescript
{
  status: 'Pago' | 'Pendente';
  dataPagamento?: string; // ISO date (se status = Pago)
}
```

---

## 6. Segurança

### 6.1 Autenticação

#### JWT (JSON Web Token)
- **Algoritmo**: HS256
- **Expiração**: 7 dias
- **Refresh**: Não implementado inicialmente (pode adicionar depois)

#### Hash de Senha
- **Algoritmo**: bcrypt
- **Rounds**: 10 (configurável)

### 6.2 Validação de Dados

#### Backend
- Validação em todas as rotas
- Sanitização de inputs
- Proteção contra SQL Injection (Knex usa parameterized queries)

#### Frontend
- Validação de formulários com Zod
- Sanitização antes do envio

### 6.3 CORS
- Configurado para permitir apenas domínio do frontend
- Credenciais habilitadas

### 6.4 Rate Limiting
- Implementar no futuro se necessário
- Fastify-rate-limit plugin

---

## 7. Performance

### 7.1 Otimizações Backend

#### Database
- Índices em colunas frequentemente consultadas
- Queries otimizadas (evitar N+1)
- Connection pooling

#### Caching
- Cache de queries frequentes (futuro: Redis)
- Cache de resultados de agregações

### 7.2 Otimizações Frontend

#### Bundle
- Code splitting por rota
- Lazy loading de componentes
- Tree shaking

#### Rendering
- Memoization de componentes pesados
- Virtual scrolling para listas grandes
- Debounce em buscas

---

## 8. Testes

### 8.1 Estratégia de Testes

#### Backend
- **Unit Tests**: Domain e Use Cases (Jest)
- **Integration Tests**: APIs e Repositories (Jest + Supertest)
- **E2E Tests**: Fluxos completos (opcional)

#### Frontend
- **Unit Tests**: Componentes e hooks (Vitest)
- **Integration Tests**: Features completas (Vitest + Testing Library)
- **E2E Tests**: Fluxos críticos (Playwright - futuro)

### 8.2 Cobertura Mínima
- **Domain**: 90%+
- **Use Cases**: 80%+
- **Controllers**: 70%+
- **Components**: 60%+

---

## 9. Deploy e DevOps

### 9.1 Pipeline de Deploy

#### Frontend (Vercel)
```
Git Push
  ↓
Vercel Build
  ↓
Run Tests (npm test)
  ↓
Build Production (npm run build)
  ↓
Deploy
```

#### Backend (Render)
```
Git Push
  ↓
Render Build
  ↓
Install Dependencies (npm install)
  ↓
Run Tests (npm test)
  ↓
Start Server (npm start)
```

### 9.2 Variáveis de Ambiente

#### Backend
```env
NODE_ENV=production
PORT=3000
DATABASE_URL=<neon-connection-string>
JWT_SECRET=<secret-key>
JWT_EXPIRES_IN=7d
BCRYPT_ROUNDS=10
CORS_ORIGIN=https://app.crm-dev.com
```

#### Frontend
```env
VITE_API_URL=https://api.crm-dev.com
VITE_APP_NAME=CRM Dev
```

---

## 10. Monitoramento e Logs

### 10.1 Logging

#### Backend
- **Winston** ou **Pino** (Fastify recomenda Pino)
- Níveis: error, warn, info, debug
- Formato JSON para produção

#### Frontend
- Console em desenvolvimento
- Error tracking (Sentry - futuro)

### 10.2 Métricas

#### Backend
- Response time
- Error rate
- Request rate
- Database query time

#### Frontend
- Page load time
- API call duration
- Error rate
- User actions

---

## 11. Versionamento

### 11.1 Versionamento de API
- **Estratégia**: URL versioning
- **Formato**: `/api/v1/...`
- **Future**: `/api/v2/...` quando houver breaking changes

### 11.2 Versionamento Semântico
- **Formato**: MAJOR.MINOR.PATCH
- **Exemplo**: 1.0.0
- **Regras**: Semantic Versioning 2.0.0

---

## 12. Documentação de Código

### 12.1 Comentários

#### Regras
- Código auto-explicativo (comentários apenas quando necessário)
- JSDoc para funções públicas
- Comentários explicam "por quê", não "o quê"

#### Exemplo
```typescript
/**
 * Calcula o status de uma parcela baseado na data de vencimento
 * @param installment - Parcela a ser analisada
 * @returns Status atualizado ('Pendente', 'Pago' ou 'Atrasado')
 */
function calculateInstallmentStatus(installment: Installment): InstallmentStatus {
  // ...
}
```

### 12.2 README
- Instruções de instalação
- Como rodar localmente
- Como executar testes
- Estrutura do projeto

---

## 13. Convenções de Código

### 13.1 Nomenclatura

#### TypeScript/JavaScript
- **Classes**: PascalCase (`ClientRepository`)
- **Funções/Métodos**: camelCase (`createClient`)
- **Variáveis**: camelCase (`clientName`)
- **Constantes**: UPPER_SNAKE_CASE (`MAX_RETRIES`)
- **Interfaces/Types**: PascalCase com prefixo `I` opcional (`IClient` ou `Client`)

#### Banco de Dados
- **Tabelas**: snake_case plural (`clients`, `proposals`)
- **Colunas**: snake_case (`client_id`, `created_at`)
- **Índices**: `idx_<table>_<column>`

### 13.2 Estrutura de Arquivos
- Um arquivo por entidade/classe
- Agrupamento por feature no frontend
- Agrupamento por camada no backend

---

## 14. Referências Técnicas

### 14.1 Documentação Oficial
- [React](https://react.dev/)
- [Fastify](https://www.fastify.io/)
- [Knex.js](https://knexjs.org/)
- [PostgreSQL](https://www.postgresql.org/docs/)
- [TypeScript](https://www.typescriptlang.org/docs/)

### 14.2 Guias de Arquitetura
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [DDD](https://martinfowler.com/bliki/DomainDrivenDesign.html)
- [Repository Pattern](https://martinfowler.com/eaaCatalog/repository.html)

