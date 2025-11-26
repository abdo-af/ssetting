import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/screens/settings_screen.dart';
import 'data/settings_local.dart';
import 'presentation/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsLocal = SettingsLocal();
  final settingsCubit = SettingsCubit(settingsLocal);
  await settingsCubit.loadAll();

  runApp(MyApp(cubit: settingsCubit));
}

class MyApp extends StatelessWidget {
  final SettingsCubit? cubit;

  const MyApp({Key? key, this.cubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providedCubit = cubit ?? SettingsCubit(SettingsLocal());

    return BlocProvider.value(
      value: providedCubit,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final bool isDark = state.isDark;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Hotel App',
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.black,
            ),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: SettingsScreen(
              isDarkMode: isDark,
              onToggleTheme: (value) =>
                  context.read<SettingsCubit>().toggleTheme(value),
            ),
          );
        },
      ),
    );
  }
}
