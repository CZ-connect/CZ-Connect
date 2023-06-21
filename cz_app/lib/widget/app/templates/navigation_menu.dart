import 'package:cz_app/main.dart';
import 'package:cz_app/widget/app/models/roles.dart';
import 'package:flag/flag_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../auth/user_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String role = UserPreferences.getUserRole();
    //role == Roles.Admin.name || role == Roles.Recruitment.name
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          if (UserPreferences.isLoggedIn())
            ListTile(
              title: Text('${AppLocalizations.of(context)!.loggedInAsPrefix} ${UserPreferences.getUserName()}'),
              key: const Key('logged_in_user_menu_item'),
            ),
          if (!UserPreferences.isLoggedIn())
            ListTile(
              title: Text(AppLocalizations.of(context)!.login),
              key: const Key('login_menu_item'),
              onTap: () {
                context.go('/login');
              },
              enabled: !UserPreferences.isLoggedIn(),
            ),
          if (UserPreferences.isLoggedIn())
            ListTile(
              title: Text(AppLocalizations.of(context)!.logout),
              key: const Key('logout_menu_item'),
              onTap: () {
                context.go('/logout');
              },
              enabled: UserPreferences.isLoggedIn(),
            ),
          if (!UserPreferences.isLoggedIn())
            ListTile(
              title: Text(AppLocalizations.of(context)!.register),
              key: const Key('register_menu_item'),
              onTap: () {
                context.go('/register');
              },
           ),
          if (UserPreferences.isLoggedIn() &&
              (role == Roles.Admin.name || role == Roles.Recruitment.name))
            ListTile(
              title: Text(AppLocalizations.of(context)!.userDashboard),
              key: const Key('user_dashboard_menu_item'),
              onTap: () {
                context.go('/userdashboard');
              },
            ),
          if (UserPreferences.isLoggedIn() &&
              (role == Roles.Admin.name || role == Roles.Recruitment.name))
            ListTile(
              title: Text(AppLocalizations.of(context)!.recruitmentDashboard),
              key: const Key('recruitment_dashboard_menu_item'),
              onTap: () {
                context.go('/recruitmentdashboard');
              },
            ),
          ListTile(
            title: Text(AppLocalizations.of(context)!.applicationForm),
            key: const Key('application_form_menu_item'),
            onTap: () {
              context.go('/');
            },
          ),
          if (UserPreferences.isLoggedIn() &&
              (role == Roles.Admin.name || role == Roles.Recruitment.name))
            ListTile(
              title: Text(AppLocalizations.of(context)!.charts),
              key: const Key('Graph_refferals_menu_item'),
              onTap: () {
                context.go('/graph');
              },
            ),
          if (UserPreferences.isLoggedIn())
            ListTile(
              title: Text(AppLocalizations.of(context)!.referralOverview),
              key: const Key('referral_overview_menu_item'),
              onTap: () {
                context.go('/loading');
              },
            ),
          if (UserPreferences.isLoggedIn() &&
              (role == Roles.Admin.name || role == Roles.Recruitment.name))
            ListTile(
              title: Text(AppLocalizations.of(context)!.departments),
              key: const Key('departments_menu_item'),
              onTap: () {
                context.go('/department/index');
              },
    ),
    ListTile(
    title: Row(
    children: [
      IconButton(
        icon: const Flag.fromString('nl'),
        onPressed: () {
          MyApp.of(context)!.setLocale(const Locale.fromSubtags(languageCode: 'nl'));
        },
      ),
      IconButton(
      icon: const Flag.fromString('us'),
      onPressed: () {
          MyApp.of(context)!.setLocale(const Locale.fromSubtags(languageCode: 'en'));
        },
      ),
    ],
    ),
    )
        ]
      )
    );
  }
}
