# Decisões Arquiteturais (ADRs) - CRM para Desenvolvedor Autônomo

## Formato dos ADRs

Cada ADR segue o formato:
- **Status**: Proposto | Aceito | Deprecated | Substituído
- **Contexto**: Por que precisamos desta decisão
- **Decisão**: O que decidimos fazer
- **Consequências**: O que muda com esta decisão

---

## ADR-001: Uso de Clean Architecture

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos de uma arquitetura que seja:
- Testável
- Manutenível
- Independente de frameworks
- Fácil de evoluir

### Decisão
Adotar Clean Architecture com separação em 4 camadas:
1. **Domain**: Lógica de negócio pura
2. **Application**: Casos de uso
3. **Infrastructure**: Implementações técnicas
4. **Presentation**: Interface HTTP

### Consequências

#### Positivas
- ✅ Código de negócio isolado e testável
- ✅ Fácil trocar implementações (ex: banco de dados)
- ✅ Testes unitários sem mocks complexos
- ✅ Onboarding de novos devs mais fácil

#### Negativas
- ⚠️ Mais arquivos e abstrações
- ⚠️ Curva de aprendizado inicial maior
- ⚠️ Mais código boilerplate

#### Mitigações
- Documentação clara da arquitetura
- Templates de código para novos casos de uso
- Code reviews focados em manter padrões

---

## ADR-002: TypeScript como Linguagem Principal

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos de:
- Type safety
- Melhor DX (Developer Experience)
- Detecção de erros em tempo de compilação
- Autocomplete melhor

### Decisão
Usar TypeScript tanto no frontend quanto no backend.

### Consequências

#### Positivas
- ✅ Menos bugs em produção
- ✅ Refatoração mais segura
- ✅ Documentação automática através de tipos
- ✅ Melhor suporte de IDEs

#### Negativas
- ⚠️ Setup inicial mais complexo
- ⚠️ Compilação adicional
- ⚠️ Curva de aprendizado para devs não familiarizados

#### Mitigações
- Configuração TypeScript padronizada
- Strict mode habilitado
- Tipos bem definidos para DTOs

---

## ADR-003: Fastify como Framework Backend

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos de um framework HTTP rápido e performático. Opções consideradas:
- Express (mais popular, mas mais lento)
- Fastify (mais rápido, melhor suporte TypeScript)
- NestJS (mais opinionado, mais pesado)

### Decisão
Usar Fastify pela performance e melhor suporte TypeScript nativo.

### Consequências

#### Positivas
- ✅ Performance superior ao Express
- ✅ Validação de schemas built-in
- ✅ Serialização JSON otimizada
- ✅ Menor overhead

#### Negativas
- ⚠️ Menos recursos/tutoriais que Express
- ⚠️ Ecossistema menor
- ⚠️ Alguns middlewares podem não ser compatíveis

#### Mitigações
- Fastify tem plugins para maioria das necessidades
- Documentação oficial é boa
- Comunidade crescente

---

## ADR-004: Knex.js ao invés de ORM

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos de acesso a dados. Opções:
- TypeORM (ORM completo, mais "mágico")
- Prisma (moderno, mas gera código)
- Knex.js (query builder, mais controle)

### Decisão
Usar Knex.js como query builder, implementando Repository Pattern manualmente.

### Consequências

#### Positivas
- ✅ Controle total sobre queries
- ✅ Performance otimizada
- ✅ Não gera código (mais previsível)
- ✅ Fácil migrações
- ✅ SQL puro quando necessário

#### Negativas
- ⚠️ Mais código manual
- ⚠️ Sem validação automática de tipos em queries
- ⚠️ Mais trabalho para relacionamentos

#### Mitigações
- Repository Pattern encapsula complexidade
- Tipos TypeScript ajudam
- Queries complexas são raras no MVP

---

## ADR-005: PostgreSQL como Banco de Dados

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Necessitamos de banco relacional robusto. Opções:
- PostgreSQL (robusto, ACID, features avançadas)
- MySQL (popular, mas menos features)
- SQLite (simples, mas não adequado para produção)

### Decisão
Usar PostgreSQL via Neon (serverless).

### Consequências

#### Positivas
- ✅ ACID completo
- ✅ Features avançadas (JSON, arrays, full-text search)
- ✅ Boa performance
- ✅ Neon oferece serverless (sem gerenciamento)

#### Negativas
- ⚠️ Pode ser overkill para MVP simples
- ⚠️ Mais complexo que SQLite local

