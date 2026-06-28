import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> initSupabase() async {
  await Supabase.initialize(
    url: 'https://wjxuryryznlawnpbfxdo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndqeHVyeXJ5em5sYXducGJmeGRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODI1NzQyODIsImV4cCI6MjA5ODE1MDI4Mn0.GZaaNaBBtzvi207pUUT0XucUi2XpOhMOD4Fj4mz0AJI',
  );
}

final supabase = Supabase.instance.client;
