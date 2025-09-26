# Script para Listar Agentes Disponíveis
# Mostra todos os agentes disponíveis e suas informações

param(
    [string]$ProjectPath = "."
)

Write-Host "🤖 Agentes Disponíveis no Molde" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Green

# Lista de agentes com suas informações
$agents = @(
    @{
        key = "product-owner"
        name = "Product Owner"
        description = "Define requisitos e prioridades do produto"
        expertise = @("Análise de requisitos", "Gestão de backlog", "User stories")
    },
    @{
        key = "architect"
        name = "Arquiteto de Software"
        description = "Projeta arquitetura e estrutura do sistema"
        expertise = @("Design de arquitetura", "Padrões de design", "Escalabilidade")
    },
    @{
        key = "frontend-dev"
        name = "Desenvolvedor Frontend"
        description = "Implementa interface do usuário"
        expertise = @("React/Vue/Angular", "HTML/CSS/JS", "Responsive design")
    },
    @{
        key = "backend-dev"
        name = "Desenvolvedor Backend"
        description = "Desenvolve APIs e lógica de negócio"
        expertise = @("API development", "Database design", "Business logic")
    },
    @{
        key = "devops"
        name = "Profissional DevOps"
        description = "Gerencia infraestrutura e deploy"
        expertise = @("CI/CD", "Docker/Kubernetes", "Cloud platforms")
    },
    @{
        key = "tester"
        name = "Tester"
        description = "Executa testes e garante qualidade"
        expertise = @("Testes unitários", "Testes de integração", "Automação")
    },
    @{
        key = "ux"
        name = "UX Designer"
        description = "Foca na experiência do usuário"
        expertise = @("User research", "Wireframing", "Usability testing")
    }
)

foreach ($agent in $agents) {
    Write-Host "`n🔹 $($agent.name)" -ForegroundColor Yellow
    Write-Host "   Chave: $($agent.key)" -ForegroundColor Cyan
    Write-Host "   Descrição: $($agent.description)" -ForegroundColor White
    Write-Host "   Expertise: $($agent.expertise -join ', ')" -ForegroundColor Gray
    Write-Host "   Comando: ./scripts/activate-agent.ps1 $($agent.key)" -ForegroundColor Green
}

Write-Host "`n📋 Workflows Disponíveis:" -ForegroundColor Cyan
$workflows = @(
    @{ key = "complete-development"; name = "Desenvolvimento Completo" },
    @{ key = "feature-development"; name = "Desenvolvimento de Feature" },
    @{ key = "bug-fixing"; name = "Correção de Bugs" },
    @{ key = "code-review"; name = "Code Review" }
)

foreach ($workflow in $workflows) {
    Write-Host "  - $($workflow.key): $($workflow.name)" -ForegroundColor White
}

Write-Host "`n🚀 Como Usar:" -ForegroundColor Cyan
Write-Host "1. Ativar um agente: ./scripts/activate-agent.ps1 [agent-name]" -ForegroundColor White
Write-Host "2. Iniciar workflow: ./scripts/start-workflow.ps1 [workflow-name]" -ForegroundColor White
Write-Host "3. Ver ajuda: ./scripts/help.ps1" -ForegroundColor White

# Verificar se há agente ativo
$activeAgentPath = Join-Path $ProjectPath ".active-agent"
if (Test-Path $activeAgentPath) {
    $activeAgent = Get-Content $activeAgentPath | ConvertFrom-Json
    Write-Host "`n✅ Agente Ativo: $($activeAgent.name)" -ForegroundColor Green
    Write-Host "   Ativado em: $($activeAgent.activated_at)" -ForegroundColor Gray
}

# Verificar se há workflow ativo
$activeWorkflowPath = Join-Path $ProjectPath ".active-workflow"
if (Test-Path $activeWorkflowPath) {
    $activeWorkflow = Get-Content $activeWorkflowPath | ConvertFrom-Json
    Write-Host "`n🔄 Workflow Ativo: $($activeWorkflow.name)" -ForegroundColor Green
    Write-Host "   Iniciado em: $($activeWorkflow.started_at)" -ForegroundColor Gray
    Write-Host "   Fase atual: $($activeWorkflow.current_phase + 1)/$($activeWorkflow.total_phases)" -ForegroundColor Gray
}
