import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/screens/user_type_selection_screen.dart';
import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/volunteer_register_screen.dart';
import 'features/auth/screens/organization_register_screen.dart';
import 'features/volunteer/screens/volunteer_home_screen.dart';
import 'features/volunteer/screens/event_detail_screen.dart';
import 'features/volunteer/screens/impact_dashboard_screen.dart';
import 'features/volunteer/screens/volunteer_profile_screen.dart';
import 'models/event_model.dart';
import 'services/mock_data_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configurar orientación de pantalla
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Configurar barra de estado
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  
  runApp(const VoluntariArteApp());
}

class VoluntariArteApp extends StatelessWidget {
  const VoluntariArteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VoluntariArte',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: '/user-type-selection',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/user-type-selection':
            return MaterialPageRoute(
              builder: (_) => const UserTypeSelectionScreen(),
            );
          
          case '/login':
            return MaterialPageRoute(
              builder: (_) => const LoginScreen(),
            );
          
          case '/volunteer-register':
            return MaterialPageRoute(
              builder: (_) => const VolunteerRegisterScreen(),
            );
          
          case '/organization-register':
            return MaterialPageRoute(
              builder: (_) => const OrganizationRegisterScreen(),
            );
          
          case '/volunteer-home':
            return MaterialPageRoute(
              builder: (_) => const VolunteerHomeScreen(),
            );
          
          case '/event-detail':
            final event = settings.arguments as EventModel;
            return MaterialPageRoute(
              builder: (_) => EventDetailScreen(event: event),
            );
          
          case '/impact-dashboard':
            return MaterialPageRoute(
              builder: (_) => const ImpactDashboardScreen(),
            );
          
          case '/volunteer-profile':
            return MaterialPageRoute(
              builder: (_) => const VolunteerProfileScreen(),
            );
          
          default:
            return MaterialPageRoute(
              builder: (_) => const UserTypeSelectionScreen(),
            );
        }
      },
      // Ruta por defecto en caso de error
      home: const UserTypeSelectionScreen(),
    );
  }
}
