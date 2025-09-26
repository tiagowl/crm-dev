# Script de Ajuda - Molde de Agentes
# Mostra informações de ajuda e exemplos de uso

Write-Host "🤖 Molde de Agentes para Desenvolvimento de Software" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Green

Write-Host "`n📖 Sobre:" -ForegroundColor Cyan
Write-Host "Este molde automatiza o processo de desenvolvimento usando uma equipe de agentes especializados no Cursor AI." -ForegroundColor White

Write-Host "`n🤖 Agentes Disponíveis:" -ForegroundColor Cyan
Write-Host "• Product Owner: Define requisitos e prioridades" -ForegroundColor White
Write-Host "• Arquiteto: Projeta arquitetura do sistema" -ForegroundColor White
Write-Host "• Frontend Dev: Implementa interface do usuário" -ForegroundColor White
Write-Host "• Backend Dev: Desenvolve APIs e lógica de negócio" -ForegroundColor White
Write-Host "• DevOps: Gerencia infraestrutura e deploy" -ForegroundColor White
Write-Host "• Tester: Executa testes e garante qualidade" -ForegroundColor White
Write-Host "• UX: Foca na experiência do usuário" -ForegroundColor White

Write-Host "`n🔄 Workflows Disponíveis:" -ForegroundColor Cyan
Write-Host "• complete-development: Do conceito ao deploy" -ForegroundColor White
Write-Host "• feature-development: Desenvolvimento de funcionalidades" -ForegroundColor White
Write-Host "• bug-fixing: Correção de bugs" -ForegroundColor White
Write-Host "• code-review: Revisão de código" -ForegroundColor White

Write-Host "`n🚀 Comandos Principais:" -ForegroundColor Cyan
Write-Host "`n1. Configuração Inicial:" -ForegroundColor Yellow
Write-Host "   ./scripts/setup.ps1 -ProjectName 'MeuProjeto'" -ForegroundColor Green
Write-Host "   # Configura o ambiente e cria estrutura do projeto" -ForegroundColor Gray

Write-Host "`n2. Ativar um Agente:" -ForegroundColor Yellow
Write-Host "   ./scripts/activate-agent.ps1 product-owner" -ForegroundColor Green
Write-Host "   ./scripts/activate-agent.ps1 architect" -ForegroundColor Green
Write-Host "   ./scripts/activate-agent.ps1 frontend-dev" -ForegroundColor Green
Write-Host "   # Ativa um agente específico e carrega sua configuração" -ForegroundColor Gray

Write-Host "`n3. Iniciar um Workflow:" -ForegroundColor Yellow
Write-Host "   ./scripts/start-workflow.ps1 complete-development" -ForegroundColor Green
Write-Host "   ./scripts/start-workflow.ps1 feature-development" -ForegroundColor Green
Write-Host "   # Inicia um workflow com múltiplos agentes" -ForegroundColor Gray

Write-Host "`n4. Listar Agentes:" -ForegroundColor Yellow
Write-Host "   ./scripts/list-agents.ps1" -ForegroundColor Green
Write-Host "   # Mostra todos os agentes disponíveis" -ForegroundColor Gray

Write-Host "`n5. Ver Ajuda:" -ForegroundColor Yellow
Write-Host "   ./scripts/help.ps1" -ForegroundColor Green
Write-Host "   # Mostra esta tela de ajuda" -ForegroundColor Gray

Write-Host "`n💡 Exemplos de Uso:" -ForegroundColor Cyan

Write-Host "`n📋 Exemplo 1: Desenvolvimento de uma Nova Feature" -ForegroundColor Yellow
Write-Host "1. ./scripts/start-workflow.ps1 feature-development" -ForegroundColor Green
Write-Host "2. ./scripts/activate-agent.ps1 product-owner" -ForegroundColor Green
Write-Host "3. # Defina requisitos e user stories" -ForegroundColor Gray
Write-Host "4. ./scripts/activate-agent.ps1 architect" -ForegroundColor Green
Write-Host "5. # Projete a arquitetura técnica" -ForegroundColor Gray
Write-Host "6. ./scripts/activate-agent.ps1 frontend-dev" -ForegroundColor Green
Write-Host "7. # Implemente a interface" -ForegroundColor Gray

Write-Host "`n🐛 Exemplo 2: Correção de Bug" -ForegroundColor Yellow
Write-Host "1. ./scripts/start-workflow.ps1 bug-fixing" -ForegroundColor Green
Write-Host "2. ./scripts/activate-agent.ps1 tester" -ForegroundColor Green
Write-Host "3. # Analise e reproduza o bug" -ForegroundColor Gray
Write-Host "4. ./scripts/activate-agent.ps1 backend-dev" -ForegroundColor Green
Write-Host "5. # Implemente a correção" -ForegroundColor Gray

Write-Host "`n🔍 Exemplo 3: Code Review" -ForegroundColor Yellow
Write-Host "1. ./scripts/start-workflow.ps1 code-review" -ForegroundColor Green
Write-Host "2. ./scripts/activate-agent.ps1 architect" -ForegroundColor Green
Write-Host "3. # Revise arquitetura e padrões" -ForegroundColor Gray
Write-Host "4. ./scripts/activate-agent.ps1 tester" -ForegroundColor Green
Write-Host "5. # Execute testes e validações" -ForegroundColor Gray

Write-Host "`n📁 Estrutura de Arquivos:" -ForegroundColor Cyan
Write-Host "agent-team-template/" -ForegroundColor White
Write-Host "├── agents/           # Configurações dos agentes" -ForegroundColor Gray
Write-Host "├── workflows/        # Fluxos de trabalho" -ForegroundColor Gray
Write-Host "├── templates/        # Templates de prompts" -ForegroundColor Gray
Write-Host "├── scripts/          # Scripts de automação" -ForegroundColor Gray
Write-Host "└── docs/            # Documentação" -ForegroundColor Gray

Write-Host "`n🎯 Dicas de Uso:" -ForegroundColor Cyan
Write-Host "• Use os templates em templates/ para prompts específicos" -ForegroundColor White
Write-Host "• Siga os workflows para processos estruturados" -ForegroundColor White
Write-Host "• Cada agente tem expertise específica - use conforme necessário" -ForegroundColor White
Write-Host "• Os agentes podem colaborar entre si nos workflows" -ForegroundColor White
Write-Host "• Mantenha o contexto ativo com .active-agent e .active-workflow" -ForegroundColor White

Write-Host "`n❓ Precisa de mais ajuda?" -ForegroundColor Cyan
Write-Host "• Consulte a documentação em docs/" -ForegroundColor White
Write-Host "• Use ./scripts/list-agents.ps1 para ver agentes disponíveis" -ForegroundColor White
Write-Host "• Cada agente tem templates específicos em templates/" -ForegroundColor White
