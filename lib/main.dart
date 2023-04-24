import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'router.dart';
import 'package:flutter/material.dart';

import 'data/bloc/bloc.dart';
import 'data/repository/repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadEnv();
  await setupHydratedLocalStorage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => RegionsRepository(),
        ),
        RepositoryProvider(
          create: (context) => PriorityLevelsRepository(),
        ),
        RepositoryProvider(
          create: (context) => ObservationTypesRepository(),
        ),
        RepositoryProvider(
          create: (context) => AwarenessGroupsRepository(),
        ),
        RepositoryProvider(
          create: (context) => AwarenessCategoriesRepository(),
        ),
        RepositoryProvider(
          create: (context) => SitesRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProjectsRepository(),
        ),
        RepositoryProvider(
          create: (context) => CompaniesRepository(),
        ),
        RepositoryProvider(
          create: (context) => RolesRepository(),
        ),
        RepositoryProvider(
          create: (context) => UsersRepository(),
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
                  RepositoryProvider.of<ObservationTypesRepository>(context),
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
                  RepositoryProvider.of<AwarenessCategoriesRepository>(context),
              awarenessGroupsRepository:
                  RepositoryProvider.of<AwarenessGroupsRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => SitesBloc(
              sitesRepository: RepositoryProvider.of<SitesRepository>(context),
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
              rolesRepository: RepositoryProvider.of<RolesRepository>(context),
            ),
          ),
          BlocProvider(
            create: (context) => UsersBloc(
              usersRepository: RepositoryProvider.of<UsersRepository>(context),
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
