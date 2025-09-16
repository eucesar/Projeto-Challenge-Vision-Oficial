import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'models/project.dart';
import 'services/project_storage_service.dart';
import 'services/auth_service.dart';
import 'test_firebase_connection.dart';
import 'widgets/animated_screen_wrapper.dart';
import 'screens/splash_screen.dart';

void main() async {
  // Garante que o Flutter esteja inicializado antes de usar plugins.
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print('🔥 FIREBASE: Iniciando teste de conexão...');
    await testFirebaseConnectionDetailed();
    print('✅ FIREBASE: Teste de conexão concluído com sucesso!');
  } catch (e) {
    print('❌ FIREBASE: Erro na inicialização do Firebase: $e');
    print('❌ FIREBASE: Tipo do erro: ${e.runtimeType}');
    if (e is FirebaseException) {
      print('❌ FIREBASE: Código do erro: ${e.code}');
      print('❌ FIREBASE: Mensagem: ${e.message}');
    }
    // Continuar mesmo com erro para não quebrar o app
  }

  // Inicializa o Hive
  await Hive.initFlutter();
  print('🚀 HIVE: Hive inicializado com sucesso!');

  // Registra o adapter do Project
  Hive.registerAdapter(ProjectAdapter());
  print('📦 HIVE: ProjectAdapter registrado!');

  // Inicializa o serviço de armazenamento
  await ProjectStorageService.init();
  print('💾 STORAGE: ProjectStorageService inicializado!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Challenge Vision',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: AppStartupAnimation(
        child: StreamBuilder(
          stream: AuthService().authStateChanges,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print('🔍 APP: StreamBuilder está no estado: WAITING');
              return const Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              );
            }

            if (snapshot.hasData) {
              print(
                '✅ APP: StreamBuilder tem dados! Usuário logado: ${AuthService().currentUser?.email}',
              );
              // Usuário logado - ir para Splash que decidirá se mostra sucesso ou vai direto para Home
              return const SplashScreen();
            } else {
              print('❌ APP: StreamBuilder NÃO tem dados. Usuário não logado.');
              // Usuário não logado - ir para Login
              return const AnimatedScreenWrapper(child: LoginScreen());
            }
          },
        ),
      ),
      routes: {
        '/home': (context) => const AnimatedScreenWrapper(child: HomeScreen()),
        '/login': (context) => const AnimatedScreenWrapper(child: LoginScreen()),
        '/splash': (context) => const SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ... existing  code ...
