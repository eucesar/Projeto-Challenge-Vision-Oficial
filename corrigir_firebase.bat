@echo off
echo ========================================
echo CORRIGINDO PERMISSÕES DO FIREBASE
echo ========================================

echo.
echo 🔍 Verificando se o Firebase CLI está instalado...
firebase --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Firebase CLI não encontrado!
    echo.
    echo 📥 Para instalar o Firebase CLI:
    echo    npm install -g firebase-tools
    echo.
    echo 🔑 Depois execute: firebase login
    echo.
    echo ⚠️  ALTERNATIVA: Use o guia manual em GUIA_CORRIGIR_FIREBASE.md
    echo.
    pause
    exit /b 1
)

echo ✅ Firebase CLI encontrado!

echo.
echo 🔍 Verificando se está logado no Firebase...
firebase projects:list >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Não está logado no Firebase!
    echo.
    echo 🔑 Execute: firebase login
    echo.
    echo ⚠️  ALTERNATIVA: Use o guia manual em GUIA_CORRIGIR_FIREBASE.md
    echo.
    pause
    exit /b 1
)

echo ✅ Logado no Firebase!

echo.
echo 🔍 Verificando se o projeto está configurado...
firebase use --add >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Projeto não configurado!
    echo.
    echo ⚠️  ALTERNATIVA: Use o guia manual em GUIA_CORRIGIR_FIREBASE.md
    echo.
    pause
    exit /b 1
)

echo ✅ Projeto configurado!

echo.
echo 🚀 Fazendo deploy das regras do Firestore...
firebase deploy --only firestore:rules

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo ✅ DEPLOY CONCLUÍDO COM SUCESSO!
    echo ========================================
    echo.
    echo 🎉 As regras do Firestore foram atualizadas!
    echo 🔥 Agora o aplicativo deve conseguir acessar o Firebase.
    echo.
    echo 🧪 Teste o aplicativo para verificar se a sincronização funciona.
    echo.
) else (
    echo.
    echo ========================================
    echo ❌ ERRO NO DEPLOY
    echo ========================================
    echo.
    echo ⚠️  Use o guia manual em GUIA_CORRIGIR_FIREBASE.md
    echo.
)

pause

