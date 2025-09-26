# 🤖 Molde de Equipe de Agentes para Desenvolvimento de Software

Este molde automatiza o processo de desenvolvimento de software usando uma equipe de agentes especializados no Cursor AI. Cada agente assume um papel específico no desenvolvimento, permitindo um fluxo de trabalho estruturado e eficiente.

## 🎯 Visão Geral

O molde simula uma equipe de desenvolvimento completa com 7 agentes especializados:

- **Product Owner**: Define requisitos e prioridades do produto
- **Arquiteto de Software**: Projeta a arquitetura e estrutura do sistema
- **Desenvolvedor Frontend**: Implementa a interface do usuário
- **Desenvolvedor Backend**: Desenvolve APIs e lógica de negócio
- **Profissional DevOps**: Gerencia infraestrutura e deploy
- **Tester**: Executa testes e garante qualidade
- **UX Designer**: Foca na experiência do usuário

## 📁 Estrutura do Projeto

```
agent-team-template/
├── agents/                    # Configurações dos agentes
│   ├── product-owner/
│   ├── architect/
│   ├── frontend-dev/
│   ├── backend-dev/
│   ├── devops/
│   ├── tester/
│   └── ux/
├── workflows/                 # Fluxos de trabalho
│   ├── complete-development.json
│   ├── feature-development.json
│   ├── bug-fixing.json
│   └── code-review.json
├── templates/                 # Templates de prompts
│   ├── product-owner-prompt.md
│   ├── architect-prompt.md
│   ├── frontend-dev-prompt.md
│   ├── backend-dev-prompt.md
│   ├── devops-prompt.md
│   ├── tester-prompt.md
│   └── ux-prompt.md
├── scripts/                   # Scripts de automação
│   ├── setup.ps1
│   ├── activate-agent.ps1
│   ├── start-workflow.ps1
│   ├── list-agents.ps1
│   └── help.ps1
└── docs/                      # Documentação
```

## 🚀 Como Usar

### 1. Configuração Inicial

```powershell
# Clone ou copie o molde para seu projeto
./scripts/setup.ps1 -ProjectName "MeuProjeto"
```

### 2. Ativar um Agente

```powershell
# Ativar Product Owner
./scripts/activate-agent.ps1 product-owner

# Ativar Arquiteto
./scripts/activate-agent.ps1 architect

# Ativar Desenvolvedor Frontend
./scripts/activate-agent.ps1 frontend-dev
```

### 3. Iniciar um Workflow

```powershell
# Desenvolvimento completo
./scripts/start-workflow.ps1 complete-development

# Desenvolvimento de feature
./scripts/start-workflow.ps1 feature-development

# Correção de bugs
./scripts/start-workflow.ps1 bug-fixing
```

### 4. Listar Agentes Disponíveis

```powershell
./scripts/list-agents.ps1
```

## 🤖 Agentes Detalhados

### Product Owner
- **Responsabilidades**: Análise de requisitos, criação de user stories, priorização de backlog
- **Expertise**: Gestão de produto, comunicação com stakeholders, definição de critérios de aceitação
- **Colabora com**: UX, Arquiteto, Tester

### Arquiteto de Software
- **Responsabilidades**: Design de arquitetura, escolha de tecnologias, definição de padrões
- **Expertise**: Arquitetura de sistemas, padrões de design, escalabilidade, segurança
- **Colabora com**: Product Owner, DevOps, Desenvolvedores

### Desenvolvedor Frontend
- **Responsabilidades**: Implementação de interface, componentes reutilizáveis, responsividade
- **Expertise**: React/Vue/Angular, HTML/CSS/JavaScript, performance, acessibilidade
- **Colabora com**: UX, Backend Dev, Tester

### Desenvolvedor Backend
- **Responsabilidades**: APIs, lógica de negócio, banco de dados, autenticação
- **Expertise**: API development, database design, microservices, performance
- **Colabora com**: Arquiteto, Frontend Dev, DevOps, Tester

### Profissional DevOps
- **Responsabilidades**: CI/CD, infraestrutura, deploy, monitoramento
- **Expertise**: Docker/Kubernetes, cloud platforms, automação, segurança
- **Colabora com**: Arquiteto, Desenvolvedores, Tester

### Tester
- **Responsabilidades**: Testes automatizados, qualidade, validação de requisitos
- **Expertise**: Testes unitários, integração, performance, automação
- **Colabora com**: Product Owner, Desenvolvedores, DevOps

### UX Designer
- **Responsabilidades**: Pesquisa de usuário, wireframes, protótipos, usabilidade
- **Expertise**: User research, design thinking, prototipação, testes de usabilidade
- **Colabora com**: Product Owner, Frontend Dev

## 🔄 Workflows Disponíveis

### 1. Desenvolvimento Completo
**Duração**: 6-8 semanas
**Fases**:
1. Planejamento e Análise (Product Owner + UX)
2. Arquitetura e Design (Arquiteto + UX)
3. Desenvolvimento (Frontend + Backend)
4. Testes e Qualidade (Tester + Desenvolvedores)
5. Deploy e Operação (DevOps + Tester)

