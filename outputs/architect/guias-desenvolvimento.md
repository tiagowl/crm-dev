# Guias de Desenvolvimento - CRM para Desenvolvedor Autônomo

## 1. Setup do Ambiente de Desenvolvimento

### 1.1 Pré-requisitos

#### Instalar Ferramentas
```bash
# Node.js (versão 18+)
node --version  # Verificar versão

# npm ou yarn
npm --version

# Git
git --version

# Editor recomendado: VS Code
```

#### Extensões VS Code Recomendadas
- ESLint
- Prettier
- TypeScript and JavaScript Language Features
- Tailwind CSS IntelliSense
- GitLens

### 1.2 Configuração Inicial

#### Clonar Repositório
```bash
git clone <repo-url>
cd crm-dev
```

#### Backend
```bash
cd backend
npm install
cp .env.example .env
# Configurar variáveis de ambiente
npm run dev
```

#### Frontend
```bash
cd frontend
npm install
cp .env.example .env
# Configurar variáveis de ambiente
npm run dev
```

---

## 2. Estrutura de Código

### 2.1 Convenções de Nomenclatura

#### Arquivos
- **Componentes React**: PascalCase (`ClientForm.tsx`)
- **Hooks**: camelCase com prefixo `use` (`useClients.ts`)
- **Services**: camelCase com sufixo `.service.ts` (`client.service.ts`)
- **Types**: camelCase com sufixo `.types.ts` (`client.types.ts`)
- **Utils**: camelCase (`formatters.ts`)

#### Código
- **Classes**: PascalCase
- **Funções/Variáveis**: camelCase
- **Constantes**: UPPER_SNAKE_CASE
- **Interfaces/Types**: PascalCase (sem prefixo `I`)

### 2.2 Organização de Arquivos

#### Backend - Nova Feature
```
backend/src/
├── domain/
│   ├── entities/
│   │   └── NewEntity.ts
│   └── repositories/
│       └── INewEntityRepository.ts
├── application/
│   └── use-cases/
│       └── new-entity/
│           ├── CreateNewEntityUseCase.ts
│           └── dto/
│               └── CreateNewEntityDTO.ts
├── infrastructure/
│   └── database/
│       └── repositories/
│           └── NewEntityRepository.ts
└── presentation/
    └── http/
        ├── routes/
        │   └── new-entity.routes.ts
        └── controllers/
            └── NewEntityController.ts
```

#### Frontend - Nova Feature
```
frontend/src/
├── components/
│   └── features/
│       └── new-feature/
│           ├── NewFeatureList.tsx
│           ├── NewFeatureForm.tsx
│           └── NewFeatureCard.tsx
├── pages/
│   └── NewFeature.tsx
├── hooks/
│   └── useNewFeature.ts
├── services/
│   └── new-feature.service.ts
└── types/
    └── new-feature.types.ts
```

---

## 3. Padrões de Código

### 3.1 Backend - Use Case

#### Template
```typescript
// application/use-cases/client/CreateClientUseCase.ts
import { IClientRepository } from '../../../domain/repositories/IClientRepository';
import { Client } from '../../../domain/entities/Client';
import { CreateClientDTO } from './dto/CreateClientDTO';

export class CreateClientUseCase {
  constructor(
    private clientRepository: IClientRepository
  ) {}

  async execute(dto: CreateClientDTO, userId: string): Promise<Client> {
    // Validações de negócio
    if (!dto.nome || dto.nome.length < 2) {
      throw new Error('Nome deve ter no mínimo 2 caracteres');
    }

    // Criar entidade
    const client = Client.create({
      userId,
      nome: dto.nome,
      tipo: dto.tipo,
      email: dto.email,
      // ... outros campos
    });

    // Salvar
    return await this.clientRepository.save(client);
  }
}
```

### 3.2 Backend - Repository

