import 'package:chatify/auth/data/remote/data_sources/auth_remote_data_source.dart';
import 'package:chatify/auth/data/repositories/auth_repository_impl.dart';
import 'package:chatify/auth/domain/repositories/auth_repository.dart';
import 'package:chatify/auth/domain/usecases/current_user.dart';
import 'package:chatify/auth/domain/usecases/user_login.dart';
import 'package:chatify/auth/domain/usecases/user_signout.dart';
import 'package:chatify/auth/domain/usecases/user_signup.dart';
import 'package:chatify/auth/presentation/blocs/auth_bloc.dart';
import 'package:chatify/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:chatify/core/network/connection_checker.dart';
import 'package:chatify/core/secrets/app_secrets.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies_main.dart';