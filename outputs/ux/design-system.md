# Design System - CRM para Desenvolvedor Autônomo

## 1. Visão Geral

Design system baseado no **shadcn/ui** com customizações específicas para o CRM. Foco em simplicidade, clareza e eficiência.

---

## 2. Princípios de Design

### 2.1 Princípios Fundamentais
- **Simplicidade**: Menos é mais - interface limpa e focada
- **Clareza**: Informação hierárquica clara
- **Eficiência**: Ações rápidas, poucos cliques
- **Consistência**: Padrões uniformes em toda aplicação
- **Acessibilidade**: Inclusivo para todos os usuários

---

## 3. Cores

### 3.1 Paleta Principal (shadcn/ui)
Baseado no tema padrão do shadcn/ui com ajustes para o contexto do CRM.

#### Cores Primárias
- **Primary**: Azul (#3b82f6) - Ações principais, links
- **Secondary**: Cinza (#6b7280) - Elementos secundários
- **Accent**: Verde (#10b981) - Sucesso, valores positivos

#### Cores Semânticas
- **Success**: Verde (#10b981) - Confirmações, valores positivos
- **Error**: Vermelho (#ef4444) - Erros, valores negativos
- **Warning**: Amarelo (#f59e0b) - Avisos, atenção
- **Info**: Azul (#3b82f6) - Informações, status neutro

#### Cores Neutras
- **Background**: Branco (#ffffff) / Cinza claro (#f9fafb)
- **Foreground**: Cinza escuro (#111827)
- **Border**: Cinza claro (#e5e7eb)
- **Muted**: Cinza médio (#9ca3af)

### 3.2 Modo Escuro (Futuro)
Paleta adaptada para modo escuro mantendo contraste WCAG AA.

---

## 4. Tipografia

### 4.1 Fontes
- **Primária**: Inter ou system-ui (fallback)
- **Monospace**: Para valores monetários e códigos

### 4.2 Escala Tipográfica
- **H1**: 2.25rem (36px) - Títulos principais
- **H2**: 1.875rem (30px) - Títulos de seção
- **H3**: 1.5rem (24px) - Subtítulos
- **H4**: 1.25rem (20px) - Títulos de cards
- **Body**: 1rem (16px) - Texto padrão
- **Small**: 0.875rem (14px) - Texto secundário
- **XSmall**: 0.75rem (12px) - Labels, métricas

### 4.3 Pesos
- **Regular**: 400 - Texto padrão
- **Medium**: 500 - Ênfase
- **Semibold**: 600 - Títulos
- **Bold**: 700 - Destaques

---

## 5. Espaçamento

### 5.1 Sistema de Grid
Baseado em múltiplos de 4px (4, 8, 12, 16, 24, 32, 48, 64).

### 5.2 Espaçamentos Comuns
- **XS**: 4px (0.25rem)
- **SM**: 8px (0.5rem)
- **MD**: 16px (1rem)
- **LG**: 24px (1.5rem)
- **XL**: 32px (2rem)
- **2XL**: 48px (3rem)

---

## 6. Componentes Base

### 6.1 Botões

#### Primário
- Background: Primary
- Texto: Branco
- Hover: Escurecer 10%
- Active: Escurecer 20%
- Padding: 12px 24px
- Border radius: 6px

#### Secundário
- Background: Transparente
- Texto: Foreground
- Borda: Border color
- Hover: Background cinza claro

#### Ghost
- Background: Transparente
- Texto: Foreground
- Hover: Background cinza muito claro

#### Tamanhos
- **Small**: 8px 16px, texto 14px
- **Medium**: 12px 24px, texto 16px (padrão)
- **Large**: 16px 32px, texto 18px

### 6.2 Inputs

#### Campos de Texto
- Altura: 40px (padrão)
- Padding: 12px 16px
- Border: 1px solid Border
- Border radius: 6px
- Foco: Borda Primary + shadow sutil

#### Estados
- **Normal**: Border padrão
- **Foco**: Border Primary + shadow
- **Erro**: Border Error + mensagem abaixo
- **Disabled**: Background muted + opacity 0.5

### 6.3 Cards

#### Estrutura
- Background: Branco
- Border: 1px solid Border
- Border radius: 8px
- Padding: 24px
- Shadow: Sutil (elevation baixa)

#### Hover
- Shadow aumenta levemente
- Transição suave (150ms)

### 6.4 Badges

#### Tipos
- **Success**: Verde claro, texto verde escuro
- **Error**: Vermelho claro, texto vermelho escuro
- **Warning**: Amarelo claro, texto amarelo escuro
- **Info**: Azul claro, texto azul escuro
- **Neutral**: Cinza claro, texto cinza escuro

---

## 7. Componentes Complexos

### 7.1 Data Table (shadcn/ui)
- Header fixo ao scroll
- Linhas alternadas (zebra striping)
- Hover em linhas
- Ordenação por colunas clicáveis
- Paginação no rodapé

### 7.2 Sidebar (sidebar-07)
- Background: Branco/Branco escuro
- Largura: 256px (expandido) / 64px (colapsado)
- Item ativo: Background Primary + indicador lateral
- Hover: Background cinza claro

### 7.3 Kanban Board
- Colunas: Background cinza muito claro
- Cards: Background branco + shadow
- Espaçamento entre cards: 12px
- Drag state: Opacity 0.5 + shadow maior

### 7.4 Modal/Dialog
- Overlay: Preto com opacity 0.5
- Modal: Background branco + shadow grande
- Largura máxima: 500px (formulários) / 800px (conteúdo)
- Border radius: 8px
- Animação: Fade in + scale in

---

## 8. Ícones

### 8.1 Biblioteca
- **Lucide Icons**: Biblioteca principal
- Tamanho padrão: 20px
- Tamanho pequeno: 16px
- Tamanho grande: 24px

### 8.2 Uso
- Consistência: Mesmo ícone para mesma ação
- Espaçamento: 8px do texto
- Cor: Herda cor do texto (ou Primary para ações)

---

## 9. Animações e Transições

### 9.1 Durações
- **Rápida**: 150ms - Micro-interações
- **Média**: 200-300ms - Transições padrão
- **Lenta**: 500ms - Animações complexas

### 9.2 Easing
- **Ease-in-out**: Transições padrão
- **Ease-out**: Entrada de elementos
- **Ease-in**: Saída de elementos

### 9.3 Animações Comuns
- **Fade**: Opacity 0 → 1
- **Slide**: Transform translate
- **Scale**: Transform scale (modais)
- **Shimmer**: Loading skeletons

---

## 10. Estados Visuais

### 10.1 Loading
- **Skeleton screens**: Para conteúdo estático
- **Spinners**: Para ações/processos
- **Progress bars**: Para processos longos

### 10.2 Feedback
- **Sucesso**: Toast verde + ícone check
- **Erro**: Toast vermelho + ícone X
- **Aviso**: Toast amarelo + ícone warning
- **Info**: Toast azul + ícone info

### 10.3 Vazio
- Ilustração simples
- Mensagem clara
- CTA para ação

---

## 11. Responsividade

### 11.1 Breakpoints
- **Mobile**: < 640px
- **Tablet**: 640px - 1024px
- **Desktop**: > 1024px

### 11.2 Adaptações
- **Sidebar**: Overlay em mobile
- **Tabelas**: Scroll horizontal ou cards em mobile
- **Kanban**: Scroll horizontal ou vertical em mobile
- **Formulários**: Coluna única em mobile

---

## 12. Acessibilidade

### 12.1 Contraste
- Texto normal: Mínimo 4.5:1
- Texto grande: Mínimo 3:1
- Elementos interativos: Contraste suficiente

### 12.2 Foco
- Indicador de foco visível (outline)
- Tab order lógico
- Skip links para conteúdo principal

### 12.3 Screen Readers
- Labels descritivos
- ARIA labels em ícones
- Anúncios de mudanças de estado

---

## 13. Tokens do Design System

### 13.1 Cores
```css
--color-primary: #3b82f6;
--color-secondary: #6b7280;
--color-success: #10b981;
--color-error: #ef4444;
--color-warning: #f59e0b;
```

### 13.2 Espaçamento
```css
--spacing-xs: 4px;
--spacing-sm: 8px;
--spacing-md: 16px;
--spacing-lg: 24px;
--spacing-xl: 32px;
```

### 13.3 Tipografia
```css
--font-size-base: 16px;
--font-weight-normal: 400;
--font-weight-medium: 500;
--font-weight-semibold: 600;
```

### 13.4 Bordas
```css
--radius-sm: 4px;
--radius-md: 6px;
--radius-lg: 8px;
```

---

## 14. Guia de Uso

### 14.1 Quando Usar Cada Componente
- **Botão Primário**: Ação principal da página
- **Botão Secundário**: Ações secundárias
- **Modal**: Confirmações importantes, formulários complexos
- **Toast**: Feedback de ações rápidas
- **Card**: Agrupamento de informações relacionadas

### 14.2 Padrões de Layout
- Máximo 3 colunas no desktop
- Máximo largura de conteúdo: 1200px
- Espaçamento consistente entre seções
- Alinhamento à esquerda (RTL future-proof)

---

## 15. Manutenção

### 15.1 Documentação
- Componentes documentados no Storybook
- Exemplos de uso para cada componente
- Variantes e estados documentados

### 15.2 Versionamento
- Design system versionado
- Changelog de mudanças
- Breaking changes comunicados

### 15.3 Contribuição
- Guia de contribuição
- Code review obrigatório
- Testes de componentes

---

## 16. Referências

### 16.1 Baseado em
- [shadcn/ui](https://ui.shadcn.com/) - Componentes base
- [Tailwind CSS](https://tailwindcss.com/) - Utility classes
- [Radix UI](https://www.radix-ui.com/) - Primitivos acessíveis

### 16.2 Inspirações
- Linear - Simplicidade e elegância
- Notion - Flexibilidade
- Stripe - Clareza e precisão

