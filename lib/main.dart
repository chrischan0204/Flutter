import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:safety_eta/common_libraries.dart';

import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await setupHydratedLocalStorage();
  runApp(RepositoryProvider(
    create: (context) => AuthRepository(),
    child: BlocProvider(
      create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

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
          ],
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ThemeBloc(),
              ),
              BlocProvider(
                create: (context) => RegionsBloc(
                  regionsRepository:
                      RepositoryProvider.of<RegionsRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => PriorityLevelsBloc(
                  priorityLevelsRepository:
                      RepositoryProvider.of<PriorityLevelsRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => ObservationTypesBloc(
                  observationTypesRepository:
                      RepositoryProvider.of<ObservationTypesRepository>(
                          context),
                ),
              ),
              BlocProvider(
                create: (context) => AwarenessGroupsBloc(
                  awarenessGroupsRepository:
                      RepositoryProvider.of<AwarenessGroupsRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => AwarenessCategoriesBloc(
                  awarenessCategoriesRepository:
                      RepositoryProvider.of<AwarenessCategoriesRepository>(
                          context),
                  awarenessGroupsRepository:
                      RepositoryProvider.of<AwarenessGroupsRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => SitesBloc(
                  sitesRepository:
                      RepositoryProvider.of<SitesRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => ProjectsBloc(
                  projectsRepository:
                      RepositoryProvider.of<ProjectsRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => CompaniesBloc(
                  companiesRepository:
                      RepositoryProvider.of<CompaniesRepository>(context),
                ),
              ),
              BlocProvider(
                create: (context) => RolesBloc(
                  rolesRepository:
                      RepositoryProvider.of<RolesRepository>(context),
                ),
              ),
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
  await dotenv.load(
      fileName: kReleaseMode ? 'env.development' : '../env.development',
      mergeWith: {
        'TEST_VAR': '5',
      });
}
