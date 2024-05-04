import 'package:chatify/auth/presentation/blocs/auth_bloc.dart';
import 'package:chatify/auth/presentation/pages/login_page.dart';
import 'package:chatify/chat/presentation/pages/mobile_chat_room_page.dart';
import 'package:chatify/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:chatify/core/home/mobile_home_page.dart';
import 'package:chatify/core/home/responsive_home_layout.dart';
import 'package:chatify/core/home/web_home_page.dart';
import 'package:chatify/core/theme/app_theme.dart';
import 'package:chatify/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedInEvent());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatify',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedInState;
        },
        builder: (context, isLoggedIn) {
          if (isLoggedIn) {
            return const HomePage();
          }
          return const ResponsiveHomeLayout(mobileScreenLayout: HomePage(), webScreenLayout: WebHomePage());
        },
      ),
    );
  }
}