#### Template
```typescript
// infrastructure/database/repositories/ClientRepository.ts
import { IClientRepository } from '../../../domain/repositories/IClientRepository';
import { Client } from '../../../domain/entities/Client';
import { knex } from '../knex/connection';

export class ClientRepository implements IClientRepository {
  async save(client: Client): Promise<Client> {
    const [saved] = await knex('clients')
      .insert({
        id: client.id,
        user_id: client.userId,
        nome: client.nome,
        tipo: client.tipo,
        email: client.email,
        status: client.status,
        created_at: client.createdAt,
        updated_at: client.updatedAt,
      })
      .returning('*');

    return this.toDomain(saved);
  }

  async findById(id: string): Promise<Client | null> {
    const result = await knex('clients')
      .where({ id })
      .first();

    return result ? this.toDomain(result) : null;
  }

  private toDomain(row: any): Client {
    return Client.fromPersistence({
      id: row.id,
      userId: row.user_id,
      nome: row.nome,
      // ... mapear todos os campos
    });
  }
}
```

### 3.3 Backend - Controller

#### Template
```typescript
// presentation/http/controllers/ClientController.ts
import { FastifyRequest, FastifyReply } from 'fastify';
import { CreateClientUseCase } from '../../../application/use-cases/client/CreateClientUseCase';
import { CreateClientDTO } from '../../../application/use-cases/client/dto/CreateClientDTO';

export class ClientController {
  constructor(
    private createClientUseCase: CreateClientUseCase
  ) {}

  async create(
    request: FastifyRequest<{ Body: CreateClientDTO }>,
    reply: FastifyReply
  ) {
    try {
      const userId = request.user.id; // Do middleware de auth
      const client = await this.createClientUseCase.execute(
        request.body,
        userId
      );

      return reply.status(201).send(client);
    } catch (error) {
      return reply.status(400).send({
        error: error.message
      });
    }
  }
}
```

### 3.4 Frontend - Custom Hook

#### Template
```typescript
// hooks/useClients.ts
import { useState, useEffect } from 'react';
import { clientService } from '../services/client.service';
import { Client } from '../types/client.types';

export function useClients() {
  const [clients, setClients] = useState<Client[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    loadClients();
  }, []);

  const loadClients = async () => {
    try {
      setLoading(true);
      const data = await clientService.getAll();
      setClients(data);
    } catch (err) {
      setError(err.message);
    } finally {
      setLoading(false);
    }
  };

  const createClient = async (data: CreateClientDTO) => {
    try {
      const newClient = await clientService.create(data);
      setClients([...clients, newClient]);
      return newClient;
    } catch (err) {
      setError(err.message);
      throw err;
    }
  };

  return {
    clients,
    loading,
    error,
    createClient,
    reload: loadClients,
  };
}
```

### 3.5 Frontend - Service

#### Template
```typescript
// services/client.service.ts
import { api } from './api';
import { Client } from '../types/client.types';

export const clientService = {
  async getAll(): Promise<Client[]> {
    const response = await api.get('/clients');
    return response.data.data;
  },

  async getById(id: string): Promise<Client> {
    const response = await api.get(`/clients/${id}`);
    return response.data;
  },

  async create(data: CreateClientDTO): Promise<Client> {
    const response = await api.post('/clients', data);
    return response.data;
  },

  async update(id: string, data: Partial<Client>): Promise<Client> {
    const response = await api.patch(`/clients/${id}`, data);
    return response.data;
  },

  async updateStatus(id: string, status: ClientStatus): Promise<Client> {
    const response = await api.patch(`/clients/${id}/status`, { status });
    return response.data;
  },
};
```

---

## 4. Tratamento de Erros

### 4.1 Backend

#### Error Middleware
```typescript
// presentation/http/middleware/error.middleware.ts
export async function errorHandler(
  error: Error,
  request: FastifyRequest,
  reply: FastifyReply
) {
  // Log error
  request.log.error(error);

  // Erro de validação
  if (error instanceof ValidationError) {
    return reply.status(400).send({
      error: 'Validation Error',
      details: error.details,
    });
  }

  // Erro de negócio
  if (error instanceof BusinessError) {
    return reply.status(400).send({
      error: error.message,
    });
  }

  // Erro genérico
  return reply.status(500).send({
    error: 'Internal Server Error',
  });
}
```

### 4.2 Frontend

#### Error Boundary
```typescript
// components/shared/ErrorBoundary.tsx
import { Component, ErrorInfo, ReactNode } from 'react';

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
}

export class ErrorBoundary extends Component<Props, State> {
  public state: State = {
    hasError: false,
  };

  public static getDerivedStateFromError(): State {
    return { hasError: true };
  }

  public componentDidCatch(error: Error, errorInfo: ErrorInfo) {
    console.error('Uncaught error:', error, errorInfo);
  }

  public render() {
    if (this.state.hasError) {
      return <h1>Algo deu errado. Por favor, recarregue a página.</h1>;
    }

    return this.props.children;
  }
}
```

