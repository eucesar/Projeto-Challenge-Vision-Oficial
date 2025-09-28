import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginSuccessAnimationScreen extends StatefulWidget {
  const LoginSuccessAnimationScreen({super.key});

  @override
  State<LoginSuccessAnimationScreen> createState() => _LoginSuccessAnimationScreenState();
}

class _LoginSuccessAnimationScreenState extends State<LoginSuccessAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particlesController;
  
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoRotationAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _textSlideAnimation;
  late Animation<double> _particlesAnimation;

  @override
  void initState() {
    super.initState();
    
    // Configurar controladores de animação
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _particlesController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Configurar animações
    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    _logoRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    ));

    _textSlideAnimation = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _particlesAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _particlesController,
      curve: Curves.easeInOut,
    ));

    // Iniciar animações sequencialmente
    _startAnimations();
  }

  void _startAnimations() async {
    // Vibrar o dispositivo
    HapticFeedback.lightImpact();
    
    // Iniciar animação do logo
    await _logoController.forward();
    
    // Pequena pausa
    await Future.delayed(const Duration(milliseconds: 300));
    
    // Iniciar animação do texto
    await _textController.forward();
    
    // Iniciar partículas
    _particlesController.forward();
    
    // Aguardar um pouco e navegar para a home
    await Future.delayed(const Duration(milliseconds: 2000));
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a1a),
              Color(0xFF2d2d2d),
              Color(0xFF1a1a1a),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Partículas animadas de fundo
            AnimatedBuilder(
              animation: _particlesAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlesPainter(_particlesAnimation.value),
                  size: Size.infinite,
                );
              },
            ),
            
            // Conteúdo principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animado
                  AnimatedBuilder(
                    animation: _logoController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Transform.rotate(
                          angle: _logoRotationAnimation.value * 0.1,
                          child: Container(
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
                              Icons.check_circle,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: isTablet ? 40 : 30),
                  
                  // Texto animado
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _textSlideAnimation.value),
                        child: Opacity(
                          opacity: _textFadeAnimation.value,
                          child: Column(
                            children: [
                              Text(
                                'Login realizado com sucesso!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isTablet ? 24 : 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Bem-vindo ao Challenge Vision',
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: isTablet ? 16 : 14,
                                  letterSpacing: 0.5,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  
                  SizedBox(height: isTablet ? 60 : 40),
                  
                  // Indicador de carregamento
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textFadeAnimation.value,
                        child: SizedBox(
                          width: isTablet ? 40 : 30,
                          height: isTablet ? 40 : 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.green.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe para desenhar partículas animadas
class ParticlesPainter extends CustomPainter {
  final double animationValue;
  
  ParticlesPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.withValues(alpha: 0.1 * animationValue)
      ..style = PaintingStyle.fill;

    // Desenhar partículas em posições aleatórias
    for (int i = 0; i < 20; i++) {
      final x = (i * 37.0) % size.width;
      final y = (i * 23.0) % size.height;
      final radius = (i % 3 + 1) * animationValue;
      
      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
