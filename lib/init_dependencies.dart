import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:jottly/Core/Secret/supabase_secret.dart';
import 'package:jottly/Core/common/cubits/app_user/app_user_cubit.dart';
import 'package:jottly/Core/network/connection_checker.dart';
import 'package:jottly/Core/usecase/usecase.dart';
import 'package:jottly/Features/auth/Data/DataSources/auth_remote_data_sources.dart';
import 'package:jottly/Features/auth/Data/repository/auth_repository_imp.dart';
import 'package:jottly/Features/auth/Domain/repository/auth_repository.dart';
import 'package:jottly/Features/auth/Domain/usecases/current_user.dart';
import 'package:jottly/Features/auth/Domain/usecases/user_login.dart';
import 'package:jottly/Features/auth/Domain/usecases/user_sign_up.dart';
import 'package:jottly/Features/auth/Presentation/bloc/auth_bloc.dart';
import 'package:jottly/Features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:jottly/Features/blog/data/local_data_source/blog_local_data_source.dart';
import 'package:jottly/Features/blog/data/repository/blog_repository_imp.dart';
import 'package:jottly/Features/blog/domain/repository/blog_repository.dart';
import 'package:jottly/Features/blog/domain/usecases/get_all_blogs.dart';
import 'package:jottly/Features/blog/domain/usecases/upload_blog.dart';
import 'package:jottly/Features/blog/presentation/bloc/blog_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependencies.main.dart';