// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/tasks/data/datasources/firebase_datasource.dart'
    as _i633;
import '../../features/tasks/data/datasources/local_storage_datasource.dart'
    as _i585;
import '../../features/tasks/data/datasources/shared_pref_task_datasource.dart'
    as _i624;
import '../../features/tasks/data/datasources/sqlite_datasource.dart' as _i478;
import '../../features/tasks/data/datasources/task_datasource.dart' as _i407;
import '../../features/tasks/data/repositories/task_repository_impl.dart'
    as _i20;
import '../../features/tasks/domain/repositories/task_repository.dart' as _i148;
import '../../features/tasks/domain/usecases/add_task_usecase.dart' as _i693;
import '../../features/tasks/domain/usecases/delete_task_usecase.dart' as _i273;
import '../../features/tasks/domain/usecases/get_tasks_usecase.dart' as _i48;
import '../../features/tasks/presentation/bloc/task_bloc.dart' as _i841;
import '../services/notification_service.dart' as _i941;
import '../services/task_report_generator.dart' as _i64;
import '../services/task_validator.dart' as _i446;
import '../services/test_service.dart' as _i847;
import 'demo_service.dart' as _i14;
import 'external_module.dart' as _i489;

const String _sqlite = 'sqlite';
const String _dev = 'dev';
const String _firebase = 'firebase';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final externalModule = _$ExternalModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => externalModule.prefs,
      preResolve: true,
    );
    gh.factory<_i14.DemoService>(() => _i14.DemoService());
    gh.singleton<_i64.TaskReportGenerator>(() => _i64.TaskReportGenerator());
    gh.singleton<_i847.TestService>(() => _i847.TestService());
    gh.singleton<_i941.NotificationService>(() => _i941.NotificationService());
    gh.singleton<_i446.TaskValidator>(() => _i446.TaskValidator());
    gh.lazySingleton<_i407.TaskDataSource>(
      () => _i478.SQLiteDataSource(),
      registerFor: {_sqlite},
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i407.TaskDataSource>(
      () => _i585.MockTaskDataSource(),
      registerFor: {_dev},
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i407.TaskDataSource>(
      () => _i633.FirebaseDataSource(),
      registerFor: {_firebase},
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i407.TaskDataSource>(
      () => _i624.SharedPrefTaskDataSource(gh<_i460.SharedPreferences>()),
      registerFor: {_prod},
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i148.ITaskRepository>(
      () => _i20.TaskRepositoryImpl(gh<_i407.TaskDataSource>()),
    );
    gh.factory<_i693.AddTaskUseCase>(
      () => _i693.AddTaskUseCase(gh<_i148.ITaskRepository>()),
    );
    gh.factory<_i273.DeleteTaskUseCase>(
      () => _i273.DeleteTaskUseCase(gh<_i148.ITaskRepository>()),
    );
    gh.factory<_i48.GetTasksUseCase>(
      () => _i48.GetTasksUseCase(gh<_i148.ITaskRepository>()),
    );
    gh.factory<_i841.TaskBloc>(
      () => _i841.TaskBloc(
        gh<_i48.GetTasksUseCase>(),
        gh<_i693.AddTaskUseCase>(),
        gh<_i273.DeleteTaskUseCase>(),
        gh<_i446.TaskValidator>(),
        gh<_i941.NotificationService>(),
      ),
    );
    return this;
  }
}

class _$ExternalModule extends _i489.ExternalModule {}
