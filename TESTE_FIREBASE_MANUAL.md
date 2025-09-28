# 🔥 TESTE MANUAL DO FIREBASE

## 📱 **Para testar se o Firebase está funcionando:**

### 1. **Execute o aplicativo:**
```bash
flutter run -d windows --debug
```

### 2. **Faça login no aplicativo:**
- Use o email: `teste@exemplo.com`
- Use qualquer senha (o app está em modo de teste)

### 3. **Verifique os logs no terminal:**
Procure por estas mensagens:

#### ✅ **Se estiver funcionando:**
```
🔥 FIREBASE: Iniciando teste de conexão...
🔥 TESTE DETALHADO: Iniciando teste completo do Firebase...
✅ TESTE: Firebase inicializado com sucesso!
✅ TESTE: FirebaseAuth instanciado
✅ TESTE: Firestore instanciado
✅ TESTE: Conexão básica funcionando!
✅ TESTE: Escrita funcionando!
✅ TESTE: Acesso à coleção de projetos funcionando!
🎉 TESTE: Teste completo do Firebase finalizado!
```

#### ❌ **Se houver erro de permissão:**
```
❌ TESTE: Erro na coleção de projetos: [cloud_firestore/permission-denied] Missing or insufficient permissions.
❌ TESTE: Código do erro: permission-denied
❌ TESTE: Mensagem: Missing or insufficient permissions.
```

### 4. **Teste de funcionalidade:**
- Tente criar um novo projeto
- Tente editar um projeto existente
- Verifique se as alterações são salvas

### 5. **Se aparecer erro de permissão:**

#### **Solução Rápida:**
1. Acesse: https://console.firebase.google.com/
2. Selecione o projeto: **eurofarmaproject**
3. Vá em: **Firestore Database** → **Regras**
4. Substitua as regras por:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Regras temporárias mais permissivas
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

5. Clique em **"Publicar"**

### 6. **Teste novamente:**
- Execute o app novamente
- Faça login
- Tente criar/editar projetos
- Verifique se não há mais erros de permissão

## 🎯 **Resultado esperado:**
- ✅ App conecta ao Firebase
- ✅ Login funciona
- ✅ Projetos são salvos na nuvem
- ✅ Sincronização funciona
- ✅ Não há erros de permissão

## 📞 **Se ainda houver problemas:**
Me envie os logs completos do terminal para eu ajudar a resolver!

