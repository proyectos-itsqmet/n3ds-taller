import 'package:n3ds_taller/models/destino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DestinoService {
  final _supabase = Supabase.instance.client;

  Future<List<Destino>> listar() async {
    final data = await _supabase.from('destinos').select();

    return (data as List).map((i) => Destino.fromJson(i)).toList();
  }
}
