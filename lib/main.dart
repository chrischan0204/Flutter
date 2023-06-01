import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '/common_libraries.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await setupHydratedLocalStorage();
  runApp(TimerServiceProvider(
    service: TimerService(),
    child: RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBloc(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: const MyApp(),
      ),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String token = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        setState(() {
          token = state.authUser?.token ?? '';
        });
      },
      listenWhen: (previous, current) =>
          previous.authUser?.token != current.authUser?.token,
      builder: (context, state) {
        token = state.authUser?.token ?? '';
        return MultiRepositoryProvider(
          key: UniqueKey(),
          providers: [
            RepositoryProvider(
              create: (context) => RegionsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => PriorityLevelsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => ObservationTypesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => AwarenessGroupsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => AwarenessCategoriesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => SitesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => ProjectsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => CompaniesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => RolesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => SettingsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => TemplatesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => SectionsRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
              create: (context) => ResponseScalesRepository(
                token: token,
                authBloc: BlocProvider.of(context),
              ),
            ),
            RepositoryProvider(
                create: (context) => UsersRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
            RepositoryProvider(
                create: (context) => TimeZonesRepository(
                      token: token,
                      authBloc: BlocProvider.of(context),
                    )),
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ThemeBloc(),
              ),
              BlocProvider(
                create: (context) => FilterSettingBloc(
                  settingsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => ViewSettingBloc(
                  settingsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => RegionsBloc(
                  regionsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => PriorityLevelsBloc(
                  priorityLevelsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => ObservationTypesBloc(
                  observationTypesRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => AwarenessGroupsBloc(
                  awarenessGroupsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => AwarenessCategoriesBloc(
                  awarenessCategoriesRepository: RepositoryProvider.of(context),
                  awarenessGroupsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => SitesBloc(
                  sitesRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => ProjectsBloc(
                  projectsRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => CompaniesBloc(
                  companiesRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(
                create: (context) => RolesBloc(
                  rolesRepository: RepositoryProvider.of(context),
                ),
              ),
              BlocProvider(create: (context) => PaginationBloc())
            ],
            child: MaterialApp.router(
              title: 'Safety ETA',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'OpenSans',
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: router,
              // navigatorObservers: [FlutterSmartDialog.observer],
              builder: FlutterSmartDialog.init(),
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('en', 'US')],
            ),
          ),
        );
      },
    );
  }
}

setupHydratedLocalStorage() async {
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorage.webStorageDirectory,
  );
}

loadEnv() async {
  String environment = const String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'DEV',
  );

  String envFileName = '';

  switch (environment) {
    case 'DEV':
      envFileName = 'envs/env.dev';
      break;
    case 'UAT':
      envFileName = 'envs/env.uat';
      break;
    case 'PRODUCTION':
      envFileName = 'envs/env.production';
  }
  await dotenv.load(
      fileName: kReleaseMode ? envFileName : '../$envFileName',
      mergeWith: {
        'TEST_VAR': '5',
      });
}
