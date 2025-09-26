# 📚 Exemplos Práticos de Uso

Este documento apresenta exemplos práticos de como usar o molde de agentes em diferentes cenários.

## 🛒 Exemplo 1: E-commerce Completo

### Cenário
Desenvolver uma plataforma de e-commerce com funcionalidades de catálogo, carrinho, checkout e painel administrativo.

### Workflow: Desenvolvimento Completo

#### Fase 1: Planejamento e Análise (1-2 semanas)

**Ativar Product Owner:**
```powershell
./scripts/activate-agent.ps1 product-owner
```

**Prompt para Product Owner:**
```
Como Product Owner, preciso que você analise os requisitos para uma plataforma de e-commerce e crie:

1. User stories para:
   - Catálogo de produtos
   - Carrinho de compras
   - Processo de checkout
   - Painel administrativo
   - Gestão de usuários

2. Priorize as funcionalidades considerando:
   - MVP (produto mínimo viável)
   - Funcionalidades essenciais
   - Diferenciação competitiva

3. Defina critérios de aceitação para cada user story
```

**Ativar UX Designer:**
```powershell
./scripts/activate-agent.ps1 ux
```

**Prompt para UX Designer:**
```
Como UX Designer, preciso que você:

1. Realize pesquisa de usuário para e-commerce
2. Crie personas de compradores e vendedores
3. Mapeie jornada do usuário para compra
4. Desenvolva wireframes para:
   - Página inicial
   - Catálogo de produtos
   - Carrinho de compras
   - Checkout
   - Painel administrativo
```

#### Fase 2: Arquitetura e Design (1 semana)

**Ativar Arquiteto:**
```powershell
./scripts/activate-agent.ps1 architect
```

**Prompt para Arquiteto:**
```
Como Arquiteto de Software, preciso que você projete a arquitetura para um e-commerce com:

1. Requisitos técnicos:
   - 10.000+ produtos
   - 1.000+ usuários simultâneos
   - Integração com gateway de pagamento
   - Sistema de notificações
   - Painel administrativo

2. Defina:
   - Arquitetura geral (microserviços vs monolito)
   - Stack tecnológica
   - Estrutura do banco de dados
   - Integrações necessárias
   - Estratégia de cache
```

#### Fase 3: Desenvolvimento (3-4 semanas)

**Ativar Backend Developer:**
```powershell
./scripts/activate-agent.ps1 backend-dev
```

**Prompt para Backend Developer:**
```
Como Desenvolvedor Backend, preciso que você implemente as APIs para e-commerce:

1. APIs necessárias:
   - Gestão de produtos
   - Carrinho de compras
   - Processo de checkout
   - Gestão de usuários
   - Painel administrativo

2. Implemente:
   - Autenticação JWT
   - Validação de dados
   - Integração com gateway de pagamento
   - Sistema de notificações
   - Documentação da API
```

**Ativar Frontend Developer:**
```powershell
./scripts/activate-agent.ps1 frontend-dev
```

**Prompt para Frontend Developer:**
```
Como Desenvolvedor Frontend, preciso que você implemente a interface do e-commerce:

1. Páginas principais:
   - Página inicial
   - Catálogo de produtos
   - Página do produto
   - Carrinho de compras
   - Checkout
   - Painel administrativo

2. Implemente:
   - Componentes reutilizáveis
   - Responsividade
   - Integração com APIs
   - Otimização de performance
   - Acessibilidade
```

#### Fase 4: Testes e Qualidade (1-2 semanas)

**Ativar Tester:**
```powershell
./scripts/activate-agent.ps1 tester
```

**Prompt para Tester:**
```
Como Tester, preciso que você crie um plano de testes para o e-commerce:

1. Testes funcionais:
   - Navegação do catálogo
   - Adição ao carrinho
   - Processo de checkout
   - Gestão de usuários
   - Painel administrativo

2. Testes não-funcionais:
   - Performance com muitos produtos
   - Segurança de pagamentos
   - Usabilidade em diferentes dispositivos
   - Acessibilidade

3. Implemente testes automatizados
```

#### Fase 5: Deploy e Operação (1 semana)

**Ativar DevOps:**
```powershell
./scripts/activate-agent.ps1 devops
```

**Prompt para DevOps:**
```
Como Profissional DevOps, preciso que você configure o ambiente para o e-commerce:

1. Configuração de ambiente:
   - Docker containers
   - CI/CD pipeline
   - Ambiente de staging
   - Ambiente de produção

2. Monitoramento:
   - Logs centralizados
   - Métricas de performance
   - Alertas automáticos
   - Backup automatizado

3. Segurança:
   - SSL/TLS
   - Firewall
   - Secrets management
```

## 🐛 Exemplo 2: Correção de Bug Crítico

### Cenário
Bug crítico no sistema de pagamento que está causando falhas nas transações.

### Workflow: Bug Fixing

#### Fase 1: Triagem e Análise (1-2 horas)

**Ativar Tester:**
```powershell
./scripts/activate-agent.ps1 tester
```

**Prompt para Tester:**
```
Como Tester, preciso que você analise um bug crítico no sistema de pagamento:

1. Reproduza o bug:
   - Cenários de falha
   - Dados de entrada
   - Logs de erro
   - Screenshots/evidências

2. Analise o impacto:
   - Quantos usuários afetados
   - Perda financeira estimada
   - Urgência da correção

3. Documente:
   - Passos para reproduzir
   - Severidade e prioridade
   - Estimativa de correção
```

#### Fase 2: Investigação Técnica (2-4 horas)

**Ativar Backend Developer:**
```powershell
./scripts/activate-agent.ps1 backend-dev
```