---

## 5. Testes

### 5.1 Teste Unitário - Use Case

```typescript
// tests/unit/use-cases/CreateClientUseCase.test.ts
import { CreateClientUseCase } from '../../../application/use-cases/client/CreateClientUseCase';
import { IClientRepository } from '../../../domain/repositories/IClientRepository';
import { Client } from '../../../domain/entities/Client';

describe('CreateClientUseCase', () => {
  let useCase: CreateClientUseCase;
  let mockRepository: jest.Mocked<IClientRepository>;

  beforeEach(() => {
    mockRepository = {
      save: jest.fn(),
      findById: jest.fn(),
      // ... outros métodos
    };
    useCase = new CreateClientUseCase(mockRepository);
  });

  it('should create a client successfully', async () => {
    const dto = {
      nome: 'João Silva',
      tipo: 'PF' as const,
      email: 'joao@example.com',
    };

    const savedClient = Client.create({ ...dto, userId: 'user-1' });
    mockRepository.save.mockResolvedValue(savedClient);

    const result = await useCase.execute(dto, 'user-1');

    expect(mockRepository.save).toHaveBeenCalledTimes(1);
    expect(result.nome).toBe('João Silva');
  });

  it('should throw error if nome is too short', async () => {
    const dto = {
      nome: 'A',
      tipo: 'PF' as const,
      email: 'joao@example.com',
    };

    await expect(useCase.execute(dto, 'user-1')).rejects.toThrow();
  });
});
```

### 5.2 Teste de Integração - API

```typescript
// tests/integration/client.test.ts
import { build } from '../../src/app';
import { createTestUser, getAuthToken } from '../helpers';

describe('POST /api/clients', () => {
  let app: FastifyInstance;
  let authToken: string;

  beforeAll(async () => {
    app = await build();
    const user = await createTestUser();
    authToken = await getAuthToken(user);
  });

  it('should create a client', async () => {
    const response = await app.inject({
      method: 'POST',
      url: '/api/clients',
      headers: {
        authorization: `Bearer ${authToken}`,
      },
      payload: {
        nome: 'Test Client',
        tipo: 'PF',
        email: 'test@example.com',
      },
    });

    expect(response.statusCode).toBe(201);
    const body = JSON.parse(response.body);
    expect(body.nome).toBe('Test Client');
  });
});
```

---

## 6. Migrações de Banco

### 6.1 Criar Migração

```bash
cd backend
npx knex migrate:make create_clients_table
```

### 6.2 Template de Migração

```typescript
// migrations/20240101000000_create_clients_table.ts
import { Knex } from 'knex';

export async function up(knex: Knex): Promise<void> {
  return knex.schema.createTable('clients', (table) => {
    table.uuid('id').primary().defaultTo(knex.raw('gen_random_uuid()'));
    table.uuid('user_id').notNullable().references('id').inTable('users').onDelete('CASCADE');
    table.string('nome', 200).notNullable();
    table.string('empresa', 200);
    table.string('tipo', 2).notNullable().check('tipo IN (\'PF\', \'PJ\')');
    table.string('email', 255).notNullable();
    table.string('whatsapp', 20);
    table.string('segmento', 100);
    table.text('observacoes_tecnicas');
    table.string('status', 50).notNullable().defaultTo('Lead');
    table.timestamps(true, true);

    table.index('user_id');
    table.index('status');
  });
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTable('clients');
}
```

### 6.3 Executar Migrações

```bash
# Desenvolvimento
npm run migrate:latest

# Rollback
npm run migrate:rollback
```

---

## 7. Git Workflow

### 7.1 Branches

