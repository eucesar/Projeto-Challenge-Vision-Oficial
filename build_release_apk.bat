@echo off
echo ========================================
echo GERANDO APK DE RELEASE PARA INSTALAÇÃO
echo ========================================

echo.
echo 1. Limpando projeto...
flutter clean

echo.
echo 2. Obtendo dependências...
flutter pub get

echo.
echo 3. Regenerando adapters...
flutter packages pub run build_runner build --delete-conflicting-outputs

echo.
echo 4. Gerando APK de release (otimizado)...
flutter build apk --release

echo.
echo ========================================
echo APK DE RELEASE GERADO COM SUCESSO!
echo Localização: build\app\outputs\flutter-apk\app-release.apk
echo ========================================
echo.
echo INSTRUÇÕES PARA INSTALAÇÃO NO CELULAR:
echo 1. Copie o arquivo app-release.apk para seu celular
echo 2. No celular, vá em Configurações > Segurança
echo 3. Ative "Fontes desconhecidas" ou "Instalar apps desconhecidos"
echo 4. Abra o arquivo APK no celular
echo 5. Toque em "Instalar"
echo 6. Aguarde a instalação e abra o app
echo ========================================
pause

