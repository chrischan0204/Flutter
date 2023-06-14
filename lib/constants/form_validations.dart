enum ValidationType {
  alphanumeric,
  alphanumericWithSpecialChar,
  number,
  alphabetic,
}

class SiteFormValidation {
  static int siteNameMaxLength = 100;
  static int siteCodeMaxLength = 50;
  static int referenceCodeMaxLength = 100;
}

class CompanyFormValidation {
  static int companyNameMaxLength = 100;
}

class ProjectFormValidation {
  static int projectNameMaxLength = 200;
  static int referneceNumberMaxLength = 50;
  static int referenceNameMaxLength = 200;
}

class UserFormValidation {
  static int firstNameMaxLength = 100;
  static int lastNameMaxLength = 100;
  static int userTitleMaxLength = 100;
  static int emailMaxLength = 100;
  static int mobilePhoneMaxLength = 50;

}

class PriorityLevelFormValidation {
  static int priorityLevelMaxLength = 100;
}

class ObservationTypeFormValidation {
  static int observationTypeNameMaxLength = 100;
  
}

class AwarenessGroupFormValidation {
  static int awarenessGroupNameMaxLength = 100;
}

class AwarenessCategoryFormValidation {
  static int awarenessCategoryMaxLength = 100;
}