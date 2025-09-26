# Script para Iniciar um Workflow
# Inicia um workflow específico com os agentes necessários

param(
    [Parameter(Mandatory=$true)]
    [string]$WorkflowName,
    [string]$ProjectPath = "."
)

# Lista de workflows disponíveis
$availableWorkflows = @{
    "complete-development" = "Desenvolvimento Completo"
    "feature-development" = "Desenvolvimento de Feature"
    "bug-fixing" = "Correção de Bugs"
    "code-review" = "Code Review"
}

# Verificar se o workflow existe
if (!$availableWorkflows.ContainsKey($WorkflowName)) {
    Write-Host "❌ Workflow '$WorkflowName' não encontrado!" -ForegroundColor Red
    Write-Host "Workflows disponíveis:" -ForegroundColor Yellow
    foreach ($workflow in $availableWorkflows.GetEnumerator()) {
        Write-Host "  - $($workflow.Key): $($workflow.Value)" -ForegroundColor Cyan
    }
    exit 1
}

Write-Host "🔄 Iniciando workflow: $($availableWorkflows[$WorkflowName])" -ForegroundColor Green

# Carregar configuração do workflow
$workflowPath = Join-Path $PSScriptRoot "..\workflows\$WorkflowName.json"
if (Test-Path $workflowPath) {
    $workflow = Get-Content $workflowPath | ConvertFrom-Json
    Write-Host "✅ Configuração do workflow carregada" -ForegroundColor Yellow
    
    # Exibir informações do workflow
    Write-Host "`n📋 Informações do Workflow:" -ForegroundColor Cyan
    Write-Host "Nome: $($workflow.workflow.name)" -ForegroundColor White
    Write-Host "Descrição: $($workflow.workflow.description)" -ForegroundColor White
    
    # Exibir fases do workflow
    Write-Host "`n📅 Fases do Workflow:" -ForegroundColor Cyan
    foreach ($phase in $workflow.workflow.phases) {
        Write-Host "`n🔹 $($phase.phase)" -ForegroundColor Yellow
        Write-Host "   Agentes: $($phase.agents -join ', ')" -ForegroundColor White
        Write-Host "   Duração: $($phase.duration)" -ForegroundColor White
        Write-Host "   Atividades:" -ForegroundColor White
        foreach ($activity in $phase.activities) {
            Write-Host "     - $activity" -ForegroundColor Gray
        }
        Write-Host "   Outputs:" -ForegroundColor White
        foreach ($output in $phase.outputs) {
            Write-Host "     - $output" -ForegroundColor Gray
        }
    }
    
    # Exibir matriz de colaboração
    if ($workflow.workflow.collaboration_matrix) {
        Write-Host "`n🤝 Matriz de Colaboração:" -ForegroundColor Cyan
        foreach ($agent in $workflow.workflow.collaboration_matrix.PSObject.Properties) {
            Write-Host "  $($agent.Name): $($agent.Value -join ', ')" -ForegroundColor White
        }
    }
    
    # Criar arquivo de contexto do workflow ativo
    $activeWorkflowPath = Join-Path $ProjectPath ".active-workflow"
    $activeWorkflowInfo = @{
        workflow = $WorkflowName
        name = $workflow.workflow.name
        started_at = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        current_phase = 0
        total_phases = $workflow.workflow.phases.Count
        workflow_path = $workflowPath
    } | ConvertTo-Json -Depth 2
    
    $activeWorkflowInfo | Out-File -FilePath $activeWorkflowPath -Encoding UTF8
    
    Write-Host "`n✅ Workflow iniciado com sucesso!" -ForegroundColor Green
    Write-Host "Contexto salvo em: .active-workflow" -ForegroundColor Yellow
    
    # Sugerir próximos passos
    $firstPhase = $workflow.workflow.phases[0]
    Write-Host "`n🚀 Próximos Passos:" -ForegroundColor Cyan
    Write-Host "1. Ative os agentes da primeira fase: $($firstPhase.agents -join ', ')" -ForegroundColor White
    Write-Host "2. Use: ./scripts/activate-agent.ps1 [agent-name]" -ForegroundColor White
    Write-Host "3. Siga as atividades da fase: $($firstPhase.phase)" -ForegroundColor White
    
} else {
    Write-Host "❌ Arquivo de workflow não encontrado: $workflowPath" -ForegroundColor Red
    exit 1
}
