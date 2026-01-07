# Protótipos Interativos - CRM para Desenvolvedor Autônomo

## 1. Definição de Protótipo

Este documento descreve as interações, estados e transições dos protótipos de alta fidelidade baseados no design system shadcn/ui.

---

## 2. Componente: Sidebar (sidebar-07)

### 2.1 Estados
- **Expandido (Desktop)**: Sidebar sempre visível, ícone + texto
- **Colapsado (Desktop)**: Sidebar reduzida, apenas ícones (hover mostra tooltip)
- **Overlay (Mobile)**: Sidebar em drawer que abre/ fecha

### 2.2 Interações
- **Hover**: Item destacado com background sutil
- **Active**: Item atual com background destacado + indicador lateral
- **Click**: Navegação para página correspondente
- **Toggle (mobile)**: Botão hamburguer abre/fecha drawer

### 2.3 Transições
- Expansão/colapso: 200ms ease-in-out
- Mudança de página: Fade out/in 150ms
- Drawer mobile: Slide in/out 300ms ease-out

---

## 3. Componente: Kanban Board

### 3.1 Estrutura
- **Colunas**: 6 colunas fixas (Lead, 1º Contato, Reunião, Proposta Enviada, Negociação, Fechado)
- **Cards**: Cada cliente é um card arrastável
- **Contadores**: Número de cards por coluna no cabeçalho

### 3.2 Interações de Drag & Drop

#### Estado Inicial
```
Card estático na coluna
```

#### Ao Iniciar Drag (onDragStart)
- Card fica semi-transparente (opacity: 0.5)
- Cursor muda para "grabbing"
- Card original permanece na posição (placeholder)
- Todas as colunas mostram zona de drop (destaque sutil)

#### Durante o Drag (onDragOver)
- Coluna válida: Background azul claro + borda
- Coluna inválida: Sem feedback
- Card "flutua" seguindo cursor
- Preview do card mostra informações principais

#### Ao Soltar (onDrop)
- **Sucesso**: 
  - Card aparece na nova coluna
  - Animação de "slide" suave (200ms)
  - Toast: "Status atualizado com sucesso"
  - Contador da coluna atualiza
- **Erro**:
  - Card retorna à posição original
  - Animação de "shake" (300ms)
  - Toast: "Erro ao atualizar status. Tente novamente."

#### Estados de Loading
- Durante atualização: Spinner pequeno no card
- Card fica desabilitado durante atualização

### 3.3 Animações
- **Entrada de card**: Fade in + slide up (200ms)
- **Saída de card**: Fade out (150ms)
- **Reorder dentro da coluna**: Smooth transition (150ms)
- **Atualização de contador**: Count-up animation

---

## 4. Componente: Data Table (shadcn/ui)

### 4.1 Interações
- **Ordenação**: Clicar no cabeçalho da coluna
  - Primeiro clique: Ordem crescente ↑
  - Segundo clique: Ordem decrescente ↓
  - Terceiro clique: Remove ordenação
  - Indicador visual de coluna ordenada

- **Seleção de linha**:
  - Hover: Background cinza claro
  - Click: Seleciona linha (checkbox ou linha completa)
  - Seleção múltipla: Checkboxes aparecem

- **Menu de contexto**:
  - Ícone "⋮" no final de cada linha
  - Click abre dropdown com ações (Editar, Excluir, Ver detalhes)
  - Click fora fecha dropdown

### 4.2 Estados
- **Loading**: Skeleton rows (5 linhas)
- **Vazio**: Ilustração + mensagem + CTA
- **Erro**: Mensagem de erro + botão "Tentar novamente"
- **Paginado**: Controles de paginação no rodapé

### 4.3 Busca e Filtros
- **Campo de busca**: 
  - Busca em tempo real (debounce 300ms)
  - Ícone de busca vira "X" quando há texto (limpar)
  - Loading indicator durante busca
  
- **Filtros**:
  - Dropdown com múltiplas opções
  - Chips mostram filtros ativos
  - Botão "Limpar filtros" aparece quando há filtros ativos

---

## 5. Componente: Formulários

### 5.1 Estados dos Campos

#### Estado Inicial
- Campo normal, sem destaque
- Label acima do campo
- Placeholder se aplicável

#### Foco (onFocus)
- Borda muda para cor primária
- Label anima para cima (se estava dentro do campo)
- Tooltip de ajuda aparece (se houver)

#### Digitação (onChange)
- Validação em tempo real (após blur ou submit)
- Ícone de validação aparece (✓ verde ou ✗ vermelho)

#### Erro (onBlur/Submit)
- Borda vermelha
- Mensagem de erro abaixo do campo
- Ícone de erro (✗)
- Campo permanece em foco se for crítico

#### Sucesso (Validação OK)
- Borda verde sutil
- Ícone de sucesso (✓)

