# Critérios de Aceitação - CRM para Desenvolvedor Autônomo

## EPIC 1: Autenticação e Segurança

### US-001: Login no Sistema

#### Cenários de Sucesso
- ✅ Usuário consegue fazer login com email e senha válidos
- ✅ Sistema redireciona para dashboard após login bem-sucedido
- ✅ Sessão é mantida após login (não pede login novamente ao navegar)
- ✅ Token de autenticação é armazenado de forma segura

#### Casos Extremos
- ✅ Tentativa de login com email inexistente exibe mensagem clara
- ✅ Tentativa de login com senha incorreta exibe mensagem de erro
- ✅ Múltiplas tentativas de login falhadas (5+) bloqueiam temporariamente a conta
- ✅ Campos vazios não permitem submissão do formulário

#### Validações Necessárias
- ✅ Email deve ter formato válido
- ✅ Senha deve ter mínimo de 8 caracteres
- ✅ Mensagens de erro são claras e não expõem informações sensíveis
- ✅ Sistema registra tentativas de login (auditoria)

---

## EPIC 2: Gestão de Clientes

### US-002: Cadastrar Novo Cliente

#### Cenários de Sucesso
- ✅ Formulário permite cadastrar cliente com todos os campos obrigatórios
- ✅ Cliente é salvo no banco de dados após submissão válida
- ✅ Mensagem de sucesso é exibida após cadastro
- ✅ Usuário é redirecionado para lista de clientes ou detalhes do cliente criado

#### Campos Obrigatórios
- ✅ Nome / Empresa
- ✅ Tipo (PF / PJ)
- ✅ Pelo menos um contato (email OU WhatsApp)

#### Campos Opcionais
- ✅ Segmento do cliente
- ✅ Observações técnicas (stack, nível técnico)

#### Casos Extremos
- ✅ Não permite cadastrar cliente sem nome/empresa
- ✅ Não permite cadastrar cliente sem tipo (PF/PJ)
- ✅ Não permite cadastrar cliente sem nenhum contato
- ✅ Valida formato de email se fornecido
- ✅ Permite cadastrar múltiplos clientes com mesmo nome (empresas diferentes)

#### Validações Necessárias
- ✅ Nome/Empresa: mínimo 2 caracteres, máximo 200
- ✅ Email: formato válido (se fornecido)
- ✅ WhatsApp: formato válido de telefone (se fornecido)
- ✅ Tipo: apenas "PF" ou "PJ"

---

### US-003: Visualizar Lista de Clientes

#### Cenários de Sucesso
- ✅ Lista exibe todos os clientes cadastrados
- ✅ Usa componente Data Table do shadcn/ui
- ✅ Informações principais visíveis: Nome, Tipo, Status, Última atualização
- ✅ Permite ordenação por colunas clicáveis
- ✅ Permite busca/filtro por nome ou empresa
- ✅ Paginação funciona corretamente (se mais de 10 clientes)

#### Casos Extremos
- ✅ Lista vazia exibe mensagem amigável "Nenhum cliente cadastrado"
- ✅ Busca sem resultados exibe mensagem clara
- ✅ Cliques em linhas da tabela navegam para detalhes do cliente

#### Validações Necessárias
- ✅ Dados são carregados de forma assíncrona
- ✅ Loading state é exibido durante carregamento
- ✅ Erro de carregamento exibe mensagem apropriada

---

### US-004: Editar Informações do Cliente

#### Cenários de Sucesso
- ✅ Formulário de edição pré-preenche todos os campos existentes
- ✅ Alterações são salvas corretamente no banco de dados
- ✅ Mensagem de sucesso é exibida após edição
- ✅ Mudanças são refletidas imediatamente na lista/detalhes

#### Casos Extremos
- ✅ Cancelar edição não salva alterações
- ✅ Validações são as mesmas do cadastro (US-002)
- ✅ Tentativa de editar cliente inexistente retorna erro 404

#### Validações Necessárias
- ✅ Mesmas validações do cadastro (US-002)
- ✅ Timestamp de última atualização é atualizado

---

### US-005: Excluir Cliente

