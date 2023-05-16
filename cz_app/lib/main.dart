import 'package:cz_app/widget/app/auth/login.dart';
import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/models/employee.dart';
import 'package:cz_app/widget/app/models/employee_referral.dart';
import 'package:cz_app/widget/app/models/referral.dart';
import 'package:cz_app/widget/app/models/roles.dart';
import 'package:cz_app/widget/app/recruitment_dashboard/recruitment_index.dart';
import 'package:cz_app/widget/app/referral_dashboard/graphs/graph_widget.dart';
import 'package:cz_app/widget/app/referral_dashboard/referrals_index.dart';
import 'package:cz_app/widget/app/referral_details/referral_details.dart';
import 'package:cz_app/widget/app/referral_form/store_input.dart';
import 'package:cz_app/widget/app/referral_per_user/views/error.dart';
import 'package:cz_app/widget/app/referral_per_user/views/loading.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/bottom.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/container.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/template.dart';
import 'package:cz_app/widget/app/templates/referral_dashboard/top.dart';
import 'package:cz_app/widget/app/templates/referral_form/app_main_container.dart';
import 'package:cz_app/widget/app/templates/referral_form/top_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/bottom_app_layout.dart';
import 'package:cz_app/widget/app/templates/referral_form/screen_template.dart';
import 'package:cz_app/widget/app/templates/referral_overview/container.dart';
import 'package:cz_app/widget/app/templates/referral_overview/template.dart';
import 'package:cz_app/widget/app/templates/referral_overview/top.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widget/app/referral_per_user/views/referral_overview.dart';

void main() => runApp(const MyApp());

/// The route configuration.

final GoRouter _router = GoRouter(routes: <RouteBase>[
  GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state){
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ScreenTemplate(
              header: const TopAppWidget(),
              body: BottemAppWidget(
                child: AppMainContainer(
                  child: LoginWidget(),
                ),
              ),
            ),
          ),
        );}
  ),

  GoRoute(
      path: '/logout',
      builder: (BuildContext context, GoRouterState state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          UserPreferences.logOut();
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
  ),
  GoRoute(
    path: '/recruitmentdashboard',
    builder: (BuildContext context, GoRouterState state) {
      String role = UserPreferences.getUserRole();
      if (UserPreferences.isLoggedIn() && (role == Roles.Admin.name || role == Roles.Recruitment.name) ) {
        return const Scaffold(
          body: ReferralDashboardTemplate(
            header: ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: RecruitmentDashboardIndexWidget(),
              ),
            ),
          ),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
    },
  ),
  GoRoute(
    path: '/referraldashboard',
    builder: (BuildContext context, GoRouterState state) {
    String role = UserPreferences.getUserRole();
    if (UserPreferences.isLoggedIn() && (role == Roles.Admin.name || role == Roles.Recruitment.name) ) {
        Employee? employee = state.extra as Employee?;
        return Scaffold(
          body: ReferralDashboardTemplate(
            header: const ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: ReferralDashboardIndexWidget(employee: employee),
              ),
            ),
          ),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
    },
  ),
  GoRoute(
      path: '/referralOverview',
      builder: (context, state) {
        if (UserPreferences.isLoggedIn()) {
          List<Referral>? referrals = state.extra as List<Referral>?;
          if (referrals == null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/');
            });
            return const Scaffold();
          }
          return Scaffold(
              body: ReferralOverviewTemplate(
                header: const ReferralOverviewTopWidget(),
                body: ReferralOverviewContainerWidget(
                    child: ReferralOverview(referrals: referrals!)),
              ));
        }
        else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/');
          });
          return const Scaffold(); // Placeholder widget
        }
      }),
  GoRoute(
      path: '/referraldetail',
      builder: (context, state) {
      String role = UserPreferences.getUserRole();
      if (UserPreferences.isLoggedIn() && (role == Roles.Admin.name || role == Roles.Recruitment.name) ) {
        EmployeeReferralViewModel? myExtra = state.extra as EmployeeReferralViewModel?;
        if (myExtra?.referral == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/referraldashboard');
          });
          return const Scaffold();
        }
      return Scaffold(
          body: ReferralDashboardTemplate(
            header: const ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: ReferralDetailWidget(employeeReferral: myExtra),
              ),
            ),
          ),
        );
      }
    else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      return const Scaffold(); // Placeholder widget
    }
  }),
  GoRoute(
    path: '/loading',
    builder: (BuildContext context, GoRouterState state) {
      if (UserPreferences.isLoggedIn()) {
        return const LoadingWidget();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
    },
  ),
  GoRoute(
    path: '/error',
    builder: (BuildContext context, GoRouterState state) {
      if (UserPreferences.isLoggedIn()) {
        return const ErrorScreen();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
    },
  ),
  GoRoute(
    path: '/graph',
    builder: (context, state) {
      String role = UserPreferences.getUserRole();
      if (UserPreferences.isLoggedIn() && (role == Roles.Admin.name || role == Roles.Recruitment.name) ) {
        return const Scaffold(
          body: ReferralDashboardTemplate(
            header: ReferralDashboardTopWidget(),
            body: ReferralDashboardBottomWidget(
              child: ReferralDashboardContainerWidget(
                child: LineChartSample(),
              ),
            ),
          ),
        );
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/');
        });
        return const Scaffold(); // Placeholder widget
      }
    },
  ),
  GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        String? referral = state.queryParams['referral'];
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ScreenTemplate(
              header: const TopAppWidget(),
              body: BottemAppWidget(
                child: AppMainContainer(
                  child: FormWidget(referral: referral),
                ),
              ),
            ),
          ),
        );
      }),
]);

/// The main app.
class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    UserPreferences.init();
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
