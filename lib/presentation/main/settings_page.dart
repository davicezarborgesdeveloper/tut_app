import 'package:complete_advanced_flutter/presentation/resources/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/app_prefs.dart';
import '../../app/di.dart';
import '../../data/data_source/local_data_source.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppPadding.p8),
      children: [
        ListTile(
          title: Text(
            AppStrings.changeLanguage,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.changeLangIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _changeLanguage();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.contactUs,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.contactUsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _contactUs();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.inviteYourFriends,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.inviteFriendsIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _inviteFriends();
          },
        ),
        ListTile(
          title: Text(
            AppStrings.logout,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          leading: SvgPicture.asset(ImageAssets.logoutIc),
          trailing: SvgPicture.asset(ImageAssets.settingsRightArrowIc),
          onTap: () {
            _logout();
          },
        )
      ],
    );
  }

  void _changeLanguage() {
    // i will apply localisation later
  }

  void _contactUs() {
    // its a task for you to open any web bage with dummy content
  }

  void _inviteFriends() {
    // its a task to share app name with friends
  }

  void _logout() {
    _appPreferences.logout(); // clear login flag from app prefs
    _localDataSource.clearCache();
    Navigator.pushReplacementNamed(context, Routes.loginRoute);
  }
}
