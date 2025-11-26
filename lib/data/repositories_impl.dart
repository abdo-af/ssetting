import 'package:ssetting/data/datasources.dart';

import '../domain/repositories.dart';



class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDS;

  SettingsRepositoryImpl(this.localDS);

  @override
  Future<bool> getTheme() => localDS.getTheme();

  @override
  Future<void> setTheme(bool isDark) => localDS.setTheme(isDark);
}
