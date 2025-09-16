import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> testFirebaseConnectionDetailed() async {
  try {
    print('🔥 TESTE DETALHADO: Iniciando teste completo do Firebase...');
    
    // 1. Inicializar Firebase
    print('🔥 TESTE: Inicializando Firebase...');
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('✅ TESTE: Firebase inicializado com sucesso!');

    // 2. Testar autenticação
    print('🔥 TESTE: Testando autenticação...');
    final auth = FirebaseAuth.instance;
    print('✅ TESTE: FirebaseAuth instanciado');
    
    // Verificar se há usuário logado
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      print('✅ TESTE: Usuário logado: ${currentUser.email}');
      print('✅ TESTE: UID: ${currentUser.uid}');
    } else {
      print('⚠️ TESTE: Nenhum usuário logado');
    }

    // 3. Testar Firestore
    print('🔥 TESTE: Testando Firestore...');
    final firestore = FirebaseFirestore.instance;
    print('✅ TESTE: Firestore instanciado');

    // 4. Teste de leitura
    print('🔥 TESTE: Testando leitura do Firestore...');
    try {
      final testCollection = firestore.collection('test');
      final snapshot = await testCollection.limit(1).get();
      print('✅ TESTE: Leitura do Firestore funcionando!');
      print('✅ TESTE: Documentos encontrados: ${snapshot.docs.length}');
    } catch (e) {
      print('❌ TESTE: Erro na leitura: $e');
    }

    // 5. Teste de escrita (se usuário estiver logado)
    if (currentUser != null) {
      print('🔥 TESTE: Testando escrita no Firestore...');
      try {
        final testDoc = firestore.collection('test').doc('connection_test');
        await testDoc.set({
          'timestamp': FieldValue.serverTimestamp(),
          'user_id': currentUser.uid,
          'test': 'Firebase connection test',
          'status': 'success'
        });
        print('✅ TESTE: Escrita no Firestore funcionando!');
        
        // Ler o documento que acabamos de escrever
        final doc = await testDoc.get();
        if (doc.exists) {
          print('✅ TESTE: Documento criado e lido com sucesso!');
          print('✅ TESTE: Dados: ${doc.data()}');
        }
      } catch (e) {
        print('❌ TESTE: Erro na escrita: $e');
      }
    }

    // 6. Teste específico da coleção de projetos
    if (currentUser != null) {
      print('🔥 TESTE: Testando acesso à coleção de projetos...');
      try {
        final projectsCollection = firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('projects');
        
        final projectsSnapshot = await projectsCollection.limit(1).get();
        print('✅ TESTE: Acesso à coleção de projetos funcionando!');
        print('✅ TESTE: Projetos encontrados: ${projectsSnapshot.docs.length}');
        
        // Teste de escrita na coleção de projetos
        print('🔥 TESTE: Testando escrita na coleção de projetos...');
        final testProject = projectsCollection.doc('test_project');
        await testProject.set({
          'name': 'Teste de Conexão',
          'category': 'Teste',
          'status': 'Em Andamento',
          'created_at': FieldValue.serverTimestamp(),
          'test': true
        });
        print('✅ TESTE: Escrita na coleção de projetos funcionando!');
        
        // Limpar o documento de teste
        await testProject.delete();
        print('✅ TESTE: Documento de teste removido');
        
      } catch (e) {
        print('❌ TESTE: Erro na coleção de projetos: $e');
        print('❌ TESTE: Tipo do erro: ${e.runtimeType}');
        if (e is FirebaseException) {
          print('❌ TESTE: Código do erro: ${e.code}');
          print('❌ TESTE: Mensagem: ${e.message}');
        }
      }
    }

    print('🎉 TESTE: Teste completo do Firebase finalizado!');
    
  } catch (e) {
    print('❌ TESTE: Erro geral no teste do Firebase: $e');
    print('❌ TESTE: Tipo do erro: ${e.runtimeType}');
    if (e is FirebaseException) {
      print('❌ TESTE: Código do erro: ${e.code}');
      print('❌ TESTE: Mensagem: ${e.message}');
    }
    rethrow;
  }
}

