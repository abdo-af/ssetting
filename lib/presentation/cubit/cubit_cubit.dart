import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories.dart';


class SettingsCubit extends Cubit<bool> {
  final SettingsRepository repo;

  SettingsCubit(this.repo) : super(false);

  Future<void> loadTheme() async {
    final isDark = await repo.getTheme();
    emit(isDark);
  }

  Future<void> toggleTheme(bool value) async {
    await repo.setTheme(value);
    emit(value);
  }
}
