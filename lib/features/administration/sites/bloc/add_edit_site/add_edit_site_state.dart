part of 'add_edit_site_bloc.dart';

class AddEditSiteState extends Equatable {
  /// created site id
  final String? createdSiteId;

  /// loaded site
  final Site? loadedSite;

  /// region list
  final List<Region> regionList;

  /// time zone list
  final List<TimeZone> timeZoneList;

  /// site name
  final String siteName;

  /// region
  final Region? region;

  /// time zone
  final TimeZone? timeZone;

  /// site type
  final String? siteType;

  /// site code
  final String siteCode;

  /// reference code
  final String referenceCode;

  /// initial site name for check dirty
  final String initialSiteName;

  /// initial region for check dirty
  final Region? initialRegion;

  /// initial time zone for check dirty
  final TimeZone? initialTimeZone;

  /// initial site type for check dirty
  final String? initialSiteType;

  /// initial site code for check dirty
  final String initialSiteCode;

  /// initial reference code for check dirty
  final String initialReferenceCode;

  /// validation message for site name
  final String siteNameValidationMessage;

  /// validation message for region
  final String regionValidationMessage;

  /// validation message for time zone
  final String timeZoneValidationMessage;

  /// validation message for site type
  final String siteTypeValidationMessage;

  /// validation message for site code
  final String siteCodeValidationMessage;

  /// validation message for reference code
  final String referenceCodeValidationMessage;

  /// creation & edition site status
  final EntityStatus status;

  /// response message from server
  final String message;

  const AddEditSiteState({
    this.createdSiteId,
    this.loadedSite,
    this.regionList = const [],
    this.timeZoneList = const [],
    this.siteName = '',
    this.region,
    this.timeZone,
    this.siteType,
    this.siteCode = '',
    this.referenceCode = '',
    this.initialSiteName = '',
    this.initialRegion,
    this.initialTimeZone,
    this.initialSiteType,
    this.initialSiteCode = '',
    this.initialReferenceCode = '',
    this.siteNameValidationMessage = '',
    this.regionValidationMessage = '',
    this.timeZoneValidationMessage = '',
    this.siteTypeValidationMessage = '',
    this.siteCodeValidationMessage = '',
    this.referenceCodeValidationMessage = '',
    this.status = EntityStatus.initial,
    this.message = '',
  });

  @override
  List<Object?> get props => [
        createdSiteId,
        loadedSite,
        regionList,
        timeZoneList,
        siteName,
        region,
        timeZone,
        siteType,
        siteCode,
        referenceCode,
        initialSiteName,
        initialRegion,
        initialTimeZone,
        initialSiteType,
        initialSiteCode,
        initialReferenceCode,
        siteNameValidationMessage,
        regionValidationMessage,
        timeZoneValidationMessage,
        siteTypeValidationMessage,
        siteCodeValidationMessage,
        referenceCodeValidationMessage,
        status,
        message,
      ];

  bool get formDirty =>
      (!Validation.isEmpty(siteName) && initialSiteName != siteName) ||
      (!Validation.isEmpty(siteCode) && initialSiteCode != siteCode) ||
      (region != null && initialRegion?.id != region?.id) ||
      (timeZone != null && initialTimeZone?.id != timeZone?.id) ||
      (siteType != null && initialSiteType != siteType) ||
      (!Validation.isEmpty(referenceCode) &&
          initialReferenceCode != referenceCode);

  Site get site => Site(
        name: siteName,
        regionId: region!.id!,
        timeZoneId: timeZone!.id!,
        siteType: siteType!,
        siteCode: siteCode,
        referenceCode: referenceCode,
      );

  AddEditSiteState copyWith({
    String? createdSiteId,
    Site? loadedSite,
    List<Region>? regionList,
    List<TimeZone>? timeZoneList,
    String? siteName,
    Region? region,
    TimeZone? timeZone,
    String? siteType,
    String? siteCode,
    String? referenceCode,
    String? initialSiteName,
    Region? initialRegion,
    TimeZone? initialTimeZone,
    String? initialSiteType,
    String? initialSiteCode,
    String? initialReferenceCode,
    String? siteNameValidationMessage,
    String? regionValidationMessage,
    String? timeZoneValidationMessage,
    String? siteTypeValidationMessage,
    String? siteCodeValidationMessage,
    String? referenceCodeValidationMessage,
    EntityStatus? status,
    String? message,
  }) {
    return AddEditSiteState(
      createdSiteId: createdSiteId ?? this.createdSiteId,
      loadedSite: loadedSite ?? this.loadedSite,
      regionList: regionList ?? this.regionList,
      timeZoneList: timeZoneList ?? this.timeZoneList,
      siteName: siteName ?? this.siteName,
      region: region ?? this.region,
      timeZone: timeZone ?? this.timeZone,
      siteType: siteType ?? this.siteType,
      siteCode: siteCode ?? this.siteCode,
      referenceCode: referenceCode ?? this.referenceCode,
      initialSiteName: initialSiteName ?? this.initialSiteName,
      initialRegion: initialRegion ?? this.initialRegion,
      initialTimeZone: initialTimeZone ?? this.initialTimeZone,
      initialSiteType: initialSiteType ?? this.initialSiteType,
      initialSiteCode: initialSiteCode ?? this.initialSiteCode,
      initialReferenceCode: initialReferenceCode ?? this.initialReferenceCode,
      siteNameValidationMessage:
          siteNameValidationMessage ?? this.siteNameValidationMessage,
      regionValidationMessage:
          regionValidationMessage ?? this.regionValidationMessage,
      timeZoneValidationMessage:
          timeZoneValidationMessage ?? this.timeZoneValidationMessage,
      siteTypeValidationMessage:
          siteTypeValidationMessage ?? this.siteTypeValidationMessage,
      siteCodeValidationMessage:
          siteCodeValidationMessage ?? this.siteCodeValidationMessage,
      referenceCodeValidationMessage:
          referenceCodeValidationMessage ?? this.referenceCodeValidationMessage,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
