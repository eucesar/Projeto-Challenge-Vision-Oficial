@echo off
echo ========================================
echo DEPLOY DAS REGRAS DO FIRESTORE
echo ========================================

echo.
echo 1. Verificando se o Firebase CLI está instalado...
firebase --version
if %errorlevel% neq 0 (
    echo ❌ Firebase CLI não encontrado!
    echo.
    echo Para instalar o Firebase CLI:
    echo npm install -g firebase-tools
    echo.
    echo Depois execute: firebase login
    echo.
    pause
    exit /b 1
)

echo.
echo 2. Verificando se está logado no Firebase...
firebase projects:list
if %errorlevel% neq 0 (
    echo ❌ Não está logado no Firebase!
    echo.
    echo Execute: firebase login
    echo.
    pause
    exit /b 1
)

echo.
echo 3. Fazendo deploy das regras do Firestore...
firebase deploy --only firestore:rules

echo.
echo ========================================
echo DEPLOY CONCLUÍDO!
echo ========================================
echo.
echo As regras do Firestore foram atualizadas.
echo Agora o aplicativo deve conseguir acessar o Firebase.
echo.
pause