#### Cenários de Sucesso
- ✅ Confirmação é solicitada antes de excluir
- ✅ Cliente é removido do banco após confirmação
- ✅ Mensagem de sucesso é exibida
- ✅ Lista é atualizada após exclusão

#### Casos Extremos
- ✅ Cancelar exclusão não remove o cliente
- ✅ Tentativa de excluir cliente inexistente retorna erro apropriado
- ✅ Excluir cliente com propostas/pagamentos vinculados: definir comportamento (cascata/bloqueio)

#### Validações Necessárias
- ✅ Verificar se há propostas/pagamentos vinculados antes de excluir
- ✅ Opção de soft delete (marcar como inativo) vs hard delete

---

## EPIC 3: Gestão de Pipeline (Status do Cliente)

### US-006: Visualizar Pipeline em Kanban

#### Cenários de Sucesso
- ✅ Board Kanban exibe 6 colunas: Lead, Primeiro Contato, Reunião, Proposta Enviada, Negociação, Fechado
- ✅ Cada cliente aparece como card na coluna correspondente ao seu status
- ✅ Cards exibem informações principais: Nome, Empresa, Valor da proposta (se houver)
- ✅ Cards são visualmente distintos e organizados
- ✅ Layout é responsivo (funciona em mobile/tablet)

#### Casos Extremos
- ✅ Coluna vazia exibe mensagem "Arraste clientes aqui"
- ✅ Muitos clientes na mesma coluna: scroll vertical funciona
- ✅ Clientes sem status aparecem na coluna "Lead" por padrão

#### Validações Necessárias
- ✅ Componente sidebar-07 do shadcn/ui é usado como base do layout
- ✅ Ícones do lucide-icons são usados
- ✅ Design system do shadcn/ui é respeitado

---

### US-007: Atualizar Status do Cliente no Pipeline

#### Cenários de Sucesso
- ✅ Drag and drop funciona: cliente pode ser arrastado entre colunas
- ✅ Status do cliente é atualizado no banco após soltar o card
- ✅ Feedback visual indica onde o card será solto
- ✅ Card aparece imediatamente na nova coluna após soltar

#### Casos Extremos
- ✅ Cancelar drag (soltar fora das colunas) não altera status
- ✅ Múltiplos drags rápidos não causam conflitos (debounce/throttle)
- ✅ Erro ao salvar status: card retorna à posição original

#### Validações Necessárias
- ✅ Status é validado antes de salvar (deve ser um dos 6 válidos)
- ✅ Atualização é feita via API de forma assíncrona
- ✅ Loading state durante atualização (opcional: spinner no card)

---

### US-008: Filtrar Clientes por Status

#### Cenários de Sucesso
- ✅ Filtro permite selecionar um ou múltiplos status
- ✅ Lista/filtro é aplicado imediatamente
- ✅ Filtro ativo é indicado visualmente
- ✅ Limpar filtro mostra todos os clientes novamente

#### Casos Extremos
- ✅ Filtro vazio mostra todos os clientes
- ✅ Filtro sem resultados exibe mensagem apropriada

#### Validações Necessárias
- ✅ Filtro funciona tanto na lista quanto no Kanban

---

## EPIC 4: Gestão de Propostas

### US-009: Criar Nova Proposta

#### Cenários de Sucesso
- ✅ Formulário permite criar proposta vinculada a um cliente
- ✅ Todos os campos obrigatórios são preenchidos
- ✅ Proposta é salva no banco de dados
- ✅ Status inicial é "enviada"
- ✅ Cliente vinculado recebe atualização de status para "Proposta Enviada"

#### Campos Obrigatórios
- ✅ Cliente (select/dropdown)
- ✅ Descrição do serviço
- ✅ Valor (número positivo)
- ✅ Prazo de entrega
- ✅ Forma de pagamento

#### Campos Opcionais
- ✅ Observações adicionais

#### Casos Extremos
- ✅ Valor deve ser maior que zero
- ✅ Prazo deve ser uma data futura
- ✅ Forma de pagamento deve ser uma opção válida (ex: à vista, parcelado)
- ✅ Não permite criar proposta sem cliente vinculado

