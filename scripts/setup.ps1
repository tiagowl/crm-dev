# Script de Configuração do Molde de Agentes
# Configura o ambiente para usar o molde de agentes

param(
    [string]$ProjectName = "MeuProjeto",
    [string]$ProjectPath = "."
)

Write-Host "🚀 Configurando Molde de Agentes para: $ProjectName" -ForegroundColor Green

# Criar estrutura de diretórios do projeto
$projectDirs = @(
    "docs",
    "src/frontend",
    "src/backend", 
    "tests",
    "deploy",
    "monitoring"
)

foreach ($dir in $projectDirs) {
    $fullPath = Join-Path $ProjectPath $dir
    if (!(Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        Write-Host "✅ Criado diretório: $dir" -ForegroundColor Yellow
    }
}

# Copiar arquivos de configuração
$configFiles = @(
    "agents/product-owner/config.json",
    "agents/architect/config.json", 
    "agents/frontend-dev/config.json",
    "agents/backend-dev/config.json",
    "agents/devops/config.json",
    "agents/tester/config.json",
    "agents/ux/config.json"
)

foreach ($configFile in $configFiles) {
    $sourcePath = Join-Path $PSScriptRoot "..\$configFile"
    $destPath = Join-Path $ProjectPath "agent-configs"
    
    if (!(Test-Path $destPath)) {
        New-Item -ItemType Directory -Path $destPath -Force | Out-Null
    }
    
    if (Test-Path $sourcePath) {
        Copy-Item $sourcePath $destPath -Force
        Write-Host "✅ Copiado: $configFile" -ForegroundColor Yellow
    }
}

# Criar arquivo de configuração do projeto
$projectConfig = @{
    project = @{
        name = $ProjectName
        created = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        agents = @(
            "product-owner",
            "architect", 
            "frontend-dev",
            "backend-dev",
            "devops",
            "tester",
            "ux"
        )
        workflows = @(
            "complete-development",
            "feature-development", 
            "bug-fixing",
            "code-review"
        )
    }
} | ConvertTo-Json -Depth 3

$projectConfigPath = Join-Path $ProjectPath "agent-project.json"
$projectConfig | Out-File -FilePath $projectConfigPath -Encoding UTF8

Write-Host "✅ Configuração do projeto criada: agent-project.json" -ForegroundColor Yellow

# Criar arquivo .cursorrules
$cursorRules = @"
# Configuração do Molde de Agentes

## Agentes Disponíveis
- Product Owner: Define requisitos e prioridades
- Arquiteto: Projeta arquitetura do sistema  
- Frontend Dev: Implementa interface do usuário
- Backend Dev: Desenvolve APIs e lógica de negócio
- DevOps: Gerencia infraestrutura e deploy
- Tester: Executa testes e garante qualidade
- UX: Foca na experiência do usuário

## Como Usar
1. Use o comando: ./scripts/activate-agent.ps1 [agent-name]
2. Siga os templates em templates/
3. Use os workflows em workflows/

## Comandos Disponíveis
- setup.ps1: Configuração inicial
- activate-agent.ps1: Ativar um agente específico
- start-workflow.ps1: Iniciar um workflow
- list-agents.ps1: Listar agentes disponíveis
"@

$cursorRulesPath = Join-Path $ProjectPath ".cursorrules"
$cursorRules | Out-File -FilePath $cursorRulesPath -Encoding UTF8

Write-Host "✅ Arquivo .cursorrules criado" -ForegroundColor Yellow

Write-Host "`n🎉 Configuração concluída!" -ForegroundColor Green
Write-Host "Para começar, use: ./scripts/activate-agent.ps1 [agent-name]" -ForegroundColor Cyan
