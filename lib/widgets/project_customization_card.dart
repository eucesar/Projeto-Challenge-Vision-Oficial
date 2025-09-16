import 'package:flutter/material.dart';
import 'package:challenge_vision/models/project.dart';

class ProjectCustomizationCard extends StatelessWidget {
  final Project project;
  final bool isSelected;
  final VoidCallback onTap;

  const ProjectCustomizationCard({
    super.key,
    required this.project,
    required this.isSelected,
    required this.onTap,
  });

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'inovação':
        return Icons.lightbulb; // Lâmpada para inovação
      case 'pesquisa':
        return Icons.science; // Ciência para pesquisa
      case 'desenvolvimento':
        return Icons.code; // Código para desenvolvimento
      case 'melhoria':
        return Icons.trending_up; // Tendência de alta para melhoria
      default:
        return Icons.work; // Ícone padrão de trabalho
    }
  }

  Color _getStatusColor() {
    switch (project.status.toLowerCase()) {
      case 'pendente':
        return Colors.orange;
      case 'em andamento':
        return Colors.blue;
      case 'finalizado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Fev', 'Mar', 'Abr', 'Mai', 'Jun',
      'Jul', 'Ago', 'Set', 'Out', 'Nov', 'Dez'
    ];
    
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width > 600;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 280, // Altura fixa para evitar overflow
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected 
                ? [Colors.grey[600]!, Colors.grey[700]!, Colors.grey[800]!]
                : [Colors.grey[800]!, Colors.grey[900]!, Colors.black],
          ),
          borderRadius: BorderRadius.circular(isTablet ? 18 : 16),
          border: isSelected 
              ? Border.all(color: Colors.grey[400]!, width: 2)
              : Border.all(color: Colors.grey[600]!.withValues(alpha: 0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? Colors.grey.withValues(alpha: 0.4)
                  : Colors.black.withValues(alpha: 0.2),
              blurRadius: isSelected ? 12 : 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 16.0 : 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // Logo circular com ícone da categoria
              Center(
                child: Container(
                  width: isTablet ? 60 : 50,
                  height: isTablet ? 60 : 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isSelected 
                          ? [Colors.white.withValues(alpha: 0.2), Colors.white.withValues(alpha: 0.1)]
                          : [Colors.grey[600]!, Colors.grey[700]!],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _getCategoryIcon(project.category),
                      color: Colors.white,
                      size: isTablet ? 30 : 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Categoria
              Center(
                child: Text(
                  project.category,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 14 : 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              SizedBox(height: isTablet ? 6 : 4),

              // Nome do projeto
              Center(
                child: Text(
                  project.name,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: isTablet ? 12 : 11,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // Container com informações
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Categoria com ícone de triângulo
                      Row(
                        children: [
                          Icon(
                            Icons.change_history, // Ícone de triângulo
                            color: Colors.blue,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              project.category,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      // Data de conclusão com ícone de relógio
                      Row(
                        children: [
                          Icon(
                            Icons.access_time, // Ícone de relógio
                            color: Colors.orange,
                            size: 10,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Concluído: ${_formatDate(project.estimatedCompletionDate)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      
                      // Rating e interações
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 10),
                              const SizedBox(width: 2),
                              Text(
                                project.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.touch_app, color: Colors.purple, size: 10),
                              const SizedBox(width: 2),
                              Text(
                                '${project.interactions}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      // Status
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor().withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: _getStatusColor(),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: _getStatusColor(),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              project.status,
                              style: TextStyle(
                                color: _getStatusColor(),
                                fontSize: 8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Botão Escolher Projeto
              GestureDetector(
                onTap: onTap,
                child: Container(
                  width: double.infinity,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isSelected 
                          ? [Colors.red[400]!, Colors.red[600]!]
                          : [Colors.green[400]!, Colors.green[600]!],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: (isSelected ? Colors.red : Colors.green).withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isSelected ? Icons.close : Icons.check,
                          color: Colors.white,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isSelected ? 'Selecionado' : 'Escolher',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
