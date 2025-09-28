# 🔥 GUIA: Corrigir Permissões do Firebase

## ❌ Problema Atual
```
❌ SYNC: Erro ao baixar projetos: [cloud_firestore/permission-denied] Missing or insufficient permissions.
```

## ✅ Solução: Aplicar Regras do Firestore

### 📋 Passo 1: Acessar o Console do Firebase
1. Abra o navegador e vá para: https://console.firebase.google.com/
2. Faça login com sua conta Google
3. Selecione o projeto: **eurofarmaproject**

### 📋 Passo 2: Configurar Regras do Firestore
1. No menu lateral, clique em **"Firestore Database"**
2. Clique na aba **"Regras"** (Rules)
3. Substitua o conteúdo atual por:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Regras para projetos do usuário
    match /users/{userId}/projects/{projectId} {
      // Permitir leitura e escrita apenas para o usuário autenticado
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Regras para dados do usuário
    match /users/{userId} {
      // Permitir leitura e escrita apenas para o usuário autenticado
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Regras para conversas do usuário
    match /users/{userId}/conversations/{conversationId} {
      // Permitir leitura e escrita apenas para o usuário autenticado
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Regras para histórico de conversas
    match /users/{userId}/conversation_history/{historyId} {
      // Permitir leitura e escrita apenas para o usuário autenticado
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### 📋 Passo 3: Publicar as Regras
1. Clique no botão **"Publicar"** (Publish)
2. Confirme a publicação
3. Aguarde a confirmação de sucesso

### 📋 Passo 4: Verificar Configuração
1. Vá para a aba **"Dados"** (Data)
2. Verifique se a estrutura está correta:
   ```
   users/
     └── [userId]/
         ├── projects/
         │   └── [projectId]
         ├── conversations/
         │   └── [conversationId]
         └── conversation_history/
             └── [historyId]
   ```

## 🧪 Teste a Correção
1. Execute o aplicativo novamente
2. Verifique se não há mais erros de permissão
3. Teste a sincronização de projetos

## 🔍 Logs Esperados (Após Correção)
```
✅ SYNC: Conexão com Firestore funcionando!
✅ SYNC: X projetos baixados da nuvem
✅ SYNC: Sincronização concluída
```

## 🆘 Se Ainda Houver Problemas
1. Verifique se o usuário está logado no app
2. Confirme que o projeto Firebase está correto
3. Verifique se as regras foram publicadas com sucesso
4. Teste com um usuário diferente

## 📞 Suporte
Se precisar de ajuda, verifique:
- Console do Firebase: https://console.firebase.google.com/
- Documentação: https://firebase.google.com/docs/firestore/security/get-started

