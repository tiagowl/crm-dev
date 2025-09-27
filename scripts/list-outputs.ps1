# Script para Listar Outputs dos Agentes
# Lista todos os outputs salvos de forma organizada

param(
    [string]$AgentName = "",
    [string]$ProjectPath = "."
)

$outputsPath = Join-Path $ProjectPath "outputs"

if (!(Test-Path $outputsPath)) {
    Write-Host "Pasta outputs nao encontrada!" -ForegroundColor Red
    Write-Host "Execute primeiro: ./scripts/save-output.ps1 [agent] [content]" -ForegroundColor Yellow
    exit 1
}

Write-Host "Outputs dos Agentes" -ForegroundColor Green
Write-Host "=" * 50 -ForegroundColor Green

if ($AgentName) {
    # Listar outputs de um agente especifico
    $agentPath = Join-Path $outputsPath $AgentName
    if (Test-Path $agentPath) {
        Write-Host "`nAgente: $AgentName" -ForegroundColor Cyan
        $outputFiles = Get-ChildItem -Path $agentPath -Filter "*.md" | Sort-Object LastWriteTime -Descending
        
        if ($outputFiles.Count -gt 0) {
            foreach ($file in $outputFiles) {
                $size = [math]::Round($file.Length / 1KB, 2)
                Write-Host "  - $($file.Name) ($size KB) - $($file.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss'))" -ForegroundColor White
            }
        } else {
            Write-Host "  Nenhum output encontrado" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Agente '$AgentName' nao encontrado!" -ForegroundColor Red
    }
} else {
    # Listar todos os agentes
    $agents = Get-ChildItem -Path $outputsPath -Directory
    
    if ($agents.Count -gt 0) {
        foreach ($agent in $agents) {
            Write-Host "`nAgente: $($agent.Name)" -ForegroundColor Cyan
            $outputFiles = Get-ChildItem -Path $agent.FullName -Filter "*.md" | Sort-Object LastWriteTime -Descending
            
            if ($outputFiles.Count -gt 0) {
                Write-Host "  Outputs: $($outputFiles.Count)" -ForegroundColor White
                foreach ($file in $outputFiles | Select-Object -First 3) {
                    $size = [math]::Round($file.Length / 1KB, 2)
                    Write-Host "    - $($file.Name) ($size KB)" -ForegroundColor Gray
                }
                if ($outputFiles.Count -gt 3) {
                    Write-Host "    ... e mais $($outputFiles.Count - 3) arquivos" -ForegroundColor Gray
                }
            } else {
                Write-Host "  Nenhum output encontrado" -ForegroundColor Yellow
            }
        }
    } else {
        Write-Host "Nenhum output encontrado!" -ForegroundColor Yellow
        Write-Host "Execute: ./scripts/save-output.ps1 [agent] [content]" -ForegroundColor Cyan
    }
}

Write-Host "`nComandos disponiveis:" -ForegroundColor Cyan
Write-Host "  ./scripts/save-output.ps1 [agent] [content] [filename]" -ForegroundColor White
Write-Host "  ./scripts/list-outputs.ps1 [agent]" -ForegroundColor White
Write-Host "  Get-Content outputs/[agent]/latest-[filename]" -ForegroundColor White
