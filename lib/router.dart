import 'package:flutter/material.dart';
import 'package:safety_eta/features/administration/masters/awareness_groups/view/add_edit_awareness_group.dart';
import 'package:safety_eta/features/administration/masters/awareness_groups/view/awareness_group_show.dart';

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
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: Dashboard(),
          selectedItemName: 'dashboard',
        ),
      ),
    ),
    GoRoute(
      path: '/observations',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Observations(),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/audits1',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Audits1(),
          selectedItemName: 'audits1',
        ),
      ),
    ),
    GoRoute(
      path: '/action-items',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ActionItems(),
          selectedItemName: 'action-items',
        ),
      ),
    ),
    GoRoute(
      path: '/sites',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Sites(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/companies',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Companies(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/templates',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Templates(),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/audits',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Audits(),
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
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: Layout(
              body: RegionsListView(),
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'new',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            child: Layout(
              body: AddEditRegionView(),
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'show/:regionId',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            child: Layout(
              body: RegionDetailView(
                regionId: state.params['regionId']!,
              ),
              selectedItemName: 'regions',
            ),
          ),
        ),
        GoRoute(
          path: 'edit/:regionId',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            child: Layout(
              body: AddEditRegionView(
                regionId: state.params['regionId']!,
              ),
              selectedItemName: 'regions',
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/priority-levels',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityLevels(),
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/observation-types',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ObservationTypesListView(),
          selectedItemName: 'observation-types',
        ),
      ),
    ),
    GoRoute(
      path: '/observation-types/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditObservationTypeView(),
          selectedItemName: 'observation-types',
        ),
      ),
    ),
    GoRoute(
      path: '/observation-types/show/:observationTypeId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ObservationTypeShowView(
            observationTypeId: state.params['observationTypeId']!,
          ),
          selectedItemName: 'observation-types',
        ),
      ),
    ),
    GoRoute(
      path: '/observation-types/edit/:observationTypeId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditObservationTypeView(
            observationTypeId: state.params['observationTypeId']!,
          ),
          selectedItemName: 'observation-types',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-groups',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AwarenessGroupsListView(),
          selectedItemName: 'awareness-groups',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-groups/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditAwarenessGroupView(),
          selectedItemName: 'awareness-groups',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-groups/edit/:awarenessGroupId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditAwarenessGroupView(
            awarenessGroupId: state.params['awarenessGroupId']!,
          ),
          selectedItemName: 'awareness-groups',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-groups/show/:awarenessGroupId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AwarenessGroupShowView(
            awarenessGroupId: state.params['awarenessGroupId']!,
          ),
          selectedItemName: 'awareness-groups',
        ),
      ),
    ),

    GoRoute(
      path: '/awareness-categories',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AwarenessCategoriesListView(),
          selectedItemName: 'awareness-categories',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-categories/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditAwarenessCategoryView(),
          selectedItemName: 'awareness-categories',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-categories/show/:awarenessCategoryId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AwarenessCategoryShowView(
              awarenessCategoryId: state.params['awarenessCategoryId']!),
          selectedItemName: 'awareness-categories',
        ),
      ),
    ),
    GoRoute(
      path: '/awareness-categories/edit/:awarenessCategoryId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditAwarenessCategoryView(
            awarenessCategoryId: state.params['awarenessCategoryId']!,
          ),
          selectedItemName: 'awareness-categories',
        ),
      ),
    ),
    GoRoute(
      path: '/users',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Users(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/my-page',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Sites(),
          selectedItemName: 'my-page',
        ),
      ),
    ),
    GoRoute(
      path: '/logout',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Sites(),
          selectedItemName: 'logout',
        ),
      ),
    ),
  ],
  // errorBuilder: (context, state) => Container(
  //   child: Text('Page not found.'),
  // ),
  errorPageBuilder: (context, state) => NoTransitionPage<void>(
    child: Container(
      child: Text('Page not found.'),
    ),
  ),
);
