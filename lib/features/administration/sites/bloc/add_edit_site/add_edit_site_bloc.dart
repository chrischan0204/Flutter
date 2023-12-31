import '/common_libraries.dart';

part 'add_edit_site_event.dart';
part 'add_edit_site_state.dart';

class AddEditSiteBloc extends Bloc<AddEditSiteEvent, AddEditSiteState> {
  late FormDirtyBloc _formDirtyBloc;
  late RegionsRepository _regionsRepository;
  late SitesRepository _sitesRepository;

  final BuildContext context;

  static String addErrorMessage = ErrorMessage('site').add;
  static String editErrorMessage = ErrorMessage('site').edit;
  AddEditSiteBloc(this.context) : super(const AddEditSiteState()) {
    _formDirtyBloc = context.read();
    _regionsRepository = context.read();
    _sitesRepository = context.read();

    on<AddEditSiteAdded>(_onAddEditSiteAdded);
    on<AddEditSiteEdited>(_onAddEditSiteEdited);
    on<AddEditSiteLoaded>(_onAddEditSiteLoaded);
    on<AddEditTimeZoneListLoaded>(_onAddEditTimeZoneListLoaded);
    on<AddEditSiteRegionListLoaded>(_onAddEditSiteRegionListLoaded);
    on<AddEditSiteNameChanged>(_onAddEditSiteNameChanged);
    on<AddEditSiteRegionChanged>(_onAddEditSiteRegionChanged);
    on<AddEditSiteTimeZoneChanged>(_onAddEditSiteTimeZoneChanged);
    on<AddEditSiteTypeChanged>(_onAddEditSiteTypeChanged);
    on<AddEditSiteCodeChanged>(_onAddEditSiteCodeChanged);
    on<AddEditSiteReferenceCodeChanged>(_onAddEditSiteReferenceCodeChanged);
    on<AddEditSiteTypeListLoaded>(_onAddEditSiteTypeListLoaded);
  }

  void _onAddEditSiteNameChanged(
    AddEditSiteNameChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      siteName: event.name,
      siteNameValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditSiteRegionChanged(
    AddEditSiteRegionChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      region: event.region,
      regionValidationMessage: '',
    ));

