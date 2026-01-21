import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @one_month_plan.
  ///
  /// In en, this message translates to:
  /// **'1 Month Plan'**
  String get one_month_plan;

  /// No description provided for @six_months_plan.
  ///
  /// In en, this message translates to:
  /// **'6 Months Plan'**
  String get six_months_plan;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @add_to_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Add to watchlist'**
  String get add_to_watchlist;

  /// No description provided for @added_to_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Added to Watchlist'**
  String get added_to_watchlist;

  /// No description provided for @added_to_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Added to watchlist'**
  String get added_to_wishlist;

  /// No description provided for @added_to_wishlistt.
  ///
  /// In en, this message translates to:
  /// **'Added to watchlist'**
  String get added_to_wishlistt;

  /// No description provided for @ago.
  ///
  /// In en, this message translates to:
  /// **' ago'**
  String get ago;

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Kidsflix Club'**
  String get app_name;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure ?'**
  String get are_you_sure;

  /// No description provided for @by_continuing_you_agree_to_our_terms_of_use_and_acknowledge_that_you_have_read_our_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our Terms of Use and acknowledge that you have read our Privacy Policy'**
  String
      get by_continuing_you_agree_to_our_terms_of_use_and_acknowledge_that_you_have_read_our_privacy_policy;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancel_subscription.
  ///
  /// In en, this message translates to:
  /// **'Cancel subscription'**
  String get cancel_subscription;

  /// No description provided for @change_language.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_language;

  /// No description provided for @change_languagee.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get change_languagee;

  /// No description provided for @choose_nlanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get choose_nlanguage;

  /// No description provided for @click_here_to_watch_your_purchase_history.
  ///
  /// In en, this message translates to:
  /// **'Click here to watch your purchase history'**
  String get click_here_to_watch_your_purchase_history;

  /// No description provided for @com_google_firebase_crashlytics_mapping_file_id.
  ///
  /// In en, this message translates to:
  /// **'00000000000000000000000000000000'**
  String get com_google_firebase_crashlytics_mapping_file_id;

  /// No description provided for @continue_watching.
  ///
  /// In en, this message translates to:
  /// **'Continue Watching'**
  String get continue_watching;

  /// No description provided for @continue_with_google.
  ///
  /// In en, this message translates to:
  /// **'Continue with '**
  String get continue_with_google;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **' day'**
  String get day;

  /// No description provided for @delete_account_pop.
  ///
  /// In en, this message translates to:
  /// **'assets/images/delete_account_pop.png'**
  String get delete_account_pop;

  /// No description provided for @logout_account_pop.
  ///
  /// In en, this message translates to:
  /// **'assets/images/pop_logout_img.png'**
  String get logout_account_pop;

  /// No description provided for @sub_now.
  ///
  /// In en, this message translates to:
  /// **'assets/images/sub_now_en.png'**
  String get sub_now;

  /// No description provided for @default_web_client_id.
  ///
  /// In en, this message translates to:
  /// **'342203299442-nh5c30trhhiv9hhbum8h3lu7ti0p930s.apps.googleusercontent.com'**
  String get default_web_client_id;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @delete_accountt.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_accountt;

  /// No description provided for @delete_accounttt.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_accounttt;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'Desc'**
  String get desc;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @edit_number.
  ///
  /// In en, this message translates to:
  /// **'Edit Number'**
  String get edit_number;

  /// No description provided for @edit_profile_picture.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile picture'**
  String get edit_profile_picture;

  /// No description provided for @email_id.
  ///
  /// In en, this message translates to:
  /// **'Email ID'**
  String get email_id;

  /// No description provided for @enter_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Mobile Number'**
  String get enter_mobile_number;

  /// No description provided for @enter_pin_received_via_sms.
  ///
  /// In en, this message translates to:
  /// **'Enter pin received via SMS'**
  String get enter_pin_received_via_sms;

  /// No description provided for @enter_registered_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Enter Registered Mobile Number'**
  String get enter_registered_mobile_number;

  /// No description provided for @find_this_amazing_content_at.
  ///
  /// In en, this message translates to:
  /// **'Find this amazing content at '**
  String get find_this_amazing_content_at;

  /// No description provided for @first_fragment_label.
  ///
  /// In en, this message translates to:
  /// **'First Fragment'**
  String get first_fragment_label;

  /// No description provided for @gcm_defaultSenderId.
  ///
  /// In en, this message translates to:
  /// **'342203299442'**
  String get gcm_defaultSenderId;

  /// No description provided for @get_access_to_ad_free_and_premium_content.
  ///
  /// In en, this message translates to:
  /// **'Get access to ad-free and premium content'**
  String get get_access_to_ad_free_and_premium_content;

  /// No description provided for @get_kidsflix_premium.
  ///
  /// In en, this message translates to:
  /// **'Get KidsFlix Premium'**
  String get get_kidsflix_premium;

  /// No description provided for @get_otp.
  ///
  /// In en, this message translates to:
  /// **'Get otp'**
  String get get_otp;

  /// No description provided for @google_api_key.
  ///
  /// In en, this message translates to:
  /// **'AIzaSyCEVpzwm7PM17Howlsf8tHxwCvO-1thB0A'**
  String get google_api_key;

  /// No description provided for @google_app_id.
  ///
  /// In en, this message translates to:
  /// **'1:342203299442:android:5fa9d6d747d3623356b4eb'**
  String get google_app_id;

  /// No description provided for @google_crash_reporting_api_key.
  ///
  /// In en, this message translates to:
  /// **'AIzaSyCEVpzwm7PM17Howlsf8tHxwCvO-1thB0A'**
  String get google_crash_reporting_api_key;

  /// No description provided for @google_storage_bucket.
  ///
  /// In en, this message translates to:
  /// **'kidsflix-8de1a.appspot.com'**
  String get google_storage_bucket;

  /// No description provided for @header.
  ///
  /// In en, this message translates to:
  /// **'Header'**
  String get header;

  /// No description provided for @hello_blank_fragment.
  ///
  /// In en, this message translates to:
  /// **'Hello blank fragment'**
  String get hello_blank_fragment;

  /// No description provided for @hey_there_stay_tuned_for_the_latest_updates.
  ///
  /// In en, this message translates to:
  /// **'Hey there Stay tuned for the latest Updates!!'**
  String get hey_there_stay_tuned_for_the_latest_updates;

  /// No description provided for @history_item.
  ///
  /// In en, this message translates to:
  /// **'History Item'**
  String get history_item;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **' hour'**
  String get hour;

  /// No description provided for @i_am_18_or_above_and_i_agree_to_terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get i_am_18_or_above_and_i_agree_to_terms_conditions;

  /// No description provided for @i_agree_to.
  ///
  /// In en, this message translates to:
  /// **'I agree to'**
  String get i_agree_to;

  /// No description provided for @it_seems_you_don_t_have_any_active_plan_click_below_button_to_activate_your_plan.
  ///
  /// In en, this message translates to:
  /// **'It seems you don’t have any active plan click below button to activate your plan'**
  String
      get it_seems_you_don_t_have_any_active_plan_click_below_button_to_activate_your_plan;

  /// No description provided for @just_now.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get just_now;

  /// No description provided for @keep_track_of_your_favourite_rhymes_documentaries_songs_you_want_to_watch.
  ///
  /// In en, this message translates to:
  /// **'Keep track of your favourite rhymes documentaries, songs you want to watch!!'**
  String
      get keep_track_of_your_favourite_rhymes_documentaries_songs_you_want_to_watch;

  /// No description provided for @kidsflix_premium.
  ///
  /// In en, this message translates to:
  /// **'Kidsflix Premium'**
  String get kidsflix_premium;

  /// No description provided for @letsgofragment.
  ///
  /// In en, this message translates to:
  /// **'LetsGoFragment'**
  String get letsgofragment;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @link_portal_subscription.
  ///
  /// In en, this message translates to:
  /// **'Link Portal Subscription'**
  String get link_portal_subscription;

  /// No description provided for @link_portal_subscriptionn.
  ///
  /// In en, this message translates to:
  /// **'Link Portal Subscription'**
  String get link_portal_subscriptionn;

  /// No description provided for @loading_your_next_video.
  ///
  /// In en, this message translates to:
  /// **'Loading your next video ...'**
  String get loading_your_next_video;

  /// No description provided for @login_register.
  ///
  /// In en, this message translates to:
  /// **'Login / Register'**
  String get login_register;

  /// No description provided for @login_subscribe.
  ///
  /// In en, this message translates to:
  /// **'Login / Subscribe'**
  String get login_subscribe;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @lorem_ipsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in scelerisque sem. Mauris volutpat'**
  String get lorem_ipsum;

  /// No description provided for @minute.
  ///
  /// In en, this message translates to:
  /// **' minute '**
  String get minute;

  /// No description provided for @minutee.
  ///
  /// In en, this message translates to:
  /// **' minute'**
  String get minutee;

  /// No description provided for @mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_number;

  /// No description provided for @mobile_numberr.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobile_numberr;

  /// No description provided for @my_account.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get my_account;

  /// No description provided for @my_subscription.
  ///
  /// In en, this message translates to:
  /// **'My Subscription'**
  String get my_subscription;

  /// No description provided for @n_a.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get n_a;

  /// No description provided for @n_aa.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get n_aa;

  /// No description provided for @n_aaa.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get n_aaa;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @next_billing_date.
  ///
  /// In en, this message translates to:
  /// **'Next Billing Date'**
  String get next_billing_date;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notification;

  /// No description provided for @notificationnn.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationnn;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @ooops_nothing_found.
  ///
  /// In en, this message translates to:
  /// **'Ooops !! Nothing found'**
  String get ooops_nothing_found;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @optionse.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get optionse;

  /// No description provided for @optionss.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get optionss;

  /// No description provided for @optionsss.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get optionsss;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @play_game.
  ///
  /// In en, this message translates to:
  /// **'Play Game'**
  String get play_game;

  /// No description provided for @please_accept_terms_and_conditions.
  ///
  /// In en, this message translates to:
  /// **'Please accept terms and conditions'**
  String get please_accept_terms_and_conditions;

  /// No description provided for @please_enter_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter number'**
  String get please_enter_number;

  /// No description provided for @please_enter_the_otp_sent_to_your_registered_mobile_number.
  ///
  /// In en, this message translates to:
  /// **'Please enter the otp sent to your registered mobile number'**
  String get please_enter_the_otp_sent_to_your_registered_mobile_number;

  /// No description provided for @please_enter_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Please Enter valid Number'**
  String get please_enter_valid_number;

  /// No description provided for @please_enter_valid_numberr.
  ///
  /// In en, this message translates to:
  /// **'Please enter valid number'**
  String get please_enter_valid_numberr;

  /// No description provided for @please_enter_your_birth_year.
  ///
  /// In en, this message translates to:
  /// **'Please enter your birth year'**
  String get please_enter_your_birth_year;

  /// No description provided for @please_login_first_to_continue.
  ///
  /// In en, this message translates to:
  /// **'Login Required !!'**
  String get please_login_first_to_continue;

  /// No description provided for @prepaid_and_subscription_plans_available_on_discounted_price_nprice_starts_at_5_month_2_month.
  ///
  /// In en, this message translates to:
  /// **'Prepaid and subscription plans available on discounted price.\n\nPrice starts at \$5/month \$2/month '**
  String
      get prepaid_and_subscription_plans_available_on_discounted_price_nprice_starts_at_5_month_2_month;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @privacy_and_t_amp_c.
  ///
  /// In en, this message translates to:
  /// **'Privacy and T&C'**
  String get privacy_and_t_amp_c;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @project_id.
  ///
  /// In en, this message translates to:
  /// **'kidsflix-8de1a'**
  String get project_id;

  /// No description provided for @rate_our_app.
  ///
  /// In en, this message translates to:
  /// **'Rate Our App'**
  String get rate_our_app;

  /// No description provided for @recently_searched.
  ///
  /// In en, this message translates to:
  /// **'Recently Searched'**
  String get recently_searched;

  /// No description provided for @recently_searchedd.
  ///
  /// In en, this message translates to:
  /// **'Recently Searched'**
  String get recently_searchedd;

  /// No description provided for @recently_searcheddd.
  ///
  /// In en, this message translates to:
  /// **'Recently Searched'**
  String get recently_searcheddd;

  /// No description provided for @registerfragment.
  ///
  /// In en, this message translates to:
  /// **'RegisterFragment'**
  String get registerfragment;

  /// No description provided for @remove_from_continue_watch.
  ///
  /// In en, this message translates to:
  /// **'Remove from continue watch'**
  String get remove_from_continue_watch;

  /// No description provided for @remove_from_watchlist.
  ///
  /// In en, this message translates to:
  /// **'Remove from watchlist'**
  String get remove_from_watchlist;

  /// No description provided for @remove_from_wishlist.
  ///
  /// In en, this message translates to:
  /// **'Remove from \nwatchlist'**
  String get remove_from_wishlist;

  /// No description provided for @resend_otp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resend_otp;

  /// No description provided for @resend_otp_in.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in'**
  String get resend_otp_in;

  /// No description provided for @resend_otp_inn.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP in'**
  String get resend_otp_inn;

  /// No description provided for @result_for.
  ///
  /// In en, this message translates to:
  /// **'Result for \''**
  String get result_for;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'s'**
  String get s;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @second_fragment_label.
  ///
  /// In en, this message translates to:
  /// **'Second Fragment'**
  String get second_fragment_label;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **' seconds'**
  String get seconds;

  /// No description provided for @secondss.
  ///
  /// In en, this message translates to:
  /// **' seconds'**
  String get secondss;

  /// No description provided for @select_display_picture.
  ///
  /// In en, this message translates to:
  /// **'Select display Picture'**
  String get select_display_picture;

  /// No description provided for @select_operator.
  ///
  /// In en, this message translates to:
  /// **'Select Operator'**
  String get select_operator;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settingss.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingss;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @sharee.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get sharee;

  /// No description provided for @shareee.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareee;

  /// No description provided for @shareeee.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareeee;

  /// No description provided for @sharer.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get sharer;

  /// No description provided for @sign_up_with.
  ///
  /// In en, this message translates to:
  /// **'Sign up with'**
  String get sign_up_with;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'SKIP'**
  String get skip;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @something_went_wrongg.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrongg;

  /// No description provided for @started_on.
  ///
  /// In en, this message translates to:
  /// **'Started On'**
  String get started_on;

  /// No description provided for @starter_pack.
  ///
  /// In en, this message translates to:
  /// **'Starter Pack'**
  String get starter_pack;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @subscription_details.
  ///
  /// In en, this message translates to:
  /// **'Subscription Details'**
  String get subscription_details;

  /// No description provided for @subscription_status.
  ///
  /// In en, this message translates to:
  /// **'Subscription Status'**
  String get subscription_status;

  /// No description provided for @subtitle.
  ///
  /// In en, this message translates to:
  /// **'Subtitle'**
  String get subtitle;

  /// No description provided for @the_app_is_specially_designed_for_kids_please_select_kid_s_birth_year.
  ///
  /// In en, this message translates to:
  /// **'The app is specially designed for Kids. Please select Kid\'s birth year'**
  String
      get the_app_is_specially_designed_for_kids_please_select_kid_s_birth_year;

  /// No description provided for @the_information_is_not_stored_and_is_only_used_to_confirm_that_you_are_a_grown_up.
  ///
  /// In en, this message translates to:
  /// **'The information is not stored and is only used to confirm to enable certain functionality.'**
  String
      get the_information_is_not_stored_and_is_only_used_to_confirm_that_you_are_a_grown_up;

  /// No description provided for @timee.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timee;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @title_activity_home.
  ///
  /// In en, this message translates to:
  /// **'HomeActivity'**
  String get title_activity_home;

  /// No description provided for @title_activity_main2.
  ///
  /// In en, this message translates to:
  /// **'MainActivity2'**
  String get title_activity_main2;

  /// No description provided for @titlee.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titlee;

  /// No description provided for @titleee.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleee;

  /// No description provided for @unsubscribe.
  ///
  /// In en, this message translates to:
  /// **'Unsubscribe'**
  String get unsubscribe;

  /// No description provided for @v.
  ///
  /// In en, this message translates to:
  /// **'v '**
  String get v;

  /// No description provided for @v_1_2_0.
  ///
  /// In en, this message translates to:
  /// **'v 1.2.0'**
  String get v_1_2_0;

  /// No description provided for @verify_otp.
  ///
  /// In en, this message translates to:
  /// **'Verify Otp'**
  String get verify_otp;

  /// No description provided for @video_quality.
  ///
  /// In en, this message translates to:
  /// **'Video Quality'**
  String get video_quality;

  /// No description provided for @video_qualityy.
  ///
  /// In en, this message translates to:
  /// **'Video Quality'**
  String get video_qualityy;

  /// No description provided for @watchlist.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get watchlist;

  /// No description provided for @watchlistt.
  ///
  /// In en, this message translates to:
  /// **'Watchlist'**
  String get watchlistt;

  /// No description provided for @watchlistttt.
  ///
  /// In en, this message translates to:
  /// **'WatchList'**
  String get watchlistttt;

  /// No description provided for @weekly_10.
  ///
  /// In en, this message translates to:
  /// **'Weekly 10\$'**
  String get weekly_10;

  /// No description provided for @welcome_aboard_young_explorers_let_s_embark_on_the_kidsflix_club_journey_of_stories_rhymes_games_and_documentaries.
  ///
  /// In en, this message translates to:
  /// **'Welcome aboard, young explorers! Let\'s embark on the KidsFlix Club journey of stories, rhymes, games, and documentaries!'**
  String
      get welcome_aboard_young_explorers_let_s_embark_on_the_kidsflix_club_journey_of_stories_rhymes_games_and_documentaries;

  /// No description provided for @welcome_to_the_new_home_of_all_your_favourite_kids_content_full_with_learnings_entertainment_amp_premium_content.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the new home of all your favourite Kids Content. Full with Learnings Entertainment & Premium Content'**
  String
      get welcome_to_the_new_home_of_all_your_favourite_kids_content_full_with_learnings_entertainment_amp_premium_content;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @continue_with_apple.
  ///
  /// In en, this message translates to:
  /// **'Continue with '**
  String get continue_with_apple;

  /// No description provided for @you_don_t_have_a_valid_portal_subscription.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have a valid Portal Subscription'**
  String get you_don_t_have_a_valid_portal_subscription;

  /// No description provided for @you_have_successfully_linked_your_portal_subscription.
  ///
  /// In en, this message translates to:
  /// **'You have successfully linked your Portal Subscription'**
  String get you_have_successfully_linked_your_portal_subscription;

  /// No description provided for @your_kidsflix_membership_renews_each_month_or_after_6_months_depending_on_the_billing_cycle_you_choose_you_can_manage_your_subscription_and_turn_off_auto_renew_at_any_time_through_the_play_store_your_kidsflix_membership_will_be_billed_in_your_local_currency_using_exchange_rates_set_by_google_play_your_payments_will_be_processed_by_google_play_within_24_hours_of_the_end_of_the_current_billing_cycle.
  ///
  /// In en, this message translates to:
  /// **'Your Kidsflix membership will start instantly after the purchase and renews each month or after 6 months, depending on the billing cycle you choose. You can manage your subscription and turn off auto-renew at any time through the Play Store. Your kidsflix membership will be billed in your local currency, using exchange rates set by Google Play. Your payments will be processed by Google Play within 24 hours of the end of the current billing cycle. You can easily cancel the subscription at any time by using membership section of the profile which will redirect you to play store subscription page after you make the purchase.'**
  String
      get your_kidsflix_membership_renews_each_month_or_after_6_months_depending_on_the_billing_cycle_you_choose_you_can_manage_your_subscription_and_turn_off_auto_renew_at_any_time_through_the_play_store_your_kidsflix_membership_will_be_billed_in_your_local_currency_using_exchange_rates_set_by_google_play_your_payments_will_be_processed_by_google_play_within_24_hours_of_the_end_of_the_current_billing_cycle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
