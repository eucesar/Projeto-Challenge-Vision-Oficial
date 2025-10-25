# 🌿 Git Flow - Challenge Vision

## 📋 Visão Geral

Este documento descreve a estratégia de Git Flow implementada no projeto Challenge Vision, seguindo as melhores práticas de desenvolvimento de software e controle de versão.

## 🎯 Objetivos do Git Flow

- **Controle de Versão**: Gerenciamento profissional de releases
- **Colaboração**: Facilitação do trabalho em equipe
- **Qualidade**: Garantia de código estável em produção
- **Rastreabilidade**: Histórico completo de mudanças
- **Rollback**: Capacidade de reverter mudanças quando necessário

---

## 🌳 Estrutura de Branches

### 🔴 **Branches Principais**

#### **main** (Produção)
- **Propósito**: Código em produção, sempre estável
- **Proteção**: Merge apenas via Pull Request
- **Tags**: Versões oficiais (v1.0.0, v1.1.0, etc.)
- **Deploy**: Automático para produção

#### **develop** (Desenvolvimento)
- **Propósito**: Integração de features, código de desenvolvimento
- **Proteção**: Merge apenas via Pull Request
- **Deploy**: Automático para ambiente de staging

### 🟡 **Branches de Suporte**

#### **feature/** (Funcionalidades)
- **Padrão**: `feature/nome-da-funcionalidade`
- **Exemplos**:
  - `feature/challengebot-integration`
  - `feature/offline-sync`
  - `feature/project-analytics`
- **Origem**: `develop`
- **Destino**: `develop`

#### **release/** (Releases)
- **Padrão**: `release/v1.0.0`
- **Exemplos**:
  - `release/v1.0.0`
  - `release/v1.1.0`
- **Origem**: `develop`
- **Destino**: `main` e `develop`

#### **hotfix/** (Correções Urgentes)
- **Padrão**: `hotfix/descricao-do-bug`
- **Exemplos**:
  - `hotfix/critical-auth-bug`
  - `hotfix/firebase-connection-fix`
- **Origem**: `main`
- **Destino**: `main` e `develop`

#### **bugfix/** (Correções de Bugs)
- **Padrão**: `bugfix/descricao-do-bug`
- **Exemplos**:
  - `bugfix/ui-responsive-issue`
  - `bugfix/data-sync-problem`
- **Origem**: `develop`
- **Destino**: `develop`

---

## 🔄 Fluxo de Trabalho

### 1. **Desenvolvimento de Feature**

```bash
# 1. Criar branch de feature a partir de develop
git checkout develop
git pull origin develop
git checkout -b feature/nova-funcionalidade

# 2. Desenvolver a funcionalidade
git add .
git commit -m "feat: implementa nova funcionalidade X"

# 3. Push da branch
git push origin feature/nova-funcionalidade

# 4. Criar Pull Request para develop
# 5. Code review e aprovação
# 6. Merge para develop
# 7. Deletar branch de feature
```

### 2. **Preparação de Release**

```bash
# 1. Criar branch de release
git checkout develop
git pull origin develop
git checkout -b release/v1.0.0

# 2. Atualizar versão e changelog
# 3. Testes finais
# 4. Merge para main
git checkout main
git merge --no-ff release/v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"

# 5. Merge para develop
git checkout develop
git merge --no-ff release/v1.0.0

# 6. Deletar branch de release
git branch -d release/v1.0.0
```

### 3. **Hotfix Urgente**

```bash
# 1. Criar branch de hotfix a partir de main
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug-fix

# 2. Implementar correção
git add .
git commit -m "fix: corrige bug crítico Y"

# 3. Merge para main
git checkout main
git merge --no-ff hotfix/critical-bug-fix
git tag -a v1.0.1 -m "Hotfix version 1.0.1"

# 4. Merge para develop
git checkout develop
git merge --no-ff hotfix/critical-bug-fix

# 5. Deletar branch de hotfix
git branch -d hotfix/critical-bug-fix
```

