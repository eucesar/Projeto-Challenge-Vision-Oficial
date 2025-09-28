import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:challenge_vision/config/ai_config.dart';

/// Serviço para gerenciar a API do Gemini com fallbacks e tratamento de erros
class GeminiApiService {
  static const String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models";
  
  // Lista de modelos para tentar em ordem de preferência
  static const List<String> _fallbackModels = [
    "gemini-2.0-flash",
    "gemini-2.0-flash-001",
    "gemini-2.5-flash",
    "gemini-flash-latest",
    "gemini-1.5-flash",
    "gemini-1.5-pro", 
    "gemini-pro-latest",
  ];
  
  /// Testa a conectividade com a API do Gemini
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?key=${AIConfig.geminiApiKey}"),
        headers: {"Content-Type": "application/json"},
      );
      
      return response.statusCode == 200;
    } catch (e) {
      print("Erro ao testar conexão: $e");
      return false;
    }
  }
  
  /// Lista modelos disponíveis
  static Future<List<String>> getAvailableModels() async {
    try {
      final response = await http.get(
        Uri.parse("$_baseUrl?key=${AIConfig.geminiApiKey}"),
        headers: {"Content-Type": "application/json"},
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final models = <String>[];
        
        if (data["models"] != null) {
          for (var model in data["models"]) {
            final name = model["name"];
            final methods = model["supportedGenerationMethods"] ?? [];
            if (methods.contains("generateContent")) {
              models.add(name);
            }
          }
        }
        
        return models;
      }
    } catch (e) {
      print("Erro ao listar modelos: $e");
    }
    
    return [];
  }
  
  /// Envia uma mensagem para a API do Gemini com fallback automático
  static Future<GeminiResponse> sendMessage({
    required String message,
    String? conversationHistory,
    Map<String, dynamic>? additionalContext,
  }) async {
    // Primeiro, tenta encontrar um modelo funcionando
    final availableModels = await getAvailableModels();
    String? workingModel;
    
    // Procura por um modelo conhecido que está disponível
    for (String fallbackModel in _fallbackModels) {
      if (availableModels.contains("models/$fallbackModel") || 
          availableModels.contains(fallbackModel)) {
        workingModel = fallbackModel;
        break;
      }
    }
    
    // Se não encontrou nenhum, usa o modelo padrão
    workingModel ??= AIConfig.geminiModel;
    
    return await _sendWithModel(
      model: workingModel,
      message: message,
      conversationHistory: conversationHistory,
      additionalContext: additionalContext,
    );
  }
  
  /// Envia mensagem com um modelo específico
  static Future<GeminiResponse> _sendWithModel({
    required String model,
    required String message,
    String? conversationHistory,
    Map<String, dynamic>? additionalContext,
  }) async {
    final String apiUrl = "$_baseUrl/$model:generateContent?key=${AIConfig.geminiApiKey}";
    
    try {
      // Construir o prompt contextualizado
      final String fullPrompt = _buildContextualPrompt(
        message: message,
        conversationHistory: conversationHistory,
        additionalContext: additionalContext,
      );
      
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {"text": fullPrompt}
              ]
            }
          ],
          "generationConfig": {
            "temperature": 0.7,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 2048,
          }
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        
        if (data["candidates"] != null && data["candidates"].isNotEmpty) {
          final candidate = data["candidates"][0];
          
          if (candidate["content"] != null && candidate["content"]["parts"] != null) {
            final text = candidate["content"]["parts"][0]["text"];
            
            return GeminiResponse(
              success: true,
              message: _cleanResponse(text),
              model: model,
              usage: data["usageMetadata"],
            );
          }
        }
        
        return GeminiResponse(
          success: false,
          message: "Resposta da API em formato inesperado",
          error: "Unexpected response format",
          model: model,
        );
      } else {
        final errorData = jsonDecode(response.body);
        final errorMessage = errorData["error"]["message"] ?? "Erro desconhecido";
        
        return GeminiResponse(
          success: false,
          message: "Erro na API: ${response.statusCode}",
          error: errorMessage,
          model: model,
          statusCode: response.statusCode,
        );
      }
      
    } catch (e) {
      return GeminiResponse(
        success: false,
        message: "Erro na requisição: $e",
        error: e.toString(),
        model: model,
      );
    }
  }
  
  /// Constrói prompt contextualizado
  static String _buildContextualPrompt({
    required String message,
    String? conversationHistory,
    Map<String, dynamic>? additionalContext,
  }) {
    final buffer = StringBuffer();
    
    // Cabeçalho
    buffer.writeln("=== CHALLENGEMIND - ASSISTENTE DO CHALLENGE VISION ===");
    buffer.writeln("Aplicativo: Challenge Vision");
    buffer.writeln("Assistente: ChallengeMind");
    buffer.writeln("Empresa: Eurofarma");
    buffer.writeln("Data/Hora: ${DateTime.now().toIso8601String()}");
    buffer.writeln();
    
    // Histórico de conversas
    if (conversationHistory != null && conversationHistory.isNotEmpty) {
      buffer.writeln("=== HISTÓRICO DE CONVERSAS ===");
      buffer.writeln(conversationHistory);
      buffer.writeln();
    }
    
    // Contexto adicional
    if (additionalContext != null && additionalContext.isNotEmpty) {
      buffer.writeln("=== CONTEXTO ADICIONAL ===");
      additionalContext.forEach((key, value) {
        buffer.writeln("$key: $value");
      });
      buffer.writeln();
    }
    
    // Instruções
    buffer.writeln("=== INSTRUÇÕES ===");
    buffer.writeln("1. Você é o ChallengeMind, assistente do aplicativo Challenge Vision");
    buffer.writeln("2. Responda de forma clara, objetiva e acionável");
    buffer.writeln("3. Use linguagem profissional mas acessível");
    buffer.writeln("4. Foque nos objetivos estratégicos da Eurofarma");
    buffer.writeln("5. Seja proativo em identificar riscos e oportunidades");
    buffer.writeln("6. Se identifique como ChallengeMind APENAS quando questionado diretamente sobre quem você é");
    buffer.writeln("7. Em conversas normais, seja natural e direto, sem mencionar seu nome constantemente");
    buffer.writeln();
    
    // Pergunta do usuário
    buffer.writeln("=== PERGUNTA DO USUÁRIO ===");
    buffer.writeln(message);
    
    return buffer.toString();
  }
  
  /// Limpa formatação problemática das respostas
  static String _cleanResponse(String response) {
    // Remove múltiplos asteriscos repetitivos
    response = response.replaceAll(RegExp(r'\*{3,}'), '');
    
    // Remove backticks com asteriscos
    response = response.replaceAll(RegExp(r'`\*+'), '');
    response = response.replaceAll(RegExp(r'\*+`'), '');
    
    // Remove asteriscos isolados no início de linhas
    response = response.replaceAll(RegExp(r'^\s*\*+\s*', multiLine: true), '');
    
    // Remove formatação markdown problemática
    response = response.replaceAll(RegExp(r'\*{2,}'), '');
    
    // Limpa espaços extras
    response = response.replaceAll(RegExp(r'\n\s*\n\s*\n'), '\n\n');
    
    // Remove linhas vazias excessivas
    response = response.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    
    return response.trim();
  }
}

/// Classe para representar a resposta da API do Gemini
class GeminiResponse {
  final bool success;
  final String message;
  final String? error;
  final String model;
  final int? statusCode;
  final Map<String, dynamic>? usage;
  
  GeminiResponse({
    required this.success,
    required this.message,
    this.error,
    required this.model,
    this.statusCode,
    this.usage,
  });
  
  @override
  String toString() {
    return 'GeminiResponse(success: $success, message: $message, error: $error, model: $model)';
  }
}