**Prompt para Backend Developer:**
```
Como Desenvolvedor Backend, preciso que você investigue o bug no sistema de pagamento:

1. Analise o código:
   - Fluxo de pagamento
   - Integração com gateway
   - Tratamento de erros
   - Validações

2. Identifique:
   - Causa raiz do problema
   - Pontos de falha
   - Dependências afetadas

3. Planeje a correção:
   - Solução técnica
   - Impacto da mudança
   - Testes necessários
```

#### Fase 3: Implementação da Correção (2-8 horas)

**Continuar com Backend Developer:**
```
Implemente a correção para o bug de pagamento:

1. Implemente a correção:
   - Código da solução
   - Testes unitários
   - Validação local

2. Considere:
   - Backward compatibility
   - Performance
   - Segurança
   - Logs para debugging
```

#### Fase 4: Testes e Validação (1-2 horas)

**Ativar Tester:**
```powershell
./scripts/activate-agent.ps1 tester
```

**Prompt para Tester:**
```
Como Tester, preciso que você valide a correção do bug de pagamento:

1. Teste a correção:
   - Cenários que falhavam
   - Casos extremos
   - Testes de regressão

2. Valide:
   - Funcionalidade restaurada
   - Performance mantida
   - Segurança preservada

3. Documente:
   - Resultados dos testes
   - Aprovação da correção
```

#### Fase 5: Deploy da Correção (30 minutos - 2 horas)

**Ativar DevOps:**
```powershell
./scripts/activate-agent.ps1 devops
```

**Prompt para DevOps:**
```
Como Profissional DevOps, preciso que você faça o deploy da correção crítica:

1. Deploy da correção:
   - Ambiente de staging
   - Testes de integração
   - Deploy em produção
   - Rollback plan

2. Monitoramento:
   - Métricas de pagamento
   - Logs de erro
   - Alertas automáticos

3. Confirmação:
   - Funcionamento normal
   - Sem regressões
   - Usuários notificados
```

## 🔄 Exemplo 3: Code Review

### Cenário
Revisão de código para uma nova feature de busca avançada.

### Workflow: Code Review

#### Fase 1: Análise Automática (15-30 minutos)

**Ativar Arquiteto:**
```powershell
./scripts/activate-agent.ps1 architect
```

**Prompt para Arquiteto:**
```
Como Arquiteto, preciso que você revise o código da feature de busca avançada:

1. Análise de arquitetura:
   - Padrões de design utilizados
   - Separação de responsabilidades
   - Escalabilidade da solução

2. Análise de qualidade:
   - Legibilidade do código
   - Manutenibilidade
   - Performance
   - Segurança

3. Sugestões de melhoria
```

#### Fase 2: Revisão Técnica (30-60 minutos)

**Ativar Backend Developer:**
```powershell
./scripts/activate-agent.ps1 backend-dev
```

**Prompt para Backend Developer:**
```
Como Desenvolvedor Backend, revise a implementação da API de busca:

1. Revisão técnica:
   - Estrutura da API
   - Validação de dados
   - Tratamento de erros
   - Performance das queries

2. Boas práticas:
   - Convenções de código
   - Documentação
   - Testes
   - Logs

3. Sugestões de melhoria
```

#### Fase 3: Revisão de Funcionalidade (30-45 minutos)

**Ativar Tester:**
```powershell
./scripts/activate-agent.ps1 tester
```

**Prompt para Tester:**
```
Como Tester, revise a funcionalidade de busca avançada:

1. Validação de requisitos:
   - Critérios de aceitação
   - Casos de uso
   - Cenários extremos

2. Testes funcionais:
   - Diferentes tipos de busca
   - Filtros e ordenação
   - Performance com muitos resultados

3. Sugestões de teste
```

#### Fase 4: Revisão de UX/UI (20-30 minutos)

**Ativar UX Designer:**
```powershell
./scripts/activate-agent.ps1 ux
```

**Prompt para UX Designer:**
```
Como UX Designer, revise a interface de busca avançada:

1. Revisão de UX:
   - Usabilidade da interface
   - Fluxo de busca
   - Feedback visual
   - Acessibilidade

2. Revisão de UI:
   - Consistência visual
   - Responsividade
   - Performance de carregamento

3. Sugestões de melhoria
```

#### Fase 5: Aprovação e Merge (10-15 minutos)

**Ativar Arquiteto:**
```powershell
./scripts/activate-agent.ps1 architect
```

**Prompt para Arquiteto:**
```
Como Arquiteto, consolide o feedback da revisão de código:

1. Consolidação:
   - Resumo dos feedbacks
   - Priorização de melhorias
   - Decisões finais

2. Aprovação:
   - Critérios atendidos
   - Riscos aceitáveis
   - Pronto para merge

3. Próximos passos:
   - Implementar melhorias
   - Testes adicionais
   - Deploy
```

## 💡 Dicas para Exemplos Práticos

### 1. Adapte os Prompts
- Personalize os prompts para seu contexto específico
- Adicione detalhes relevantes ao seu projeto
- Considere restrições e requisitos específicos

### 2. Use Workflows Apropriados
- **Desenvolvimento Completo**: Para projetos novos
- **Feature Development**: Para novas funcionalidades
- **Bug Fixing**: Para correções urgentes
- **Code Review**: Para revisões de qualidade

### 3. Colabore Entre Agentes
- Use múltiplos agentes em sequência
- Mantenha contexto entre handoffs
- Documente decisões e outputs

### 4. Itere e Melhore
- Ajuste prompts baseado nos resultados
- Refine workflows conforme necessário
- Adicione novos agentes se necessário

### 5. Automatize Quando Possível
- Use scripts para ativação de agentes
- Crie templates reutilizáveis
- Documente processos bem-sucedidos