    add(AddEditTimeZoneListLoaded(regionId: event.region.id!));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditTimeZoneListLoaded(
    AddEditTimeZoneListLoaded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      List<TimeZone> timeZoneList =
          await _regionsRepository.getTimeZonesForRegion(event.regionId);
      emit(state.copyWith(timeZoneList: timeZoneList));
    } catch (e) {}
  }

  Future<void> _onAddEditSiteTypeListLoaded(
    AddEditSiteTypeListLoaded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      List<SiteType> siteTypeList = await _sitesRepository.getSiteTypeList();
      emit(state.copyWith(siteTypeList: siteTypeList));
    } catch (e) {}
  }

  void _onAddEditSiteTimeZoneChanged(
    AddEditSiteTimeZoneChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      timeZone: event.timeZone,
      timeZoneValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditSiteTypeChanged(
    AddEditSiteTypeChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      siteType: event.siteType,
      siteTypeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditSiteCodeChanged(
    AddEditSiteCodeChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      siteCode: event.siteCode,
      siteCodeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditSiteReferenceCodeChanged(
    AddEditSiteReferenceCodeChanged event,
    Emitter<AddEditSiteState> emit,
  ) {
    emit(state.copyWith(
      referenceCode: event.referenceCode,
      referenceCodeValidationMessage: '',
    ));

    _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditSiteAdded(
    AddEditSiteAdded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await _sitesRepository.addSite(state.site);

        if (response.isSuccess) {
          emit(state.copyWith(
            createdSiteId: response.data?.id,
            message: response.message,
            status: EntityStatus.success,
          ));
        } else {
          _checkMessage(emit, response.message);
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: addErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditSiteEdited(
    AddEditSiteEdited event,
    Emitter<AddEditSiteState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response =
            await _sitesRepository.editSite(state.site.copyWith(id: event.id));

        if (response.isSuccess) {
          emit(state.copyWith(
            initialSiteName: state.siteName,
            initialReferenceCode: state.referenceCode,
            initialRegion: state.region,
            initialSiteCode: state.siteCode,
            initialSiteType: state.siteType,
            initialTimeZone: state.timeZone,
            message: response.message,
            status: EntityStatus.success,
          ));

          _formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
        } else {
          _checkMessage(emit, response.message);
        }
      } catch (e) {
        emit(state.copyWith(
          status: EntityStatus.failure,
          message: editErrorMessage,
        ));
      }
    }
  }

  Future<void> _onAddEditSiteRegionListLoaded(
    AddEditSiteRegionListLoaded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      List<Region> regionList = await _regionsRepository.getAssignedRegions();

      emit(state.copyWith(regionList: regionList));
    } catch (e) {}
  }

  Future<void> _onAddEditSiteLoaded(
    AddEditSiteLoaded event,
    Emitter<AddEditSiteState> emit,
  ) async {
    try {
      Site site = await _sitesRepository.getSiteById(event.id);

      emit(state.copyWith(
        loadedSite: site,
        initialSiteName: site.name,
        initialReferenceCode: site.referenceCode,
        initialRegion: Region(
          name: site.region,
          id: site.regionId,
        ),
        initialSiteCode: site.siteCode,
        initialSiteType: SiteType(
          id: site.siteTypeId,
          name: site.siteTypeName,
        ),
        initialTimeZone: TimeZone(
          id: site.timeZoneId,
          name: site.timeZone,
        ),
        siteName: site.name,
        referenceCode: site.referenceCode,
        region: Region(
          name: site.region,
          id: site.regionId,
        ),
        siteCode: site.siteCode,
        siteType: SiteType(
          id: site.siteTypeId,
          name: site.siteTypeName,
        ),
        timeZone: TimeZone(
          id: site.timeZoneId,
          name: site.timeZone,
        ),
      ));

      add(AddEditTimeZoneListLoaded(regionId: site.regionId));
    } catch (e) {}
  }

  /// check response message
  void _checkMessage(Emitter<AddEditSiteState> emit, String message) {
    if (message.contains('code')) {
      emit(state.copyWith(
          status: EntityStatus.initial, siteCodeValidationMessage: message));
    } else if (message.contains('name')) {
      emit(state.copyWith(
          status: EntityStatus.initial, siteNameValidationMessage: message));
    } else {
      emit(state.copyWith(status: EntityStatus.failure, message: message));
    }
  }

  /// validate form
  bool _checkValidation(Emitter<AddEditSiteState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.siteName)) {
      emit(state.copyWith(
          siteNameValidationMessage:
              FormValidationMessage(fieldName: 'Site name').requiredMessage));
      success = false;
    } else if (!Validation.checkAlphanumeric(state.siteName)) {
      emit(state.copyWith(
          siteNameValidationMessage:
              FormValidationMessage(fieldName: 'Site name')
                  .alphanumericMessage));
      success = false;
    } else if (state.siteName.length > SiteFormValidation.siteNameMaxLength) {
      emit(state.copyWith(
          siteNameValidationMessage: FormValidationMessage(
                  fieldName: 'Site name',
                  maxLength: SiteFormValidation.siteNameMaxLength)
              .maxLengthValidationMessage));
      success = false;
    }

    if (state.region == null) {
      emit(state.copyWith(
          regionValidationMessage:
              FormValidationMessage(fieldName: 'Region').requiredMessage));
      success = false;
    }

    if (state.timeZone == null) {
      emit(state.copyWith(
          timeZoneValidationMessage:
              FormValidationMessage(fieldName: 'Time zone').requiredMessage));
      success = false;
    }

    if (state.siteType == null) {
      emit(state.copyWith(
          siteTypeValidationMessage:
              FormValidationMessage(fieldName: 'Site type').requiredMessage));
      success = false;
    }

    if (Validation.isEmpty(state.siteCode)) {
      emit(state.copyWith(
          siteCodeValidationMessage:
              FormValidationMessage(fieldName: 'Site code').requiredMessage));

      success = false;
    } else if (!Validation.checkAlphanumeric(state.siteCode)) {
      emit(state.copyWith(
          siteCodeValidationMessage:
              FormValidationMessage(fieldName: 'Site code')
                  .alphanumericMessage));

      success = false;
    } else if (state.siteCode.length > SiteFormValidation.siteCodeMaxLength) {
      emit(state.copyWith(
          siteCodeValidationMessage: FormValidationMessage(
        fieldName: 'Site code',
        maxLength: SiteFormValidation.siteCodeMaxLength,
      ).alphanumericMessage));
      success = false;
    }

    if (Validation.isNotEmpty(state.referenceCode) &&
        !Validation.isAlphanumbericWithSpecialChars(state.referenceCode)) {
      emit(state.copyWith(
          referenceCodeValidationMessage:
              FormValidationMessage(fieldName: 'Reference code')
                  .alphanumbericWithAllowSpecialCharMessage));
      success = false;
    } else if (state.referenceCode.length >
        SiteFormValidation.referenceCodeMaxLength) {
      emit(state.copyWith(
          referenceCodeValidationMessage: FormValidationMessage(
        fieldName: 'Reference code',
        maxLength: SiteFormValidation.referenceCodeMaxLength,
      ).maxLengthValidationMessage));
      success = false;
    }

    return success;
  }
}