#### Mitigações
- Neon facilita gerenciamento
- Escalabilidade futura garantida
- Recursos avançados disponíveis se necessário

---

## ADR-006: Repository Pattern

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos abstrair acesso a dados para:
- Isolar Domain de detalhes de implementação
- Facilitar testes (mocks)
- Permitir trocar banco no futuro

### Decisão
Implementar Repository Pattern com interfaces no Domain e implementações na Infrastructure.

### Consequências

#### Positivas
- ✅ Domain não conhece SQL
- ✅ Testes unitários sem banco
- ✅ Fácil criar mocks
- ✅ Possível trocar implementação

#### Negativas
- ⚠️ Mais abstrações
- ⚠️ Mais código boilerplate

#### Mitigações
- Interface simples
- Implementações diretas (sem complexidade desnecessária)

---

## ADR-007: JWT para Autenticação

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Precisamos autenticar usuários. Opções:
- JWT (stateless, escalável)
- Sessions (stateful, mais seguro)
- OAuth (complexo demais para MVP)

### Decisão
Usar JWT com expiração de 7 dias.

### Consequências

#### Positivas
- ✅ Stateless (escala melhor)
- ✅ Funciona bem com SPA
- ✅ Sem necessidade de storage no servidor

#### Negativas
- ⚠️ Difícil invalidar tokens antes de expirar
- ⚠️ Tokens podem ser roubados (XSS)
- ⚠️ Sem refresh token (implementar depois)

#### Mitigações
- HTTPS obrigatório
- XSS protection no frontend
- Considerar refresh tokens no futuro

---

## ADR-008: Shadcn/ui ao invés de Biblioteca Completa

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto + UX

### Contexto
Precisamos de componentes UI. Opções:
- Material-UI (completo, mas pesado)
- Ant Design (completo, estilo específico)
- Shadcn/ui (componentes copiáveis, customizáveis)

### Decisão
Usar Shadcn/ui para flexibilidade e customização.

### Consequências

#### Positivas
- ✅ Componentes no nosso código (control total)
- ✅ Customização fácil
- ✅ Não aumenta bundle size desnecessariamente
- ✅ Baseado em Radix UI (acessível)

#### Negativas
- ⚠️ Mais trabalho manual
- ⚠️ Não vem "pronto para produção" (precisa configurar)

#### Mitigações
- Componentes bem testados
- Documentação boa
- Comunidade ativa

---

## ADR-009: Neon (Serverless Postgres) ao invés de Self-Hosted

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto + DevOps

### Contexto
Precisamos de banco gerenciado. Opções:
- Neon (serverless, fácil)
- Supabase (mais features, mas mais complexo)
- Railway Postgres (tradicional)
- Self-hosted (mais controle, mais trabalho)

### Decisão
Usar Neon para simplicidade e foco no desenvolvimento.

### Consequências

#### Positivas
- ✅ Zero gerenciamento
- ✅ Auto-scaling
- ✅ Backups automáticos
- ✅ Branching de banco (dev/test)

#### Negativas
- ⚠️ Vendor lock-in
- ⚠️ Custo pode aumentar com uso
- ⚠️ Menos controle

#### Mitigações
- Exportar dados regularmente
- Planejar migração se necessário
- Custo baixo no início

---

## ADR-010: Deploy Separado Frontend/Backend

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Como fazer deploy? Opções:
- Monorepo com deploy único (simples, mas acoplado)
- Deploy separado (flexível, independente)
- Serverless functions (complexo para MVP)

### Decisão
Deploy separado: Frontend (Vercel) + Backend (Render).

### Consequências

#### Positivas
- ✅ Deploys independentes
- ✅ Escalabilidade independente
- ✅ Fácil fazer CDN no frontend
- ✅ Backend pode ter múltiplos frontends

#### Negativas
- ⚠️ Mais complexo gerenciar
- ⚠️ CORS necessário
- ⚠️ Mais serviços para monitorar

#### Mitigações
- CI/CD configurado
- CORS bem configurado
- Monitoramento centralizado (futuro)

---

## ADR-011: Sem Cache no MVP

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Cache melhoraria performance, mas adiciona complexidade.

### Decisão
Não implementar cache no MVP. Adicionar depois se necessário.

### Consequências

#### Positivas
- ✅ Menos complexidade
- ✅ Menos pontos de falha
- ✅ Desenvolvimento mais rápido

#### Negativas
- ⚠️ Queries repetidas ao banco
- ⚠️ Performance pode degradar com muitos usuários

#### Mitigações
- Índices no banco otimizam queries
- Adicionar cache (Redis) quando necessário
- Monitorar performance

