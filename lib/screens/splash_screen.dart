import 'package:flutter/material.dart';
import 'package:challenge_vision/services/auth_service.dart';
import 'package:challenge_vision/screens/login_success_animation_screen.dart';
import 'package:challenge_vision/home_screen.dart';
import 'package:challenge_vision/login_screen.dart';
import 'package:challenge_vision/widgets/animated_screen_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Aguardar um pouco para mostrar o splash
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (!mounted) return;

    // Verificar se o usuário está logado
    final user = _authService.currentUser;
    
    if (user != null) {
      // Usuário está logado - sempre mostrar animação de sucesso
      print('🎉 SPLASH: Usuário logado, mostrando animação de sucesso');
      
      // Navegar para a tela de sucesso
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginSuccessAnimationScreen(),
        ),
      );
    } else {
      // Usuário não está logado - ir para login
      print('🔐 SPLASH: Usuário não logado, indo para tela de login');
      
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const AnimatedScreenWrapper(child: LoginScreen()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo da aplicação
            Container(
              width: isTablet ? 120 : 100,
              height: isTablet ? 120 : 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF4CAF50),
                    Color(0xFF2E7D32),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: const Icon(
                Icons.rocket_launch,
                color: Colors.white,
                size: 50,
              ),
            ),
            
            SizedBox(height: isTablet ? 40 : 30),
            
            // Nome da aplicação
            Text(
              'Challenge Vision',
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet ? 32 : 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            
            SizedBox(height: isTablet ? 20 : 15),
            
            // Subtítulo
            Text(
              'Gerenciamento Inteligente de Projetos',
              style: TextStyle(
                color: Colors.white70,
                fontSize: isTablet ? 18 : 16,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: isTablet ? 60 : 50),
            
            // Indicador de carregamento
            const CircularProgressIndicator(
              color: Colors.green,
              strokeWidth: 3,
            ),
            
            SizedBox(height: isTablet ? 30 : 20),
            
            // Texto de carregamento
            Text(
              'Carregando...',
              style: TextStyle(
                color: Colors.white60,
                fontSize: isTablet ? 16 : 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