### 5.2 Validação em Tempo Real
```
Usuário digita email
    ↓
Após 500ms de pausa (debounce)
    ↓
Valida formato de email
    ↓
Feedback visual imediato
```

### 5.3 Submissão do Formulário

#### Antes do Submit
- Botão "Salvar" habilitado quando formulário válido
- Botão desabilitado mostra estado disabled

#### Durante Submit
- Botão muda para "Salvando..."
- Spinner substitui texto
- Todos os campos ficam desabilitados
- Overlay sutil cobre formulário (previne múltiplos submits)

#### Sucesso
- Toast notification: "Cliente salvo com sucesso!"
- Formulário reseta (se criar) ou mantém (se editar)
- Redirecionamento ou atualização de lista

#### Erro
- Toast notification: "Erro ao salvar. Verifique os dados."
- Formulário permanece preenchido
- Campos com erro destacados
- Mensagem de erro específica

---

## 6. Componente: Dashboard Cards

### 6.1 Cards de Métricas
- **Hover**: Elevação sutil (shadow aumenta)
- **Click**: Navega para página relacionada (ex: card "Atrasado" → lista de inadimplentes)

### 6.2 Animações de Números
- **Carregamento**: Contador anima de 0 até valor final
- **Atualização**: Número atualiza com transição suave
- **Destaque**: Valores negativos/positivos com cores distintas

### 6.3 Gráficos (Futuro)
- **Hover**: Tooltip mostra valor exato
- **Click**: Filtra dados relacionados
- **Loading**: Skeleton do gráfico

---

## 7. Componente: Modal/Dialog

### 7.1 Abertura
- **Trigger**: Botão ou ação do usuário
- **Animação**: Fade in do overlay + scale in do modal (200ms)
- **Foco**: Primeiro campo foca automaticamente
- **Scroll lock**: Body não rola enquanto modal aberto

### 7.2 Interações
- **Fechar**:
  - Click no overlay (fora do modal)
  - Botão X no canto superior
  - Tecla ESC
  - Botão "Cancelar"
  
- **Confirmação**:
  - Botão primário executa ação
  - Loading durante ação
  - Fecha automaticamente após sucesso

### 7.3 Estados
- **Confirmar exclusão**: Modal de confirmação com destaque vermelho
- **Formulário longo**: Scroll dentro do modal, header fixo
- **Múltiplos passos**: Indicador de progresso no topo

---

## 8. Sistema de Notificações (Toast)

### 8.1 Posicionamento
- Canto superior direito
- Stack vertical (mais recente no topo)
- Máximo 3 notificações visíveis simultaneamente

### 8.2 Tipos
- **Sucesso**: Verde, ícone ✓
- **Erro**: Vermelho, ícone ✗
- **Aviso**: Amarelo, ícone ⚠
- **Info**: Azul, ícone ℹ

### 8.3 Comportamento
- **Aparece**: Slide in da direita (300ms)
- **Duração**: 4 segundos (configurável)
- **Fecha**: 
  - Automaticamente após duração
  - Click no X
  - Swipe para direita (mobile)
- **Desaparece**: Slide out para direita + fade out (200ms)

### 8.4 Exemplos de Mensagens
- "Cliente salvo com sucesso!"
- "Status atualizado"
- "Erro ao carregar dados. Tente novamente."
- "3 cobranças próximas do vencimento"

---

## 9. Micro-interações

### 9.1 Botões
- **Hover**: Elevação + mudança de cor sutil
- **Active**: Press down effect (scale 0.98)
- **Loading**: Spinner + texto "Carregando..."
- **Disabled**: Opacity 0.5 + cursor not-allowed

### 9.2 Links
- **Hover**: Sublinhado aparece
- **Visited**: Cor diferente (se aplicável)
- **Active**: Cor mais escura

### 9.3 Ícones
- **Hover**: Scale 1.1 (110%)
- **Click**: Feedback visual (ripple effect)
- **Loading**: Spinner rotativo

### 9.4 Inputs
- **Foco**: Borda destaca + sombra sutil
- **Digitação**: Validação em tempo real
- **Autocomplete**: Dropdown aparece abaixo

---

## 10. Estados de Loading

### 10.1 Skeleton Screens
Usados em:
- Lista de clientes (5 linhas)
- Dashboard cards
- Tabelas
- Kanban cards

**Aparência**: 
- Fundo cinza claro animado (shimmer effect)
- Formato similar ao conteúdo real
- Transição suave para conteúdo real

### 10.2 Spinners
Usados em:
- Botões durante ações
- Modals
- Carregamento de páginas

**Aparência**:
- Circular, cor primária
- Tamanho proporcional ao contexto
- Texto opcional: "Carregando..."

### 10.3 Progress Bars
Usados em:
- Uploads (futuro)
- Processos longos
- Sincronização (futuro)