#### Validações Necessárias
- ✅ Valor: número positivo, máximo 2 casas decimais
- ✅ Prazo: data válida, não pode ser passada
- ✅ Descrição: mínimo 10 caracteres, máximo 2000

---

### US-010: Visualizar Propostas

#### Cenários de Sucesso
- ✅ Lista exibe todas as propostas usando Data Table
- ✅ Colunas: Cliente, Valor, Prazo, Status, Data de criação
- ✅ Permite ordenação e busca
- ✅ Links clicáveis para cliente e detalhes da proposta

#### Casos Extremos
- ✅ Lista vazia exibe mensagem apropriada
- ✅ Filtros funcionam corretamente

#### Validações Necessárias
- ✅ Dados são carregados de forma eficiente
- ✅ Loading state durante carregamento

---

### US-011: Atualizar Status da Proposta

#### Cenários de Sucesso
- ✅ Status pode ser alterado entre "enviada" e "aceita"
- ✅ Atualização é salva imediatamente
- ✅ Se proposta aceita: cliente pode ser atualizado para status "Fechado"

#### Casos Extremos
- ✅ Proposta aceita não pode voltar para "enviada"
- ✅ Tentativa de atualizar proposta inexistente retorna erro

#### Validações Necessárias
- ✅ Status deve ser um dos valores válidos
- ✅ Transição de status é registrada (histórico)

---

### US-012: Editar Proposta

#### Cenários de Sucesso
- ✅ Formulário pré-preenche dados existentes
- ✅ Alterações são salvas corretamente
- ✅ Propostas aceitas podem ter edição limitada (apenas observações)

#### Casos Extremos
- ✅ Editar proposta inexistente retorna erro 404
- ✅ Validações são as mesmas da criação

#### Validações Necessárias
- ✅ Mesmas validações de US-009
- ✅ Verificar se proposta já foi aceita antes de permitir edição completa

---

## EPIC 5: Controle Financeiro

### US-013: Registrar Pagamento Combinado

#### Cenários de Sucesso
- ✅ Formulário permite registrar valor total combinado
- ✅ Valor é vinculado a uma proposta aceita
- ✅ Valor é salvo no banco de dados

#### Casos Extremos
- ✅ Valor deve ser maior que zero
- ✅ Não permite registrar valor maior que o da proposta (ou permite com justificativa?)
- ✅ Cliente deve ter proposta aceita vinculada

#### Validações Necessárias
- ✅ Valor: número positivo, máximo 2 casas decimais
- ✅ Deve existir proposta aceita vinculada ao cliente

---

### US-014: Configurar Parcelas de Pagamento

#### Cenários de Sucesso
- ✅ Interface permite definir número de parcelas
- ✅ Cada parcela tem: valor, data de vencimento
- ✅ Parcelas são criadas automaticamente ou manualmente
- ✅ Soma das parcelas deve igualar valor combinado

#### Casos Extremos
- ✅ Número mínimo de parcelas: 1
- ✅ Número máximo de parcelas: 24 (ou configurável)
- ✅ Datas de vencimento não podem ser passadas (ou podem?)
- ✅ Parcelas com valores diferentes são permitidas

#### Validações Necessárias
- ✅ Soma de parcelas = valor combinado (tolerância de centavos)
- ✅ Datas de vencimento são válidas e em ordem cronológica
- ✅ Cada parcela tem valor > 0

---

### US-015: Registrar Status de Pagamento

#### Cenários de Sucesso
- ✅ Interface permite marcar parcela como "pago", "pendente" ou "atrasado"
- ✅ Status é atualizado imediatamente
- ✅ Status visual distingue os diferentes estados (cores)
- ✅ Data de pagamento é registrada quando marcado como "pago"

#### Casos Extremos
- ✅ Parcela paga não pode voltar para pendente (ou pode com justificativa?)
- ✅ Parcela atrasada é calculada automaticamente se data passou
- ✅ Múltiplas parcelas podem ser atualizadas em lote

