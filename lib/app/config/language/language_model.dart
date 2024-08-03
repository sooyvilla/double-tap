import 'dart:convert';

class LanguageModel {
  final NavBar navBar;
  final Settings settings;
  final Live live;
  final AlertSession alertSession;

  LanguageModel({
    required this.navBar,
    required this.settings,
    required this.live,
    required this.alertSession,
  });

  factory LanguageModel.fromRawJson(String str) =>
      LanguageModel.fromJson(json.decode(str));

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        navBar: NavBar.fromJson(json['nav-bar']),
        settings: Settings.fromJson(json['settings']),
        live: Live.fromJson(json['live']),
        alertSession: AlertSession.fromJson(json['alert-session']),
      );
}

class AlertSession {
  final String title;
  final String desc;
  final String button;

  AlertSession({
    required this.title,
    required this.desc,
    required this.button,
  });

  factory AlertSession.fromRawJson(String str) =>
      AlertSession.fromJson(json.decode(str));

  factory AlertSession.fromJson(Map<String, dynamic> json) => AlertSession(
        title: json['title'],
        desc: json['desc'],
        button: json['button'],
      );
}

class Live {
  final String appBarTitle;
  final UserSection userSection;
  final StoreSection storeSection;

  Live({
    required this.appBarTitle,
    required this.userSection,
    required this.storeSection,
  });

  factory Live.fromRawJson(String str) => Live.fromJson(json.decode(str));

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        appBarTitle: json['app-bar-title'],
        userSection: UserSection.fromJson(json['user-section']),
        storeSection: StoreSection.fromJson(json['store-section']),
      );
}

class StoreSection {
  final String title;
  final String noDataStore;
  final String refreshTitle;
  final String titleModal;

  StoreSection({
    required this.title,
    required this.noDataStore,
    required this.refreshTitle,
    required this.titleModal,
  });

  factory StoreSection.fromRawJson(String str) =>
      StoreSection.fromJson(json.decode(str));

  factory StoreSection.fromJson(Map<String, dynamic> json) => StoreSection(
        title: json['title'],
        noDataStore: json['no-data-store'],
        refreshTitle: json['refresh-title'],
        titleModal: json['title-modal'],
      );
}

class UserSection {
  final String title;
  final String notLogginAccount;

  UserSection({
    required this.title,
    required this.notLogginAccount,
  });

  factory UserSection.fromRawJson(String str) =>
      UserSection.fromJson(json.decode(str));

  factory UserSection.fromJson(Map<String, dynamic> json) => UserSection(
        title: json['title'],
        notLogginAccount: json['not-loggin-account'],
      );
}

class NavBar {
  final String live;
  final String settings;

  NavBar({
    required this.live,
    required this.settings,
  });

  factory NavBar.fromRawJson(String str) => NavBar.fromJson(json.decode(str));

  factory NavBar.fromJson(Map<String, dynamic> json) => NavBar(
        live: json['live'],
        settings: json['settings'],
      );
}

class Settings {
  final String appBarTitle;
  final AccountSection accountSection;
  final CheckerSection checkerSection;
  final SettingsSection settingsSection;

  Settings({
    required this.appBarTitle,
    required this.accountSection,
    required this.checkerSection,
    required this.settingsSection,
  });

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        appBarTitle: json['app-bar-title'],
        accountSection: AccountSection.fromJson(json['account-section']),
        checkerSection: CheckerSection.fromJson(json['checker-section']),
        settingsSection: SettingsSection.fromJson(json['settings-section']),
      );
}

class AccountSection {
  final String title;
  final String notLogginAccount;
  final String loginButton;
  final String logoutButton;
  final String logoutAllButton;
  final InfoButton infoButton;

  AccountSection({
    required this.title,
    required this.notLogginAccount,
    required this.loginButton,
    required this.logoutButton,
    required this.logoutAllButton,
    required this.infoButton,
  });

  factory AccountSection.fromRawJson(String str) =>
      AccountSection.fromJson(json.decode(str));

  factory AccountSection.fromJson(Map<String, dynamic> json) => AccountSection(
        title: json['title'],
        notLogginAccount: json['not-loggin-account'],
        loginButton: json['login-button'],
        logoutButton: json['logout-button'],
        logoutAllButton: json['logout-all-button'],
        infoButton: InfoButton.fromJson(json['info-button']),
      );
}

class InfoButton {
  final String title;
  final String desc;
  final String button;

  InfoButton({
    required this.title,
    required this.desc,
    required this.button,
  });

  factory InfoButton.fromRawJson(String str) =>
      InfoButton.fromJson(json.decode(str));

  factory InfoButton.fromJson(Map<String, dynamic> json) => InfoButton(
        title: json['title'],
        desc: json['desc'],
        button: json['button'],
      );
}

class CheckerSection {
  final String title;
  final String checkUpdatesButton;
  final String versionApp;
  final String installButton;
  final Notes notes;

  CheckerSection({
    required this.title,
    required this.checkUpdatesButton,
    required this.versionApp,
    required this.installButton,
    required this.notes,
  });

  factory CheckerSection.fromRawJson(String str) =>
      CheckerSection.fromJson(json.decode(str));

  factory CheckerSection.fromJson(Map<String, dynamic> json) => CheckerSection(
        title: json['title'],
        checkUpdatesButton: json['check-updates-button'],
        versionApp: json['version-app'],
        installButton: json['install-button'],
        notes: Notes.fromJson(json['notes']),
      );
}

class Notes {
  final String statusInstallation;
  final String status;
  final String allNotesButton;

  Notes({
    required this.statusInstallation,
    required this.status,
    required this.allNotesButton,
  });

  factory Notes.fromRawJson(String str) => Notes.fromJson(json.decode(str));

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        statusInstallation: json['status-Installation'],
        status: json['status'],
        allNotesButton: json['all-notes-button'],
      );
}

class SettingsSection {
  final String title;
  final String changeLanguageTitle;

  SettingsSection({
    required this.title,
    required this.changeLanguageTitle,
  });

  factory SettingsSection.fromRawJson(String str) =>
      SettingsSection.fromJson(json.decode(str));

  factory SettingsSection.fromJson(Map<String, dynamic> json) =>
      SettingsSection(
        title: json['title'],
        changeLanguageTitle: json['change-language-title'],
      );
}
