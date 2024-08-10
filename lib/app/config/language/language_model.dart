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

  String toRawJson() => json.encode(toJson());

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
        navBar: NavBar.fromJson(json['nav-bar']),
        settings: Settings.fromJson(json['settings']),
        live: Live.fromJson(json['live']),
        alertSession: AlertSession.fromJson(json['alert-session']),
      );

  Map<String, dynamic> toJson() => {
        'nav-bar': navBar.toJson(),
        'settings': settings.toJson(),
        'live': live.toJson(),
        'alert-session': alertSession.toJson(),
      };
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

  String toRawJson() => json.encode(toJson());

  factory AlertSession.fromJson(Map<String, dynamic> json) => AlertSession(
        title: json['title'],
        desc: json['desc'],
        button: json['button'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'desc': desc,
        'button': button,
      };
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

  String toRawJson() => json.encode(toJson());

  factory Live.fromJson(Map<String, dynamic> json) => Live(
        appBarTitle: json['app-bar-title'],
        userSection: UserSection.fromJson(json['user-section']),
        storeSection: StoreSection.fromJson(json['store-section']),
      );

  Map<String, dynamic> toJson() => {
        'app-bar-title': appBarTitle,
        'user-section': userSection.toJson(),
        'store-section': storeSection.toJson(),
      };
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

  String toRawJson() => json.encode(toJson());

  factory StoreSection.fromJson(Map<String, dynamic> json) => StoreSection(
        title: json['title'],
        noDataStore: json['no-data-store'],
        refreshTitle: json['refresh-title'],
        titleModal: json['title-modal'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'no-data-store': noDataStore,
        'refresh-title': refreshTitle,
        'title-modal': titleModal,
      };
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

  String toRawJson() => json.encode(toJson());

  factory UserSection.fromJson(Map<String, dynamic> json) => UserSection(
        title: json['title'],
        notLogginAccount: json['not-loggin-account'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'not-loggin-account': notLogginAccount,
      };
}

class NavBar {
  final String live;
  final String settings;

  NavBar({
    required this.live,
    required this.settings,
  });

  factory NavBar.fromRawJson(String str) => NavBar.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NavBar.fromJson(Map<String, dynamic> json) => NavBar(
        live: json['live'],
        settings: json['settings'],
      );

  Map<String, dynamic> toJson() => {
        'live': live,
        'settings': settings,
      };
}

class Settings {
  final String appBarTitle;
  final AccountSection accountSection;
  final CheckerSection checkerSection;
  final SettingsSection settingsSection;
  final OptionsSection optionsSection;

  Settings({
    required this.appBarTitle,
    required this.accountSection,
    required this.checkerSection,
    required this.settingsSection,
    required this.optionsSection,
  });

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        appBarTitle: json['app-bar-title'],
        accountSection: AccountSection.fromJson(json['account-section']),
        checkerSection: CheckerSection.fromJson(json['checker-section']),
        settingsSection: SettingsSection.fromJson(json['settings-section']),
        optionsSection: OptionsSection.fromJson(json['options-section']),
      );

  Map<String, dynamic> toJson() => {
        'app-bar-title': appBarTitle,
        'account-section': accountSection.toJson(),
        'checker-section': checkerSection.toJson(),
        'settings-section': settingsSection.toJson(),
        'options-section': optionsSection.toJson(),
      };
}

class AccountSection {
  final String title;
  final String notLogginAccount;
  final String loginButton;
  final String logoutButton;
  final String logoutAllButton;
  final AlertSession infoButton;

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

  String toRawJson() => json.encode(toJson());

  factory AccountSection.fromJson(Map<String, dynamic> json) => AccountSection(
        title: json['title'],
        notLogginAccount: json['not-loggin-account'],
        loginButton: json['login-button'],
        logoutButton: json['logout-button'],
        logoutAllButton: json['logout-all-button'],
        infoButton: AlertSession.fromJson(json['info-button']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'not-loggin-account': notLogginAccount,
        'login-button': loginButton,
        'logout-button': logoutButton,
        'logout-all-button': logoutAllButton,
        'info-button': infoButton.toJson(),
      };
}

class CheckerSection {
  final String title;
  final String checkUpdatesButton;
  final String versionApp;
  final String newVersion;
  final String restarButton;
  final String installButton;
  final Notes notes;

  CheckerSection({
    required this.title,
    required this.checkUpdatesButton,
    required this.versionApp,
    required this.newVersion,
    required this.restarButton,
    required this.installButton,
    required this.notes,
  });

  factory CheckerSection.fromRawJson(String str) =>
      CheckerSection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheckerSection.fromJson(Map<String, dynamic> json) => CheckerSection(
        title: json['title'],
        checkUpdatesButton: json['check-updates-button'],
        versionApp: json['version-app'],
        newVersion: json['new-version'],
        restarButton: json['restar-button'],
        installButton: json['install-button'],
        notes: Notes.fromJson(json['notes']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'check-updates-button': checkUpdatesButton,
        'version-app': versionApp,
        'new-version': newVersion,
        'restar-button': restarButton,
        'install-button': installButton,
        'notes': notes.toJson(),
      };
}

class Notes {
  final String title;
  final String modeInstallAuto;
  final String modeInstallManual;
  final String statusUpdateActive;
  final String statusUpdateInactive;
  final String statusInstallation;
  final String status;
  final String allNotesButton;

  Notes({
    required this.title,
    required this.modeInstallAuto,
    required this.modeInstallManual,
    required this.statusUpdateActive,
    required this.statusUpdateInactive,
    required this.statusInstallation,
    required this.status,
    required this.allNotesButton,
  });

  factory Notes.fromRawJson(String str) => Notes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Notes.fromJson(Map<String, dynamic> json) => Notes(
        title: json['title'],
        modeInstallAuto: json['mode-install-auto'],
        modeInstallManual: json['mode-install-manual'],
        statusUpdateActive: json['status-update-active'],
        statusUpdateInactive: json['status-update-inactive'],
        statusInstallation: json['status-installation'],
        status: json['status'],
        allNotesButton: json['all-notes-button'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'mode-install-auto': modeInstallAuto,
        'mode-install-manual': modeInstallManual,
        'status-update-active': statusUpdateActive,
        'status-update-inactive': statusUpdateInactive,
        'status-installation': statusInstallation,
        'status': status,
        'all-notes-button': allNotesButton,
      };
}

class OptionsSection {
  final String title;
  final LanguageOption languageOption;

  OptionsSection({
    required this.title,
    required this.languageOption,
  });

  factory OptionsSection.fromRawJson(String str) =>
      OptionsSection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OptionsSection.fromJson(Map<String, dynamic> json) => OptionsSection(
        title: json['title'],
        languageOption: LanguageOption.fromJson(json['language-option']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'language-option': languageOption.toJson(),
      };
}

class LanguageOption {
  final String title;
  final String text;
  final String titleModal;
  final String cancelButton;

  LanguageOption({
    required this.title,
    required this.text,
    required this.titleModal,
    required this.cancelButton,
  });

  factory LanguageOption.fromRawJson(String str) =>
      LanguageOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LanguageOption.fromJson(Map<String, dynamic> json) => LanguageOption(
        title: json['title'],
        text: json['text'],
        titleModal: json['title-modal'],
        cancelButton: json['cancel-button'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'text': text,
        'title-modal': titleModal,
        'cancel-button': cancelButton,
      };
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

  String toRawJson() => json.encode(toJson());

  factory SettingsSection.fromJson(Map<String, dynamic> json) =>
      SettingsSection(
        title: json['title'],
        changeLanguageTitle: json['change-language-title'],
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'change-language-title': changeLanguageTitle,
      };
}
