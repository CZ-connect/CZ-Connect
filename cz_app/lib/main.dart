import 'package:cz_app/404.dart';
import 'package:cz_app/widget/app/auth/login.dart';
import 'package:cz_app/widget/app/auth/user_preferences.dart';
import 'package:cz_app/widget/app/departments/create.dart';
import 'package:cz_app/widget/app/departments/index.dart';
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
import 'package:cz_app/widget/app/register/register.dart';
import 'package:cz_app/widget/app/templates/departments/template.dart';
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
import 'package:cz_app/widget/app/user_dashboard/user_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widget/app/departments/edit.dart';
import 'widget/app/models/department.dart';
import 'widget/app/referral_per_user/views/referral_overview.dart';
import 'widget/app/templates/departments/bottom.dart';
import 'widget/app/templates/departments/container.dart';
import 'widget/app/templates/departments/top.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(MyApp());

/// The route configuration.

final GoRouter _router = GoRouter(
  errorBuilder: ((context, state) => const Scaffold(
        body: ScreenTemplate(
          header: TopAppWidget(),
          body: BottemAppWidget(
            child: AppMainContainer(
              child: RouteNotFound(),
            ),
          ),
        ),
      )),
  routes: <RouteBase>[
    GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
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
          );
        }),
    GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) {
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE40429), Color(0xFFFF9200)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const ScreenTemplate(
                header: TopAppWidget(),
                body: BottemAppWidget(
                  child: AppMainContainer(
                    child: RegisterWidget(),
                  ),
                ),
              ),
            ),
          );
        }),
    GoRoute(
        path: '/logout',
        builder: (BuildContext context, GoRouterState state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            UserPreferences.logOut();
            context.go('/');
          });
          return const Scaffold(); // Placeholder widget
        }),
    GoRoute(
      path: '/userdashboard',
      builder: (BuildContext context, GoRouterState state) {
        String role = UserPreferences.getUserRole();
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
          return const Scaffold(
            body: ReferralDashboardTemplate(
              header: ReferralDashboardTopWidget(),
              body: ReferralDashboardBottomWidget(
                child: ReferralDashboardContainerWidget(
                  child: UserDashboard(),
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
      path: '/department/create',
      builder: (BuildContext context, GoRouterState state) {
        String role = UserPreferences.getUserRole();
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
          return const Scaffold(
            body: DepartmentTemplate(
              header: DepartmentTopWidget(),
              body: DepartmentBottomWidget(
                child: DepartmentContainerWidget(
                  child: DepartmentCreationForm(),
                ),
              ),
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/');
          });
          return const Scaffold();
        }
      },
    ),
    GoRoute(
      path: '/department/:id/edit',
      name: 'editDepartment',
      builder: (BuildContext context, GoRouterState state) {
        id:
        state.params['id'];
        String role = UserPreferences.getUserRole();
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
          Department department = state.extra as Department;
          return Scaffold(
            body: DepartmentTemplate(
              header: const DepartmentTopWidget(),
              body: DepartmentBottomWidget(
                child: DepartmentContainerWidget(
                  child: DepartmentUpdateWidget(
                    department: department,
                  ),
                ),
              ),
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/');
          });
          return const Scaffold();
        }
      },
    ),
    GoRoute(
      path: '/department/index',
      builder: (BuildContext context, GoRouterState state) {
        String role = UserPreferences.getUserRole();
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
          return const Scaffold(
            body: DepartmentTemplate(
              header: DepartmentTopWidget(),
              body: DepartmentBottomWidget(
                child: DepartmentContainerWidget(
                  child: DepartmentIndex(),
                ),
              ),
            ),
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go('/');
          });
          return const Scaffold();
        }
      },
    ),
    GoRoute(
      path: '/recruitmentdashboard',
      builder: (BuildContext context, GoRouterState state) {
        String role = UserPreferences.getUserRole();
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
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
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
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
          } else {
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
          if (UserPreferences.isLoggedIn() &&
              (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
            EmployeeReferralViewModel? myExtra =
                state.extra as EmployeeReferralViewModel?;
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
          } else {
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
        if (UserPreferences.isLoggedIn() &&
            (role == Roles.Admin.name || role == Roles.Recruitment.name)) {
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
      },
    ),
  ],
);

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserPreferences.init();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('nl'),
        Locale('en'),
      ],
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
