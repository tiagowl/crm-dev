# 🚀 Guia de Início Rápido

Este guia te ajudará a começar a usar o molde de agentes em poucos minutos.

## ⚡ Configuração em 3 Passos

### 1. Configuração Inicial
```powershell
# Execute o script de configuração
./scripts/setup.ps1 -ProjectName "MeuProjeto"
```

### 2. Ver Agentes Disponíveis
```powershell
# Liste todos os agentes
./scripts/list-agents.ps1
```

### 3. Ativar seu Primeiro Agente
```powershell
# Ative o Product Owner para começar
./scripts/activate-agent.ps1 product-owner
```

## 🎯 Cenários Comuns

### Cenário 1: Novo Projeto
```powershell
# 1. Configurar projeto
./scripts/setup.ps1 -ProjectName "MeuApp"

# 2. Iniciar desenvolvimento completo
./scripts/start-workflow.ps1 complete-development

# 3. Começar com Product Owner
./scripts/activate-agent.ps1 product-owner
```

### Cenário 2: Nova Feature
```powershell
# 1. Iniciar workflow de feature
./scripts/start-workflow.ps1 feature-development

# 2. Ativar Product Owner para definir requisitos
./scripts/activate-agent.ps1 product-owner
```

### Cenário 3: Correção de Bug
```powershell
# 1. Iniciar workflow de bug fixing
./scripts/start-workflow.ps1 bug-fixing

# 2. Ativar Tester para analisar
./scripts/activate-agent.ps1 tester
```

## 🔄 Fluxo Típico de Desenvolvimento

1. **Product Owner** → Define requisitos e user stories
2. **UX Designer** → Cria wireframes e protótipos
3. **Arquiteto** → Projeta arquitetura e escolhe tecnologias
4. **Desenvolvedores** → Implementam frontend e backend
5. **Tester** → Executa testes e valida qualidade
6. **DevOps** → Configura deploy e monitoramento

## 💡 Dicas Rápidas

- **Use workflows** para processos estruturados
- **Ative agentes** conforme a necessidade
- **Siga os templates** para prompts eficazes
- **Colabore** entre agentes nos workflows
- **Documente** decisões e outputs

## ❓ Precisa de Ajuda?

```powershell
# Ver ajuda completa
./scripts/help.ps1

# Listar agentes
./scripts/list-agents.ps1

# Ver agente ativo
Get-Content .active-agent
```
