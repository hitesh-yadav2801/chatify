import 'package:chatify/auth/presentation/blocs/auth_bloc.dart';
import 'package:chatify/auth/presentation/pages/login_page.dart';
import 'package:chatify/chat/presentation/pages/web_chat_page.dart';
import 'package:chatify/core/common/widgets/loader.dart';
import 'package:chatify/core/utils/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailureState) {
          showSnackBar(context, state.message);
        } else if (state is AuthLogoutSuccessState) {
          Navigator.pushAndRemoveUntil(context, LoginPage.route(), (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return const Loader();
        }
        return WebChatPage();

      },
    );
  }
}