- **main**: Produção (protegida)
- **develop**: Desenvolvimento
- **feature/**: Novas features (`feature/add-kanban`)
- **fix/**: Correções (`fix/login-error`)
- **hotfix/**: Correções urgentes (`hotfix/security-patch`)

### 7.2 Commits

#### Formato
```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[rodapé opcional]
```

#### Tipos
- `feat`: Nova feature
- `fix`: Correção de bug
- `docs`: Documentação
- `style`: Formatação
- `refactor`: Refatoração
- `test`: Testes
- `chore`: Tarefas gerais

#### Exemplos
```
feat(client): add client creation form

fix(api): correct authentication middleware

docs(readme): update setup instructions

refactor(domain): simplify Client entity
```

### 7.3 Pull Requests

#### Checklist
- [ ] Código segue padrões do projeto
- [ ] Testes passando
- [ ] Sem erros de lint
- [ ] Documentação atualizada
- [ ] Code review aprovado

---

## 8. Performance

### 8.1 Backend - Otimizações

#### Queries
- Usar índices
- Evitar N+1 queries
- Usar paginação
- Selecionar apenas colunas necessárias

#### Exemplo
```typescript
// ❌ Ruim
const clients = await knex('clients');
for (const client of clients) {
  const proposals = await knex('proposals').where('client_id', client.id);
}

// ✅ Bom
const clients = await knex('clients')
  .select('id', 'nome', 'status') // Apenas necessário
  .limit(20) // Paginação
  .offset(0);

const proposals = await knex('proposals')
  .whereIn('client_id', clients.map(c => c.id));
```

### 8.2 Frontend - Otimizações

#### Code Splitting
```typescript
// Lazy load de rotas
const Dashboard = lazy(() => import('./pages/Dashboard'));
const Clients = lazy(() => import('./pages/Clients'));
```

#### Memoization
```typescript
// Memoizar componentes pesados
const ClientCard = memo(({ client }: Props) => {
  // ...
});

// Memoizar cálculos
const total = useMemo(() => {
  return clients.reduce((sum, c) => sum + c.valor, 0);
}, [clients]);
```

---

## 9. Debugging

### 9.1 Backend

#### Logs
```typescript
// Usar logger do Fastify
request.log.info('Creating client', { clientId });
request.log.error('Error creating client', error);
```

#### Debug
```bash
# Node.js debugger
node --inspect dist/server.js

# VS Code: Launch configuration
{
  "type": "node",
  "request": "attach",
  "port": 9229
}
```

### 9.2 Frontend

#### React DevTools
- Instalar extensão do navegador
- Inspecionar componentes e estado

#### Console
```typescript
// Debug específico
console.group('Client Creation');
console.log('Data:', data);
console.log('Response:', response);
console.groupEnd();
```

---

## 10. Checklist de Desenvolvimento

### 10.1 Nova Feature

#### Antes de Começar
- [ ] Entender requisitos
- [ ] Verificar se já existe código similar
- [ ] Criar branch `feature/nome-da-feature`

#### Durante Desenvolvimento
- [ ] Seguir padrões de código
- [ ] Escrever testes
- [ ] Atualizar documentação se necessário
- [ ] Commits descritivos

#### Antes de Merge
- [ ] Testes passando
- [ ] Lint passando
- [ ] Sem warnings
- [ ] Code review aprovado
- [ ] Testado manualmente

### 10.2 Correção de Bug

- [ ] Reproduzir bug
- [ ] Identificar causa raiz
- [ ] Escrever teste que falha
- [ ] Corrigir bug
- [ ] Teste passa
- [ ] Verificar que não quebrou nada mais

---

## 11. Recursos Úteis

### 11.1 Documentação
- [Fastify Docs](https://www.fastify.io/docs/latest/)
- [Knex.js Docs](https://knexjs.org/)
- [React Docs](https://react.dev/)
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)

### 11.2 Ferramentas
- [Postman](https://www.postman.com/) - Testar APIs
- [DBeaver](https://dbeaver.io/) - Gerenciar banco
- [React DevTools](https://react.dev/learn/react-developer-tools)

### 11.3 Comunidade
- Discord/Slack do projeto
- Stack Overflow
- GitHub Issues

---

## 12. FAQ

### Como adicionar nova feature?
1. Criar branch `feature/nome`
2. Implementar seguindo padrões
3. Escrever testes
4. Criar PR
5. Code review
6. Merge

### Como debugar problema de performance?
1. Usar ferramentas de profiling
2. Verificar queries no banco
3. Analisar network no frontend
4. Verificar logs do servidor

### Onde reportar bugs?
- Criar issue no GitHub
- Descrever problema claramente
- Incluir passos para reproduzir
- Adicionar screenshots se aplicável