---

## 📝 Convenções de Commit

### 🏷️ **Padrão de Mensagens**

```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[rodapé opcional]
```

### 📋 **Tipos de Commit**

| Tipo | Descrição | Exemplo |
|------|-----------|---------|
| **feat** | Nova funcionalidade | `feat(auth): adiciona login com Firebase` |
| **fix** | Correção de bug | `fix(ui): corrige layout responsivo` |
| **docs** | Documentação | `docs(readme): atualiza instruções de instalação` |
| **style** | Formatação, sem mudança de código | `style: corrige indentação` |
| **refactor** | Refatoração de código | `refactor(services): melhora estrutura do AuthService` |
| **test** | Adição ou correção de testes | `test(project): adiciona testes unitários` |
| **chore** | Mudanças em build, dependências | `chore(deps): atualiza Flutter para 3.8.0` |

### 🎯 **Escopos**

| Escopo | Descrição |
|--------|-----------|
| **auth** | Autenticação e autorização |
| **ui** | Interface do usuário |
| **api** | Integração com APIs |
| **storage** | Armazenamento de dados |
| **ai** | Funcionalidades de IA |
| **sync** | Sincronização de dados |
| **config** | Configurações do sistema |

### 📝 **Exemplos de Commits**

```bash
# Feature
feat(ai): implementa integração com Gemini AI

# Bug fix
fix(sync): corrige problema de sincronização offline

# Documentation
docs(api): documenta endpoints do ChallengeBot

# Refactoring
refactor(ui): melhora performance do ProjectCard

# Test
test(auth): adiciona testes para AuthService

# Chore
chore(deps): atualiza Firebase para versão 5.4.4
```

---

## 🏷️ Versionamento Semântico

### 📊 **Padrão: MAJOR.MINOR.PATCH**

| Tipo | Quando Usar | Exemplo |
|------|-------------|---------|
| **MAJOR** | Mudanças incompatíveis | 1.0.0 → 2.0.0 |
| **MINOR** | Novas funcionalidades compatíveis | 1.0.0 → 1.1.0 |
| **PATCH** | Correções de bugs | 1.0.0 → 1.0.1 |

### 🎯 **Exemplos de Versionamento**

| Versão | Descrição |
|--------|-----------|
| **v1.0.0** | Primeira versão estável |
| **v1.0.1** | Correção de bug crítico |
| **v1.1.0** | Nova funcionalidade (notificações) |
| **v1.1.1** | Correção de bug menor |
| **v2.0.0** | Mudança incompatível (nova arquitetura) |

---

## 🔒 Proteções de Branch

### 🛡️ **Branch Protection Rules**

#### **main**
- ✅ Require pull request reviews
- ✅ Require status checks to pass
- ✅ Require branches to be up to date
- ✅ Restrict pushes to matching branches
- ✅ Require linear history

#### **develop**
- ✅ Require pull request reviews
- ✅ Require status checks to pass
- ✅ Require branches to be up to date

### 👥 **Code Review Policy**