---

## 11. Feedback de Erro

### 11.1 Níveis de Erro

#### Erro de Campo (Inline)
- Mensagem abaixo do campo
- Campo destacado em vermelho
- Ícone de erro ao lado

#### Erro de Formulário (Toast)
- Toast notification
- Lista de erros se múltiplos
- Links para campos com erro

#### Erro de Página (Full Page)
- Mensagem centralizada
- Ilustração de erro
- Botão "Tentar novamente"
- Link para voltar

#### Erro de API (Global)
- Toast notification
- Log de erro para debug
- Opção de reportar erro

### 11.2 Mensagens de Erro
- **Claras**: "Email inválido" ao invés de "Validation error"
- **Ações**: "Verifique o formato do email" com exemplo
- **Não culpam usuário**: "Não foi possível salvar" ao invés de "Você errou"

---

## 12. Transições de Página

### 12.1 Navegação
- **Entre páginas**: Fade out/in (150ms)
- **Scroll to top**: Automático ao mudar de página
- **Preservação de scroll**: Em listas, preserva posição ao voltar

### 12.2 Animações de Entrada
- **Lista de itens**: Stagger animation (cada item aparece 50ms após o anterior)
- **Cards**: Fade in + slide up
- **Modal**: Scale + fade

### 12.3 Animações de Saída
- **Itens removidos**: Fade out + slide down
- **Cards deletados**: Shrink + fade

---

## 13. Interações Especiais

### 13.1 Busca Global (Futuro)
- **Trigger**: Cmd/Ctrl + K
- **Overlay**: Modal de busca com fundo escuro
- **Resultados**: Lista de resultados em tempo real
- **Navegação**: Setas para navegar, Enter para selecionar

### 13.2 Atalhos de Teclado
- **Nova ação**: Cmd/Ctrl + N (contextual)
- **Salvar**: Cmd/Ctrl + S
- **Buscar**: Cmd/Ctrl + F
- **Fechar modal**: ESC

### 13.3 Gestos (Mobile)
- **Swipe para deletar**: Lista de itens
- **Pull to refresh**: Listas
- **Swipe entre abas**: Navegação de tabs

---

## 14. Protótipo de Fluxo Completo

### 14.1 Fluxo: Cadastrar Cliente e Mover no Pipeline

```
1. Usuário clica "Novo Cliente"
   → Modal abre (fade in + scale)
   
2. Usuário preenche formulário
   → Validação em tempo real
   → Campos mostram ✓ quando válidos
   
3. Usuário clica "Salvar"
   → Botão mostra "Salvando..." + spinner
   → Campos desabilitados
   
4. Sucesso
   → Toast: "Cliente salvo!"
   → Modal fecha
   → Lista atualiza (cliente aparece)
   → Pipeline atualiza (card aparece em "Lead")
   
5. Usuário arrasta card para "Primeiro Contato"
   → Drag visual (card fica transparente)
   → Coluna destaca (background azul)
   → Drop: card aparece na nova posição
   → Toast: "Status atualizado"
   → Contador atualiza
```

### 14.2 Fluxo: Visualizar Dashboard

```
1. Usuário acessa dashboard
   → Skeleton screens aparecem
   → Loading de dados em paralelo
   
2. Cards de métricas carregam
   → Números animam de 0 até valor final
   → Ícones aparecem (fade in)
   
3. Tabela de cobranças carrega
   → Linhas aparecem com stagger animation
   
4. Preview do pipeline carrega
   → Cards aparecem (fade in)
   
5. Dashboard completo
   → Todas as interações habilitadas
   → Hover effects ativos
```

---

## 15. Bibliotecas e Ferramentas Recomendadas

### 15.1 Para Prototipagem
- **Figma**: Design e prototipagem de alta fidelidade
- **Framer**: Protótipos mais interativos
- **Storybook**: Componentes isolados para desenvolvimento

### 15.2 Para Animações
- **Framer Motion**: Animações React
- **CSS Transitions**: Animações simples
- **React Spring**: Animações físicas avançadas

### 15.3 Para Drag & Drop
- **@dnd-kit/core**: Biblioteca moderna de drag & drop
- **react-beautiful-dnd**: Alternativa popular

---

## 16. Testes de Protótipo

### 16.1 Testes de Usabilidade
- Testar fluxos principais com usuários reais
- Medir tempo de conclusão de tarefas
- Identificar pontos de confusão
- Coletar feedback qualitativo

### 16.2 Testes A/B
- Diferentes layouts de formulário
- Posições de botões
- Cores e contrastes
- Tamanhos de fonte

### 16.3 Testes de Acessibilidade
- Navegação apenas por teclado
- Screen reader compatibility
- Contraste de cores (WCAG)
- Tamanhos de touch targets (mínimo 44x44px)

