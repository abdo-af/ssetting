// lib/presentation/cubit/settings_cubit.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/settings_local.dart';

class SettingsState {
  final bool isDark;
  final File? imageFile;

  SettingsState({required this.isDark, this.imageFile});

  SettingsState copyWith({bool? isDark, File? imageFile}) {
    return SettingsState(
      isDark: isDark ?? this.isDark,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsLocal local;

  SettingsCubit(this.local) : super(SettingsState(isDark: false, imageFile: null));

  Future<void> loadAll() async {
    final isDark = await local.getTheme();
    final imgPath = await local.getImagePath();
    final file = (imgPath != null && File(imgPath).existsSync()) ? File(imgPath) : null;
    emit(SettingsState(isDark: isDark, imageFile: file));
  }

  Future<void> toggleTheme(bool value) async {
    await local.saveTheme(value);
    emit(state.copyWith(isDark: value));
  }

  Future<void> setImagePath(String path) async {
    await local.saveImagePath(path);
    final file = File(path);
    emit(state.copyWith(imageFile: file));
  }

  Future<void> clearImage() async {
    await local.clearImagePath();
    emit(state.copyWith(imageFile: null));
  }
}
