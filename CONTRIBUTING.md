# Contributing to Challenge Vision

Obrigado por considerar contribuir com o Challenge Vision! Este documento fornece diretrizes para contribuições ao projeto.

## 📋 Código de Conduta

Este projeto segue o [Código de Conduta da Eurofarma](CODE_OF_CONDUCT.md). Ao participar, você concorda em manter este código.

## 🚀 Como Contribuir

### 1. **Fork e Clone**
```bash
# Fork o repositório no GitHub
# Clone seu fork
git clone https://github.com/SEU_USUARIO/challenge-vision.git
cd challenge-vision
```

### 2. **Configurar Ambiente**
```bash
# Instalar dependências
flutter pub get

# Executar testes
flutter test

# Verificar análise de código
flutter analyze
```

### 3. **Criar Branch**
```bash
# Criar branch para sua feature
git checkout -b feature/nova-funcionalidade

# Ou para correção de bug
git checkout -b bugfix/correcao-bug
```

### 4. **Desenvolver**
- Siga as [Diretrizes de Código](#diretrizes-de-código)
- Escreva testes para novas funcionalidades
- Atualize documentação quando necessário
- Mantenha commits pequenos e focados

### 5. **Testar**
```bash
# Executar todos os testes
flutter test

# Executar análise de código
flutter analyze

# Executar testes de integração
flutter test integration_test/
```

### 6. **Commit**
```bash
# Seguir convenção de commits
git commit -m "feat(auth): adiciona login com Firebase"
```

### 7. **Push e Pull Request**
```bash
# Push da branch
git push origin feature/nova-funcionalidade

# Criar Pull Request no GitHub
```

## 📝 Diretrizes de Código

### **Flutter/Dart**
- Siga o [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Use `flutter analyze` para verificar código
- Mantenha cobertura de testes > 80%

### **Estrutura de Arquivos**
```
lib/
├── config/          # Configurações
├── models/          # Modelos de dados
├── services/        # Serviços de negócio
├── screens/         # Telas
├── widgets/         # Componentes reutilizáveis
└── utils/           # Utilitários
```

### **Nomenclatura**
- **Classes**: PascalCase (`ProjectService`)
- **Métodos**: camelCase (`getProjectById`)
- **Variáveis**: camelCase (`projectName`)
- **Constantes**: UPPER_SNAKE_CASE (`API_BASE_URL`)

### **Documentação**
- Documente métodos públicos
- Use comentários para lógica complexa
- Mantenha README atualizado

## 🧪 Testes

### **Testes Unitários**
```dart
// Exemplo de teste unitário
test('deve retornar projeto por ID', () async {
  final service = ProjectService();
  final project = await service.getProjectById('test-id');
  
  expect(project, isNotNull);
  expect(project!.id, equals('test-id'));
});
```

### **Testes de Widget**
```dart
// Exemplo de teste de widget
testWidgets('deve exibir nome do projeto', (tester) async {
  final project = Project(name: 'Test Project');
  
  await tester.pumpWidget(
    MaterialApp(home: ProjectCard(project: project)),
  );
  
  expect(find.text('Test Project'), findsOneWidget);
});
```

### **Testes de Integração**
```dart
// Exemplo de teste de integração
testWidgets('fluxo completo de login', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Testar fluxo completo
  await tester.enterText(find.byKey(Key('email')), 'test@test.com');
  await tester.enterText(find.byKey(Key('password')), 'password');
  await tester.tap(find.byKey(Key('login-button')));
  await tester.pumpAndSettle();
  
  expect(find.text('Dashboard'), findsOneWidget);
});
```

## 📋 Convenções de Commit

### **Formato**
```
<tipo>(<escopo>): <descrição>

[corpo opcional]

[rodapé opcional]
```

### **Tipos**
- **feat**: Nova funcionalidade
- **fix**: Correção de bug
- **docs**: Documentação
- **style**: Formatação
- **refactor**: Refatoração
- **test**: Testes
- **chore**: Build, dependências

### **Exemplos**
```bash
feat(auth): adiciona login com Firebase
fix(ui): corrige layout responsivo
docs(readme): atualiza instruções
test(project): adiciona testes unitários
```

## 🔍 Code Review

### **Checklist do Revisor**
- [ ] Código segue padrões estabelecidos
- [ ] Testes passam
- [ ] Documentação atualizada
- [ ] Performance adequada
- [ ] Segurança verificada

### **Checklist do Autor**
- [ ] Testes escritos e passando
- [ ] Análise de código limpa
- [ ] Documentação atualizada
- [ ] Commits bem descritos
- [ ] Branch atualizada

## 🐛 Reportando Bugs

### **Template de Bug Report**
```markdown
**Descrição**
Descrição clara do bug.

**Passos para Reproduzir**
1. Vá para '...'
2. Clique em '...'
3. Veja o erro

**Comportamento Esperado**
O que deveria acontecer.

**Comportamento Atual**
O que está acontecendo.

**Screenshots**
Se aplicável, adicione screenshots.

**Ambiente**
- Flutter: 3.8.0
- Dart: 3.8.0
- OS: Android/iOS
- Device: [modelo]

**Informações Adicionais**
Qualquer informação adicional relevante.
```

## 💡 Sugerindo Funcionalidades

### **Template de Feature Request**
```markdown
**Funcionalidade**
Descrição clara da funcionalidade.

**Problema que Resolve**
Qual problema esta funcionalidade resolve.

**Solução Proposta**
Como você imagina que deveria funcionar.

**Alternativas Consideradas**
Outras soluções que você considerou.

**Contexto Adicional**
Qualquer contexto adicional.
```

## 📚 Recursos

### **Documentação**
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Firebase Flutter](https://firebase.google.com/docs/flutter/setup)

### **Ferramentas**
- [Android Studio](https://developer.android.com/studio)
- [VS Code](https://code.visualstudio.com/)
- [Flutter Inspector](https://docs.flutter.dev/development/tools/flutter-inspector)

## 📞 Suporte

### **Canais de Comunicação**
- **Issues**: Use o sistema de issues do GitHub
- **Email**: dev-team@eurofarma.com.br
- **Slack**: #challenge-vision-dev

### **Horários de Suporte**
- **Segunda a Sexta**: 9h às 18h
- **Urgências**: 24/7 via email

## 🏆 Reconhecimento

Contribuidores serão reconhecidos em:
- README do projeto
- Release notes
- Documentação oficial

---

Obrigado por contribuir com o Challenge Vision! 🚀
