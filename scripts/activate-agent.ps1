# Script para Ativar um Agente Específico
# Ativa um agente e carrega sua configuração

param(
    [Parameter(Mandatory=$true)]
    [string]$AgentName,
    [string]$ProjectPath = "."
)

# Lista de agentes disponíveis
$availableAgents = @{
    "product-owner" = "Product Owner"
    "architect" = "Arquiteto de Software"
    "frontend-dev" = "Desenvolvedor Frontend"
    "backend-dev" = "Desenvolvedor Backend"
    "devops" = "Profissional DevOps"
    "tester" = "Tester"
    "ux" = "UX Designer"
}

# Verificar se o agente existe
if (!$availableAgents.ContainsKey($AgentName)) {
    Write-Host "❌ Agente '$AgentName' não encontrado!" -ForegroundColor Red
    Write-Host "Agentes disponíveis:" -ForegroundColor Yellow
    foreach ($agent in $availableAgents.GetEnumerator()) {
        Write-Host "  - $($agent.Key): $($agent.Value)" -ForegroundColor Cyan
    }
    exit 1
}

Write-Host "🤖 Ativando agente: $($availableAgents[$AgentName])" -ForegroundColor Green

# Carregar configuração do agente
$configPath = Join-Path $PSScriptRoot "..\agents\$AgentName\config.json"
if (Test-Path $configPath) {
    $config = Get-Content $configPath | ConvertFrom-Json
    Write-Host "✅ Configuração carregada" -ForegroundColor Yellow
    
    # Exibir informações do agente
    Write-Host "`n📋 Informações do Agente:" -ForegroundColor Cyan
    Write-Host "Nome: $($config.agent.name)" -ForegroundColor White
    Write-Host "Descrição: $($config.agent.description)" -ForegroundColor White
    Write-Host "Expertise: $($config.agent.expertise -join ', ')" -ForegroundColor White
    
    # Exibir workflow steps
    Write-Host "`n🔄 Workflow Steps:" -ForegroundColor Cyan
    foreach ($step in $config.agent.workflow_steps) {
        Write-Host "  $step" -ForegroundColor White
    }
    
    # Exibir outputs esperados
    Write-Host "`n📤 Outputs Esperados:" -ForegroundColor Cyan
    foreach ($output in $config.agent.outputs) {
        Write-Host "  - $output" -ForegroundColor White
    }
    
    # Exibir colaborações
    Write-Host "`n🤝 Colaborações:" -ForegroundColor Cyan
    Write-Host "Trabalha com: $($config.agent.collaboration.works_with -join ', ')" -ForegroundColor White
    Write-Host "Recebe de: $($config.agent.collaboration.receives_from -join ', ')" -ForegroundColor White
    Write-Host "Fornece para: $($config.agent.collaboration.provides_to -join ', ')" -ForegroundColor White
    
} else {
    Write-Host "❌ Arquivo de configuração não encontrado: $configPath" -ForegroundColor Red
    exit 1
}

# Carregar template de prompt
$templatePath = Join-Path $PSScriptRoot "..\templates\$AgentName-prompt.md"
if (Test-Path $templatePath) {
    Write-Host "`n📝 Template de Prompt carregado:" -ForegroundColor Cyan
    Write-Host "Arquivo: $templatePath" -ForegroundColor Yellow
    Write-Host "`nPara usar este agente, copie o template de prompt e adapte para sua necessidade." -ForegroundColor Green
} else {
    Write-Host "⚠️ Template de prompt não encontrado: $templatePath" -ForegroundColor Yellow
}

# Criar arquivo de contexto do agente ativo
$activeAgentPath = Join-Path $ProjectPath ".active-agent"
$activeAgentInfo = @{
    agent = $AgentName
    name = $config.agent.name
    activated_at = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    config_path = $configPath
    template_path = $templatePath
} | ConvertTo-Json -Depth 2

$activeAgentInfo | Out-File -FilePath $activeAgentPath -Encoding UTF8

Write-Host "`n✅ Agente ativado com sucesso!" -ForegroundColor Green
Write-Host "Contexto salvo em: .active-agent" -ForegroundColor Yellow
Write-Host "`n💡 Dica: Use o template de prompt para começar a trabalhar com este agente." -ForegroundColor Cyan
