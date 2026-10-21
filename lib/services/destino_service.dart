import 'package:n3ds_taller/models/destino.dart';
import 'package:n3ds_taller/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DestinoService {
  final _supabase = Supabase.instance.client;

  Future<List<Destino>> listar() async {
    final data = await _supabase.from('destinos').select();

    return (data as List).map((i) => Destino.fromJson(i)).toList();
  }

  Future<List<Destino>> buscarPorIdUsuario() async {
    final AuthService auth = AuthService();
    final String userId = auth.usuario!.id;

    final data = await _supabase
        .from('destinos_guardados')
        .select('destinos(*)')
        .eq('usuario_id', userId);

    return (data as List)
        .map((i) => Destino.fromJson(i['destinos'] as Map<String, dynamic>))
        .toList();
  }

  Future<bool> guardar(String destinoId) async {
    final AuthService auth = AuthService();
    final String userId = auth.usuario!.id;

    try {
      await _supabase.from('destinos_guardados').insert({
        'usuario_id': userId,
        'destino_id': destinoId,
      });

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> eliminar(String destinoId) async {
    final AuthService auth = AuthService();
    final String userId = auth.usuario!.id;

    try {
      await _supabase
          .from('destinos_guardados')
          .delete()
          .eq('usuario_id', userId)
          .eq('destino_id', destinoId);

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