| Branch | Revisores Obrigatórios | Aprovações Necessárias |
|--------|----------------------|------------------------|
| **main** | Tech Lead + Senior Dev | 2 aprovações |
| **develop** | Senior Dev | 1 aprovação |
| **feature/** | Peer Review | 1 aprovação |

---

## 🚀 CI/CD Pipeline

### 🔄 **Workflow de Build**

```yaml
# .github/workflows/build.yml
name: Build and Test

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.8.0'
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --debug
```

### 📱 **Deploy Automático**

| Branch | Ambiente | Trigger |
|--------|----------|---------|
| **main** | Produção | Push + Tag |
| **develop** | Staging | Push |
| **feature/** | Test | Pull Request |

---

## 📊 Métricas e Relatórios

### 📈 **Métricas de Git**

| Métrica | Descrição | Ferramenta |
|---------|-----------|------------|
| **Commits por dia** | Produtividade da equipe | GitHub Insights |
| **Pull Requests** | Volume de mudanças | GitHub Analytics |
| **Code Review Time** | Tempo de revisão | GitHub Insights |
| **Deploy Frequency** | Frequência de deploys | GitHub Actions |

### 📋 **Relatórios Semanais**

- **Commits por desenvolvedor**
- **Pull Requests abertos/fechados**
- **Bugs encontrados em produção**
- **Tempo médio de code review**

---

## 🛠️ Ferramentas e Integrações

### 🔧 **Ferramentas Utilizadas**

| Ferramenta | Propósito |
|------------|-----------|
| **GitHub** | Repositório e colaboração |
| **GitHub Actions** | CI/CD |
| **GitHub Issues** | Rastreamento de bugs |
| **GitHub Projects** | Gestão de projeto |
| **SonarQube** | Análise de qualidade |
| **Codecov** | Cobertura de testes |

### 🔗 **Integrações**

- **Slack**: Notificações de commits e deploys
- **Jira**: Integração com gestão de projeto
- **Firebase**: Deploy automático
- **Google Play**: Upload automático de APK

---

## 📚 Documentação Versionada

### 📖 **Estrutura de Documentação**

```
docs/
├── v1.0.0/
│   ├── ARCHITECTURE.md
│   ├── API.md
│   └── USER_GUIDE.md
├── v1.1.0/
│   ├── ARCHITECTURE.md
│   ├── API.md
│   └── USER_GUIDE.md
└── latest/
    ├── ARCHITECTURE.md
    ├── API.md
    └── USER_GUIDE.md
```

### 🔄 **Versionamento de Docs**

- **Cada release** tem sua documentação versionada
- **Branch `docs`** para documentação em desenvolvimento
- **Sincronização** automática com releases
- **Changelog** detalhado para cada versão

---

## 🎯 Boas Práticas

### ✅ **Do's**

- ✅ **Commits pequenos e focados**
- ✅ **Mensagens descritivas**
- ✅ **Code review obrigatório**
- ✅ **Testes antes do merge**
- ✅ **Branch naming consistente**
- ✅ **Documentação atualizada**

### ❌ **Don'ts**

- ❌ **Commits diretos em main/develop**
- ❌ **Mensagens de commit vagas**
- ❌ **Merge sem code review**
- ❌ **Commits quebram build**
- ❌ **Branches com nomes confusos**
- ❌ **Documentação desatualizada**

---

## 🆘 Troubleshooting

### 🔧 **Problemas Comuns**

#### **Merge Conflicts**
```bash
# Resolver conflitos
git checkout feature/minha-feature
git rebase develop
# Resolver conflitos manualmente
git add .
git rebase --continue
```

#### **Branch Desatualizada**
```bash
# Atualizar branch local
git checkout develop
git pull origin develop
git checkout feature/minha-feature
git rebase develop
```

#### **Commit Errado**
```bash
# Desfazer último commit (mantendo mudanças)
git reset --soft HEAD~1

# Desfazer último commit (perdendo mudanças)
git reset --hard HEAD~1
```

---

## 📞 Suporte e Contatos

### 👥 **Equipe Git**

| Função | Responsável | Contato |
|--------|-------------|---------|
| **Git Administrator** | Tech Lead | tech.lead@eurofarma.com.br |
| **Code Review Lead** | Senior Developer | senior.dev@eurofarma.com.br |
| **CI/CD Manager** | DevOps Engineer | devops@eurofarma.com.br |

### 📚 **Recursos**

- **Documentação GitHub**: [Link interno]
- **Tutorial Git Flow**: [Link interno]
- **Code Review Guidelines**: [Link interno]
- **CI/CD Documentation**: [Link interno]

---

*Este documento é propriedade da Eurofarma e deve ser atualizado conforme evolução do projeto.*