### 2. Desenvolvimento de Feature
**Duração**: 1-2 semanas
**Fases**:
1. Análise da Feature (Product Owner + UX)
2. Planejamento Técnico (Arquiteto + Desenvolvedores)
3. Implementação (Frontend + Backend)
4. Testes e Validação (Tester + UX)
5. Deploy (DevOps + Tester)

### 3. Correção de Bugs
**Duração**: 1-2 dias
**Fases**:
1. Triagem e Análise (Tester + Product Owner)
2. Investigação Técnica (Desenvolvedores + Arquiteto)
3. Implementação da Correção (Desenvolvedores)
4. Testes e Validação (Tester + Desenvolvedores)
5. Deploy da Correção (DevOps + Tester)

### 4. Code Review
**Duração**: 1-2 horas
**Fases**:
1. Análise Automática (Arquiteto + Tester)
2. Revisão Técnica (Arquiteto + Desenvolvedores)
3. Revisão de Funcionalidade (Tester + Product Owner)
4. Revisão de UX/UI (UX + Frontend Dev)
5. Aprovação e Merge (Arquiteto + DevOps)

## 📝 Templates de Prompts

Cada agente possui templates de prompts específicos em `templates/`:

- **product-owner-prompt.md**: Templates para análise de requisitos e user stories
- **architect-prompt.md**: Templates para design de arquitetura e escolha de tecnologias
- **frontend-dev-prompt.md**: Templates para implementação de componentes e otimização
- **backend-dev-prompt.md**: Templates para desenvolvimento de APIs e lógica de negócio
- **devops-prompt.md**: Templates para configuração de infraestrutura e deploy
- **tester-prompt.md**: Templates para criação de planos de teste e automação
- **ux-prompt.md**: Templates para pesquisa de usuário e design de interface

## 🛠️ Scripts de Automação

### setup.ps1
Configura o ambiente inicial do projeto:
```powershell
./scripts/setup.ps1 -ProjectName "MeuProjeto"
```

### activate-agent.ps1
Ativa um agente específico:
```powershell
./scripts/activate-agent.ps1 product-owner
```

### start-workflow.ps1
Inicia um workflow específico:
```powershell
./scripts/start-workflow.ps1 complete-development
```

### list-agents.ps1
Lista todos os agentes disponíveis:
```powershell
./scripts/list-agents.ps1
```

### help.ps1
Mostra ajuda completa:
```powershell
./scripts/help.ps1
```

## 💡 Exemplos de Uso

### Exemplo 1: Desenvolvimento de E-commerce

1. **Iniciar workflow completo**:
   ```powershell
   ./scripts/start-workflow.ps1 complete-development
   ```

2. **Ativar Product Owner**:
   ```powershell
   ./scripts/activate-agent.ps1 product-owner
   ```
   - Definir requisitos do e-commerce
   - Criar user stories para compra, carrinho, checkout
   - Priorizar funcionalidades

3. **Ativar Arquiteto**:
   ```powershell
   ./scripts/activate-agent.ps1 architect
   ```
   - Projetar arquitetura do sistema
   - Escolher stack tecnológica
   - Definir padrões de desenvolvimento

4. **Continuar com outros agentes conforme necessário**

### Exemplo 2: Correção de Bug Crítico

1. **Iniciar workflow de bug fixing**:
   ```powershell
   ./scripts/start-workflow.ps1 bug-fixing
   ```

2. **Ativar Tester**:
   ```powershell
   ./scripts/activate-agent.ps1 tester
   ```
   - Reproduzir o bug
   - Analisar impacto
   - Priorizar correção

3. **Ativar Desenvolvedor**:
   ```powershell
   ./scripts/activate-agent.ps1 backend-dev
   ```
   - Investigar causa raiz
   - Implementar correção
   - Testar localmente

## 🎯 Benefícios

- **Estruturação**: Processo de desenvolvimento organizado e previsível
- **Especialização**: Cada agente foca em sua área de expertise
- **Colaboração**: Workflows definem como os agentes trabalham juntos
- **Automação**: Scripts facilitam o uso e gerenciamento
- **Flexibilidade**: Pode ser usado para projetos de qualquer tamanho
- **Documentação**: Templates e guias facilitam o aprendizado

## 🔧 Personalização

O molde pode ser personalizado:

1. **Adicionar novos agentes**: Crie configurações em `agents/`
2. **Modificar workflows**: Edite arquivos em `workflows/`
3. **Criar templates customizados**: Adicione em `templates/`
4. **Estender scripts**: Modifique ou crie novos em `scripts/`

## 📚 Documentação Adicional

- **Templates de Prompts**: Guias detalhados para cada agente
- **Workflows**: Fluxos de trabalho estruturados
- **Configurações**: Especificações técnicas de cada agente
- **Exemplos**: Casos de uso práticos

## 🤝 Contribuição

Para contribuir com o molde:

1. Identifique melhorias nos agentes existentes
2. Proponha novos workflows
3. Crie templates adicionais
4. Melhore a documentação
5. Adicione novos scripts de automação

## 📄 Licença

Este molde é fornecido como template livre para uso em projetos de desenvolvimento de software.
