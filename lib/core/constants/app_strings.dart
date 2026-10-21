abstract final class AppStrings {
  static String requestFailed(Type type) => 'Request failed: $type';

  // ── Supabase Auth errors ──────────────────────────────────
  static const theSignInDetailsAreIncorrect =
      'The sign-in details are incorrect.';
  static const pleaseConfirmYourEmailBeforeSigningIn =
      'Please confirm your email before signing in.';
  static const pleaseConfirmYourPhoneNumberBeforeSigningIn =
      'Please confirm your phone number before signing in.';
  static const anAccountWithThisEmailAlreadyExists =
      'An account with this email already exists.';
  static const anAccountWithTheseDetailsAlreadyExists =
      'An account with these details already exists.';
  static const pleaseChooseAStrongerPassword =
      'Please choose a stronger password.';
  static const pleaseChooseAPasswordDifferentFromYourCurrentOne =
      'Please choose a password different from your current one.';
  static const theVerificationLinkOrCodeHasExpiredRequestANewOne =
      'The verification link or code has expired. Request a new one.';
  static const pleaseSignInAgainToContinue =
      'Please sign in again to continue.';
  static const yourSessionHasExpiredPleaseSignInAgain =
      'Your session has expired. Please sign in again.';
  static const tooManyAttemptsPleaseTryAgainLater =
      'Too many attempts. Please try again later.';
  static const tooManyEmailsRequestedPleaseTryAgainLater =
      'Too many emails requested. Please try again later.';
  static const tooManyVerificationMessagesRequestedPleaseTryAgainLater =
      'Too many verification messages requested. Please try again later.';
  static const theRequestTimedOutPleaseTryAgain =
      'The request timed out. Please try again.';
  static const thisRecordAlreadyExists = 'This record already exists.';
  static const thisActionCouldNotBeCompletedBecauseOfRelatedRecords =
      'This action could not be completed because of related records.';
  static const someRequiredInformationIsMissing =
      'Some required information is missing.';
  static const someProvidedInformationIsInvalid =
      'Some provided information is invalid.';
  static const someProvidedInformationHasAnInvalidFormat =
      'Some provided information has an invalid format.';
  static const youDoNotHavePermissionToPerformThisAction =
      'You do not have permission to perform this action.';
  static const theRequestedDataCouldNotBeRetrievedAsExpected =
      'The requested data could not be retrieved as expected.';
  static const unableToReachTheServicePleaseTryAgain =
      'Unable to reach the service. Check your connection and try again.';
  static const unableToCompleteAuthenticationPleaseTryAgain =
      'Unable to complete authentication. Please try again.';
  static const unableToLoadOrSaveDataPleaseTryAgain =
      'Unable to load or save data. Please try again.';
  static const unableToCompleteTheFileOperationPleaseTryAgain =
      'Unable to complete the file operation. Please try again.';
  static const unableToCompleteTheOperationPleaseTryAgain =
      'Unable to complete the operation. Please try again.';
  static const theReturnedDataCouldNotBeProcessedPleaseTryAgain =
      'The returned data could not be processed. Please try again.';
  static const anUnexpectedErrorOccurredPleaseTryAgain =
      'An unexpected error occurred. Please try again.';
  static const theRequestedItemCouldNotBeFound =
      'The requested item could not be found.';
  static const thisActionConflictsWithExistingData =
      'This action conflicts with existing data.';
  static const theSubmittedDataIsTooLarge = 'The submitted data is too large.';
  static const tooManyRequestsPleaseTryAgainLater =
      'Too many requests. Please try again later.';
  static const theServiceIsTemporarilyUnavailablePleaseTryAgainLater =
      'The service is temporarily unavailable. Please try again later.';

  // ── Dio / External API errors ─────────────────────────────
  static const connectionTimedOutPleaseTryAgain =
      'Connection timed out. Please try again.';
  static const sendTimedOutPleaseTryAgain = 'Send timed out. Please try again.';
  static const receiveTimedOutPleaseTryAgain =
      'Receive timed out. Please try again.';
  static const noInternetConnectionPleaseTryAgain =
      'No internet connection. Please check your network and try again.';
  static const theRequestWasCancelled = 'The request was cancelled.';
  static const secureConnectionFailedPleaseTryAgain =
      'Secure connection failed. Please try again.';
  static const badRequestPleaseTryAgain = 'Bad request. Please try again.';
  static const noSessionReturned = 'No session returned. Please try again.';

  // ── Auth success messages ────────────────────────────────
  static const welcomeBack = 'تم تسجيل الدخول بنجاح';
  static const accountCreatedSuccessfully = 'Account created successfully!';
  static const loggedOutSuccessfully = 'Signed out successfully.';
  static const passwordResetEmailSent =
      'Password reset email sent. Please check your inbox.';
  static const passwordUpdatedSuccessfully =
      'Password updated successfully. Please sign in again.';
  static const googleSignInCancelled = 'Google sign-in was cancelled.';

  // ── Login screen ─────────────────────────────────────────
  static const appName = 'متجري';
  static const loginTitle = 'مرحبًا بك';
  static const loginSubtitle = 'سجّل الدخول لتصفح أحدث المنتجات';
  static const labelUsername = 'اسم المستخدم';
  static const labelEmail = 'Email';
  static const hintEmail = 'Enter your email';
  static const labelPassword = 'كلمة المرور';
  static const hintPassword = 'Enter your password';
  static const forgotPassword = 'Forgot Password?';
  static const signIn = 'تسجيل الدخول';
  static const orContinueWith = 'Or continue with';
  static const dontHaveAccount = "Don't have an account?";
  static const signUp = 'Sign Up';

  // ── Sign Up screen ───────────────────────────────────────
  static const createAccount = 'Create Account';
  static const createAccountSubtitle = 'Join our community of food lovers';
  static const labelFullName = 'Full Name';
  static const hintFullName = 'John Doe';
  static const hintEmailSignUp = 'hello@example.com';
  static const hintPasswordSignUp = '••••••••';
  static const orSignUpWith = 'Or sign up with';
  static const alreadyHaveAccount = 'Already have an account?';

  // ── Forgot Password screen ───────────────────────────────
  static const forgotPasswordTitle = 'Forgot Password?';
  static const forgotPasswordSubtitle =
      "No worries! Enter your email and we'll send you a reset link.";
  static const labelEmailAddress = 'Email Address';
  static const sendResetLink = 'Send Reset Link';
  static const backToSignIn = 'Back to Sign In';
  static const checkYourEmail = 'Check Your Email';

  // ── Reset Password screen ────────────────────────────────
  static const resetPasswordTitle = 'Set New Password';
  static const resetPasswordSubtitle =
      'Your new password must be different from previous passwords.';
  static const labelNewPassword = 'New Password';
  static const hintNewPassword = 'Enter new password';
  static const labelConfirmPassword = 'Confirm Password';
  static const hintConfirmPassword = 'Re-enter new password';
  static const updatePassword = 'Update Password';

  // ── Social Buttons ───────────────────────────────────────
  static const google = 'Google';
  static const apple = 'Apple';

  // ── Validators ───────────────────────────────────────────
  static const enterUsername = 'أدخل اسم المستخدم';
  static const enterAValidPassword = 'أدخل كلمة مرور صحيحة';
  static const thisField = 'This field';
  static const fullNameField = 'Full name';
  static const email = 'Email';
  static const password = 'Password';
  static const username = 'Username';
  static const phoneNumber = 'Phone number';
  static const confirmPassword = 'Confirm password';

  static String requiredField(String field) => '$field is required.';
  static const enterYourFullName = 'Please enter your full name.';
  static const fullNameMustBeAtMost80Characters =
      'Full name must be at most 80 characters.';
  static const enterAValidEmailAddress = 'Please enter a valid email address.';
  static const usernameMustBeAtLeast3Characters =
      'Username must be at least 3 characters.';
  static const enterAValidPhoneNumber = 'Please enter a valid phone number.';
  static const passwordMustBeAtLeast8Characters =
      'Password must be at least 8 characters.';
  static const passwordMustContainAtLeastOneUppercaseLetter =
      'Password must contain at least one uppercase letter.';
  static const passwordMustContainAtLeastOneLowercaseLetter =
      'Password must contain at least one lowercase letter.';
  static const passwordMustContainAtLeastOneNumber =
      'Password must contain at least one number.';
  static const passwordMustContainAtLeastOneSpecialCharacter =
      'Password must contain at least one special character.';
  static const passwordsDoNotMatch = 'Passwords do not match.';

  // ── Food / Home screen ────────────────────────────────────
  static const home = 'Home';
  static const exploreCategories = 'Explore Categories';
  static const searchCategoriesHint = 'Search categories...';
  static const searchMealsHint = 'Search recipes...';
  static const noCategoriesFound = 'No categories found.';
  static const noMealsFound = 'No recipes found for this category.';
  static const recipes = 'Recipes';
  static const recipeDetails = 'Recipe Details';
  static const ingredients = 'Ingredients';
  static const instructions = 'Instructions';
  static const category = 'Category';
  static const area = 'Origin / Area';
  static const watchOnYoutube = 'Watch on YouTube';
  static const products = 'المنتجات';
  static const product = 'منتج';
  static const retry = 'إعادة المحاولة';
}

