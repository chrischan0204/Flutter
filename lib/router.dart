import 'common_libraries.dart';
import 'features/administration/audits/response_scale/view/response_scale.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (_, __) => '/login',
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const LoginView(),
      ),
    ),
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
        child: const Layout(
          body: ObservationListView(),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/observations/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ObservationListView(),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/observations/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditObservationView(),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/observations/edit/:observationId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditObservationView(
            observationId: state.params['observationId'],
          ),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/observations/show/:observationId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ObservationDetailView(
            observationId: state.params['observationId']!,
          ),
          selectedItemName: 'observations',
        ),
      ),
    ),
    GoRoute(
      path: '/action_items',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ActionItemListView(),
          selectedItemName: 'action_items',
        ),
      ),
    ),
    GoRoute(
      path: '/action_items/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ActionItemListView(),
          selectedItemName: 'action_items',
        ),
      ),
    ),
    GoRoute(
      path: '/action_items/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditActionItemView(),
          selectedItemName: 'action_items',
        ),
      ),
    ),
    GoRoute(
      path: '/action_items/edit/:actionItemId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditActionItemView(
            actionItemId: state.params['actionItemId']!,
          ),
          selectedItemName: 'action_items',
        ),
      ),
    ),
    GoRoute(
      path: '/action_items/show/:actionItemId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ActionItemDetailView(
            actionItemId: state.params['actionItemId']!,
          ),
          selectedItemName: 'action_items',
        ),
      ),
    ),
    GoRoute(
      path: '/sites',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SitesListView(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: SitesListView(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditSiteView(),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/show/:siteId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: SiteShowView(
            siteId: state.params['siteId']!,
          ),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/sites/edit/:siteId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditSiteView(
            siteId: state.params['siteId']!,
          ),
          selectedItemName: 'sites',
        ),
      ),
    ),
    GoRoute(
      path: '/projects',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ProjectsListView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ProjectsListView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditProjectView(),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/show/:projectId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ShowProjectView(
            projectId: state.params['projectId']!,
          ),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/projects/edit/:projectId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditProjectView(
            projectId: state.params['projectId'],
            view: state.queryParams['view'],
          ),
          selectedItemName: 'projects',
        ),
      ),
    ),
    GoRoute(
      path: '/companies',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: CompaniesListView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: CompaniesListView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditCompanyView(),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/edit/:companyId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditCompanyView(
            companyId: state.params['companyId']!,
            view: state.queryParams['view'],
          ),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/companies/show/:companyId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ShowCompanyView(
            companyId: state.params['companyId']!,
          ),
          selectedItemName: 'companies',
        ),
      ),
    ),
    GoRoute(
      path: '/templates',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: TemplateListView(),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/templates/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: TemplateListView(),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/templates/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditTemplateView(),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/templates/edit/:templateId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditTemplateView(
            templateId: state.params['templateId'],
            view: state.queryParams['view'],
          ),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/templates/show/:templateId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: TemplateDetailView(templateId: state.params['templateId']!),
          selectedItemName: 'templates',
        ),
      ),
    ),
    GoRoute(
      path: '/response_scales',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ResponseScaleCrudView(),
          selectedItemName: 'response_scales',
        ),
      ),
    ),
    GoRoute(
      path: '/response_scales/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: ResponseScaleCrudView(),
          selectedItemName: 'response_scales',
        ),
      ),
    ),
    GoRoute(
      path: '/audits',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AuditListView(),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AuditListView(),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditAuditView(),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/edit/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditAuditView(
            auditId: state.params['auditId'],
            view: state.queryParams['view'],
          ),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/approve_delete/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ApproveDeleteAuditView(
            auditId: state.params['auditId']!,
          ),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/mark_as_completed/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: MarkAsCompletedAuditView(
            auditId: state.params['auditId']!,
          ),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/show/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AuditDetailView(auditId: state.params['auditId']!),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/execute/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: ExecuteAuditView(auditId: state.params['auditId']!),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/audits/focus_mode/:auditId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => ExecuteAuditBloc(
                      context: context, auditId: state.params['auditId']!)),
              BlocProvider(
                  create: (context) =>
                      AuditDetailBloc(context, state.params['auditId']!)),
            ],
            child: AuditFocusModeView(auditId: state.params['auditId']!),
          ),
          selectedItemName: 'audits',
        ),
      ),
    ),
    GoRoute(
      path: '/regions',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: RegionsListView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/regions/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: RegionsListView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/regions/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditRegionView(),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/regions/show/:regionId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: Layout(
          body: RegionShowView(
            regionId: state.params['regionId']!,
          ),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/regions/edit/:regionId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        child: Layout(
          body: AddEditRegionView(
            regionId: state.params['regionId']!,
          ),
          selectedItemName: 'regions',
        ),
      ),
    ),
    GoRoute(
      path: '/priority-levels',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityLevelsListView(),
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/priority-levels/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: PriorityLevelsListView(),
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/priority-levels/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditPriorityLevelView(),
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/priority-levels/show/:priorityLevelId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: PriorityLevelShowView(
            priorityLevelId: state.params['priorityLevelId']!,
          ),
          selectedItemName: 'priority-levels',
        ),
      ),
    ),
    GoRoute(
      path: '/priority-levels/edit/:priorityLevelId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditPriorityLevelView(
            priorityLevelId: state.params['priorityLevelId']!,
          ),
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
      path: '/observation-types/index',
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
      path: '/awareness-groups/index',
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
      path: '/awareness-categories/index',
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
        child: const Layout(
          body: UsersListView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/index',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: UsersListView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/new',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: const Layout(
          body: AddEditUserView(),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/edit/:userId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: AddEditUserView(
            userId: state.params['userId'],
            view: state.queryParams['view'],
          ),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/users/show/:userId',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: UserDetailView(userId: state.params['userId']!),
          selectedItemName: 'users',
        ),
      ),
    ),
    GoRoute(
      path: '/my-page',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Container(),
          selectedItemName: 'my-page',
        ),
      ),
    ),
    GoRoute(
      path: '/logout',
      pageBuilder: (context, state) => NoTransitionPage<void>(
        key: state.pageKey,
        child: Layout(
          body: Container(),
          selectedItemName: 'logout',
        ),
      ),
    ),
  ],
  // errorBuilder: (context, state) => Container(
  //   child: Text('Page not found.'),
  // ),
  errorPageBuilder: (context, state) => const NoTransitionPage<void>(
    child: Center(
      child: Text('Page not found.'),
    ),
  ),
);