---

## ADR-012: Testes Unitários Prioritários sobre E2E

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Recursos limitados. Onde focar testes?

### Decisão
Focar em testes unitários (Domain, Use Cases) e integração (APIs). E2E apenas para fluxos críticos.

### Consequências

#### Positivas
- ✅ Testes rápidos
- ✅ Fácil manter
- ✅ Cobertura de lógica de negócio
- ✅ Feedback rápido

#### Negativas
- ⚠️ Menos confiança em integração completa
- ⚠️ Pode não pegar bugs de integração

#### Mitigações
- Testes de integração cobrem APIs
- E2E para fluxos críticos (login, criar cliente)
- QA manual complementar

---

## ADR-013: Sem Background Jobs no MVP

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
Sistema de alertas automáticos requer background jobs. Adicionar complexidade.

### Decisão
Sistema de alertas será manual inicialmente. Background jobs serão adicionados depois.

### Consequências

#### Positivas
- ✅ MVP mais simples
- ✅ Deploy mais fácil
- ✅ Menos infraestrutura

#### Negativas
- ⚠️ Usuário precisa verificar manualmente
- ⚠️ Menos valor no MVP

#### Mitigações
- Dashboard mostra claramente o que precisa atenção
- Background jobs são prioridade pós-MVP
- Considerar serviços externos (Zapier, Make) como alternativa

---

## ADR-014: React Hook Form para Formulários

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto + Frontend Dev

### Contexto
Precisamos de biblioteca para formulários. Opções:
- Formik (popular, mas pode causar re-renders)
- React Hook Form (performático, menos re-renders)
- Controlled components nativos (muito código)

### Decisão
Usar React Hook Form com Zod para validação.

### Consequências

#### Positivas
- ✅ Performance melhor (menos re-renders)
- ✅ Validação integrada com Zod
- ✅ TypeScript first
- ✅ Menos código boilerplate

#### Negativas
- ⚠️ Curva de aprendizado inicial
- ⚠️ Mais uma dependência

#### Mitigações
- Documentação boa
- Padrões estabelecidos
- Reutilização de schemas

---

## ADR-015: Vite ao invés de Create React App

**Status**: Aceito  
**Data**: 2024-01-XX  
**Autor**: Arquiteto

### Contexto
CRA está depreciado. Precisamos de build tool moderno.

### Decisão
Usar Vite para desenvolvimento e build.

### Consequências

#### Positivas
- ✅ Dev server muito rápido
- ✅ HMR instantâneo
- ✅ Build otimizado
- ✅ Suporte TypeScript nativo

#### Negativas
- ⚠️ Configuração diferente do CRA
- ⚠️ Alguns plugins podem não funcionar

#### Mitigações
- Vite é o padrão atual
- Documentação completa
- Comunidade grande

---

## Resumo das Decisões

| ADR | Tópico | Status | Impacto |
|-----|--------|--------|---------|
| ADR-001 | Clean Architecture | Aceito | Alto |
| ADR-002 | TypeScript | Aceito | Alto |
| ADR-003 | Fastify | Aceito | Médio |
| ADR-004 | Knex.js | Aceito | Médio |
| ADR-005 | PostgreSQL | Aceito | Alto |
| ADR-006 | Repository Pattern | Aceito | Médio |
| ADR-007 | JWT | Aceito | Médio |
| ADR-008 | Shadcn/ui | Aceito | Médio |
| ADR-009 | Neon | Aceito | Médio |
| ADR-010 | Deploy Separado | Aceito | Baixo |
| ADR-011 | Sem Cache MVP | Aceito | Baixo |
| ADR-012 | Testes Unitários | Aceito | Médio |
| ADR-013 | Sem Background Jobs | Aceito | Baixo |
| ADR-014 | React Hook Form | Aceito | Baixo |
| ADR-015 | Vite | Aceito | Baixo |

---

## Decisões Futuras (A Revisar)

### ADR-016: Sistema de Cache (Futuro)
- Quando: Após MVP, se performance for problema
- Opções: Redis, Memory Cache, Database Query Cache

### ADR-017: Background Jobs (Futuro)
- Quando: Para alertas automáticos
- Opções: Bull Queue, node-cron, serviços externos

### ADR-018: Refresh Tokens (Futuro)
- Quando: Para melhorar segurança de autenticação
- Impacto: Adicionar endpoint /refresh e lógica de renovação

### ADR-019: WebSockets (Futuro)
- Quando: Para atualizações em tempo real
- Uso: Notificações, atualizações de status