#### Validações Necessárias
- ✅ Status deve ser um dos três valores válidos
- ✅ Data de pagamento obrigatória quando status = "pago"
- ✅ Status "atrasado" é calculado automaticamente se vencimento passou

---

### US-016: Visualizar Dashboard Financeiro

#### Cenários de Sucesso
- ✅ Dashboard exibe cards com métricas principais:
  - Total recebido
  - Total pendente
  - Total atrasado
- ✅ Gráfico/tabela de próximas cobranças (próximos 30 dias)
- ✅ Dados são atualizados em tempo real

#### Casos Extremos
- ✅ Dashboard vazio (sem pagamentos) exibe zeros/mensagem apropriada
- ✅ Valores são formatados como moeda (R$)

#### Validações Necessárias
- ✅ Cálculos são precisos
- ✅ Performance: carregamento rápido mesmo com muitos registros
- ✅ Dados são atualizados ao navegar para dashboard

---

## EPIC 6: Sistema de Alertas e Cobranças

### US-017: Configurar Lembrete Automático de Cobrança

#### Cenários de Sucesso
- ✅ Configuração permite definir dias antes do vencimento (ex: 3, 7, 15 dias)
- ✅ Alertas são enviados automaticamente (email/notificação)
- ✅ Histórico de alertas enviados é registrado

#### Casos Extremos
- ✅ Parcela já paga não recebe alerta
- ✅ Múltiplos alertas não são enviados no mesmo dia
- ✅ Sistema de alertas funciona mesmo se usuário não acessa o sistema

#### Validações Necessárias
- ✅ Dias de antecipação: mínimo 1, máximo 30
- ✅ Job/processo em background executa diariamente
- ✅ Logs de alertas enviados são mantidos

---

### US-018: Visualizar Status Visual de Inadimplência

#### Cenários de Sucesso
- ✅ Clientes com pagamentos atrasados têm indicador visual (badge/ícone)
- ✅ Lista de clientes destaca inadimplentes
- ✅ Dashboard mostra resumo de inadimplência

#### Casos Extremos
- ✅ Cliente sem pagamentos não é considerado inadimplente
- ✅ Cliente com parcela atrasada mas outras pagas: como tratar?

#### Validações Necessárias
- ✅ Definição clara: cliente é inadimplente se tem pelo menos 1 parcela atrasada
- ✅ Indicador visual é claro e não invasivo

---

### US-019: Visualizar Histórico de Cobranças

#### Cenários de Sucesso
- ✅ Interface exibe histórico cronológico de todas as cobranças
- ✅ Para cada cobrança: data, valor, status, método de contato
- ✅ Histórico é vinculado ao cliente

#### Casos Extremos
- ✅ Cliente sem histórico exibe mensagem apropriada
- ✅ Histórico longo é paginado

#### Validações Necessárias
- ✅ Dados são ordenados por data (mais recente primeiro)
- ✅ Performance: carregamento eficiente

---

### US-020: Registrar Nova Tentativa de Cobrança

#### Cenários de Sucesso
- ✅ Interface permite registrar tentativa manual de cobrança
- ✅ Campos: data, método (email/WhatsApp/telefone), observações
- ✅ Registro é salvo no histórico (US-019)

#### Casos Extremos
- ✅ Data não pode ser futura
- ✅ Campos obrigatórios devem ser preenchidos

#### Validações Necessárias
- ✅ Data: não pode ser futura
- ✅ Método: deve ser uma opção válida

---

## Definição de "Pronto" (Definition of Done)

Uma user story é considerada "Pronta" quando:

1. ✅ Todos os critérios de aceitação foram atendidos
2. ✅ Código foi revisado (code review)
3. ✅ Testes unitários foram escritos e passando
4. ✅ Testes de integração foram executados
5. ✅ Interface segue design system do shadcn/ui
6. ✅ Documentação foi atualizada (se necessário)
7. ✅ Feature foi testada manualmente em ambiente de desenvolvimento
8. ✅ Não introduz novos bugs conhecidos
9. ✅ Performance está dentro dos limites aceitáveis
10. ✅ Acessibilidade básica foi verificada

