import '/common_libraries.dart';

part 'add_edit_company_event.dart';
part 'add_edit_company_state.dart';

class AddEditCompanyBloc
    extends Bloc<AddEditCompanyEvent, AddEditCompanyState> {
  final CompaniesRepository companiesRepository;
  final FormDirtyBloc formDirtyBloc;

  static String addErrorMessage =
      'There was an error while adding company. Our team has been notified. Please wait a few minutes and try again.';
  static String editErrorMessage =
      'There was an error while editing company. Our team has been notified. Please wait a few minutes and try again.';

  AddEditCompanyBloc({
    required this.companiesRepository,
    required this.formDirtyBloc,
  }) : super(const AddEditCompanyState()) {
    on<AddEditCompanyAdded>(_onAddEditCompanyAdded);
    on<AddEditCompanyEdited>(_onAddEditCompanyEdited);
    on<AddEditCompanyLoaded>(_onAddEditCompanyLoaded);
    on<AddEditCompanyNameChanged>(_onAddEditCompanyNameChanged);
    on<AddEditCompanyEinNumberChanged>(_onAddEditCompanyEinNumberChanged);
  }

  void _onAddEditCompanyNameChanged(
    AddEditCompanyNameChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      companyName: event.name,
      companyNameValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  void _onAddEditCompanyEinNumberChanged(
    AddEditCompanyEinNumberChanged event,
    Emitter<AddEditCompanyState> emit,
  ) {
    emit(state.copyWith(
      einNumber: event.einNumber,
      einNumberValidationMessage: '',
    ));

    formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
  }

  Future<void> _onAddEditCompanyAdded(
    AddEditCompanyAdded event,
    Emitter<AddEditCompanyState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await companiesRepository.addCompany(Company(
          name: state.companyName,
          einNumber: state.einNumber,
        ));

        if (response.isSuccess) {
          emit(state.copyWith(
            createdCompanyId: response.data?.id,
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

  Future<void> _onAddEditCompanyEdited(
    AddEditCompanyEdited event,
    Emitter<AddEditCompanyState> emit,
  ) async {
    if (_checkValidation(emit)) {
      emit(state.copyWith(status: EntityStatus.loading));

      try {
        EntityResponse response = await companiesRepository.editCompany(Company(
            id: event.id, name: state.companyName, einNumber: state.einNumber));

        if (response.isSuccess) {
          emit(state.copyWith(
            initialCompanyName: state.companyName,
            initialEinNumber: state.einNumber,
            message: response.message,
            status: EntityStatus.success,
          ));

          formDirtyBloc.add(FormDirtyChanged(isDirty: state.formDirty));
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

  Future<void> _onAddEditCompanyLoaded(
    AddEditCompanyLoaded event,
    Emitter<AddEditCompanyState> emit,
  ) async {
    try {
      Company company = await companiesRepository.getCompanyById(event.id);

      emit(state.copyWith(
        loadedCompany: company,
        initialCompanyName: company.name,
        initialEinNumber: company.einNumber,
        companyName: company.name,
        einNumber: company.einNumber,
      ));
    } catch (e) {}
  }

  /// check response message
  void _checkMessage(Emitter<AddEditCompanyState> emit, String message) {
    if (message.contains('EIN')) {
      emit(state.copyWith(
        status: EntityStatus.initial,
        einNumberValidationMessage: message,
        companyNameValidationMessage: '',
      ));
    } else if (message.contains('Our team')) {
      emit(state.copyWith(
        message: message,
        status: EntityStatus.failure,
      ));
    } else if (message.isNotEmpty) {
      emit(state.copyWith(
        status: EntityStatus.initial,
        einNumberValidationMessage: '',
        companyNameValidationMessage: message,
      ));
    }
  }

  /// validate form
  bool _checkValidation(Emitter<AddEditCompanyState> emit) {
    bool success = true;

    if (Validation.isEmpty(state.companyName)) {
      emit(state.copyWith(
          companyNameValidationMessage:
              'Company name is required and cannot be blank.'));

      success = false;
    } else if (!Validation.isAlphanumbericWithSpecialChars(state.companyName)) {
      emit(state.copyWith(
          companyNameValidationMessage:
              'Company name should be alphanumeric with allow special char.'));

      success = false;
    } else if (state.companyName.length >
        CompanyFormValidation.companyNameMaxLength) {
      emit(state.copyWith(
          companyNameValidationMessage: Validation.maxLengthValidationMessage(
              'Company name', CompanyFormValidation.companyNameMaxLength)));

      success = false;
    }

    final reg = RegExp(r'^\d{2}-\d{7}');

    if (state.einNumber.isNotEmpty && !reg.hasMatch(state.einNumber)) {
      emit(state.copyWith(
          einNumberValidationMessage:
              'EIN Number can have only Number and Dahses in the format XX-XXXXXXX.'));

      success = false;
    }

    return success;
  }
}
