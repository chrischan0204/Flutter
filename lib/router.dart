import 'package:flutter/material.dart';

import '/features/features.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/dashboard',
    ),
    // ...SidebarRepsitory.getItems()
    //     .map(
    //       (e) => GoRoute(
    //         path: '/${e.path}',
    //         pageBuilder: (context, state) => NoTransitionPage<void>(
    //           key: state.pageKey,
    //           child: Layout(
    //             body: e.body,
    //             title: e.label,
    //             selectedItemName: e.path,
    //           ),
    //         ),
    //         routes: [
    //           GoRoute(path: path)
    //         ],
    //       ),
    //     )
    //     .toList()
    GoRoute(
      path: '/dashboard',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Dashboard(),
          title: 'Dashboard',
          selectedItemName: 'dashboard',
        ),
      ),
    ),
    GoRoute(
      path: '/observations',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Observations(),
          title: 'Observations',
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/audits1',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Audits1(),
          title: 'Audits  ',
          selectedItemName: 'audits1',
        ),
      ),
    ),
    GoRoute(
      path: '/action-items',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: ActionItems(),
          title: 'Action Items',
          selectedItemName: 'action-items',
        ),
      ),
    ),
    GoRoute(
      path: '/sites',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Sites(),
          title: 'Sites',
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/companies',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Companies(),
          title: 'Companies',
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/templates',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Templates(),
          title: 'Templates',
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/audits',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Audits(),
          title: 'Audits',
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/regions',
      redirect: (context, state) => '/regions/index',
      routes: [
        GoRoute(
          path: 'index',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Layout(
              body: RegionsListView(),
              title: 'Regions',
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Layout(
              body: AddEditRegionView(),
              title: 'Regions',
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'show/:regionId',
          pageBuilder: (context, state) => NoTransitionPage(
            child: Layout(
              body: RegionDetailView(
                regionId: state.params['regionId']!,
              ),
              title: 'Regions',
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'edit/:regionId',
          pageBuilder: (context, state) => NoTransitionPage(
            child: Layout(
              body: AddEditRegionView(
                regionId: state.params['regionId']!,
              ),
              title: 'Regions',
              selectedItemName: 'regions',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/priority-levels',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: PriorityLevels(),
          title: 'Priority Levels',
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/observation-types',
      redirect: (context, state) => '/observation-types/index',
      routes: [
        GoRoute(
          path: 'index',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Layout(
              body: ObservationTypes(),
              title: 'Observations Types List',
              selectedItemName: 'observation-types',
            ),
          ),
        ),
        GoRoute(
          path: 'new',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: Layout(
              body: AddEditRegionView(),
              title: 'Observations',
              selectedItemName: 'observation-types',
            ),
          ),
        ),
        GoRoute(
          path: 'show/:observationTypeId',
          pageBuilder: (context, state) => NoTransitionPage(
            child: Layout(
              body: RegionDetailView(
                regionId: state.params['observationTypeId']!,
              ),
              title: 'Regions',
              selectedItemName: 'observation-types',
            ),
          ),
        ),
        GoRoute(
          path: 'edit/:observationTypeId',
          pageBuilder: (context, state) => NoTransitionPage(
            child: Layout(
              body: AddEditRegionView(
                regionId: state.params['observationTypeId']!,
              ),
              title: 'Regions',
              selectedItemName: 'observation-types',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/awareness-groups',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: AwarenessGroups(),
          title: 'Awareness Groups',
          selectedItemName: 'awareness-groups',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-categories',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: AwarenessCategories(),
          title: 'Awareness Categories',
          selectedItemName: 'awareness-categories',
        ),
      ),
    ),
    GoRoute(
      path: '/users',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Users(),
          title: 'Users',
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/my-page',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Sites(),
          title: 'My Page',
          selectedItemName: 'my-page',
        ),
      ),
    ),
    GoRoute(
      path: '/logout',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Layout(
          body: Sites(),
          title: 'Logout',
          selectedItemName: 'logout',
        ),
      ),
    ),
  ],
  // errorBuilder: (context, state) => Container(
  //   child: Text('Page not found.'),
  // ),
  errorPageBuilder: (context, state) => NoTransitionPage(
    child: Container(
      child: Text('Page not found.'),
    ),
  ),
);
