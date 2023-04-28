import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safety_eta/common_libraries.dart';

import 'router.dart';

import 'data/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await setupHydratedLocalStorage();
  runApp(RepositoryProvider(
    create: (context) => AuthRepository(),
    child: BlocProvider(
      create: (context) => AuthBloc(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // if (state is! AuthAuthenticateSuccess) {
        //   GoRouter.of(context).go('/login');
        // }
      },
      builder: (context, state) {
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => RegionsRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => PriorityLevelsRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) =>
                  ObservationTypesRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) =>
                  AwarenessGroupsRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) =>
                  AwarenessCategoriesRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => SitesRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => ProjectsRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => CompaniesRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => RolesRepository(token: state.token),
            ),
            RepositoryProvider(
              create: (context) => UsersRepository(token: state.token),
            )
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
              BlocProvider(
                create: (context) => UsersBloc(
                  usersRepository:
                      RepositoryProvider.of<UsersRepository>(context),
                ),
              )
            ],
            child: MaterialApp.router(
              title: 'Safety ETA',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'OpenSans',
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: router,
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
