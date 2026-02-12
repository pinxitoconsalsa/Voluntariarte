import 'package:flutter/material.dart';
import 'package:voluntariarte/core/theme/app_colors.dart';
import 'package:voluntariarte/core/theme/app_text_styles.dart';
import 'package:voluntariarte/features/shared/widgets/bottom_nav_bar.dart';
import 'package:voluntariarte/services/mock_data_service.dart';

class ImpactDashboardScreen extends StatefulWidget {
  const ImpactDashboardScreen({super.key});

  @override
  State<ImpactDashboardScreen> createState() => _ImpactDashboardScreenState();
}

class _ImpactDashboardScreenState extends State<ImpactDashboardScreen> {
  int _currentIndex = 1;

  void _onNavBarTap(int index) {
    setState(() => _currentIndex = index);
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/volunteer-home');
        break;
      case 1:
        // Ya estamos aquí
        break;
      case 2:
        Navigator.pushNamed(context, '/volunteer-profile');
        break;
      case 3:
        // Ajustes
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.mockVolunteer;
    final badges = MockDataService.mockBadges;
    final earnedBadges = badges.where((b) => b.isEarned).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Impacto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Estadísticas principales
            Text('Tu Impacto', style: AppTextStyles.h2),
            const SizedBox(height: 8),
            Text(
              'Cada hora cuenta, cada acción importa',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            
            // Tarjetas de estadísticas
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.access_time,
                    value: '${user.totalHours}',
                    label: 'Horas',
                    color: AppColors.neonGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.event_available,
                    value: '${user.eventsCompleted}',
                    label: 'Eventos',
                    color: AppColors.info,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events,
                    value: '${earnedBadges.length}',
                    label: 'Medallas',
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.trending_up,
                    value: '${((user.totalHours ?? 0) / 50 * 100).toInt()}%',
                    label: 'Progreso',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Progreso hacia siguiente nivel
            Text('Progreso hacia Maestro del Tiempo', style: AppTextStyles.h4),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${user.totalHours} / 50 horas',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${50 - (user.totalHours ?? 0)} horas restantes',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: (user.totalHours ?? 0) / 50,
                      minHeight: 12,
                      backgroundColor: AppColors.border,
                      valueColor: AlwaysStoppedAnimation<Color>(AppColors.neonGreen),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Medallas obtenidas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Medallas Obtenidas', style: AppTextStyles.h4),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/badges');
                  },
                  child: Text(
                    'Ver todas',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.neonGreen,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: earnedBadges.length,
              itemBuilder: (context, index) {
                final badge = earnedBadges[index];
                return _BadgeCard(
                  name: badge.name,
                  iconName: badge.iconName,
                  isEarned: true,
                );
              },
            ),
            const SizedBox(height: 32),
            
            // Actividad reciente
            Text('Actividad Reciente', style: AppTextStyles.h4),
            const SizedBox(height: 16),
            
            _ActivityItem(
              icon: Icons.check_circle,
              title: 'Evento completado',
              subtitle: 'Limpieza de Playa - 4 horas',
              date: 'Hace 3 días',
              color: AppColors.success,
            ),
            const SizedBox(height: 12),
            _ActivityItem(
              icon: Icons.emoji_events,
              title: 'Nueva medalla obtenida',
              subtitle: 'Mariposa Social',
              date: 'Hace 1 semana',
              color: AppColors.warning,
            ),
            const SizedBox(height: 12),
            _ActivityItem(
              icon: Icons.check_circle,
              title: 'Evento completado',
              subtitle: 'Taller de Reciclaje - 3 horas',
              date: 'Hace 2 semanas',
              color: AppColors.success,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: AppTextStyles.h2.copyWith(color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final String name;
  final String iconName;
  final bool isEarned;

  const _BadgeCard({
    required this.name,
    required this.iconName,
    required this.isEarned,
  });

  IconData _getIcon(String name) {
    switch (name) {
      case 'star':
        return Icons.star;
      case 'eco':
        return Icons.eco;
      case 'people':
        return Icons.people;
      case 'schedule':
        return Icons.schedule;
      case 'school':
        return Icons.school;
      default:
        return Icons.emoji_events;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEarned ? AppColors.neonGreen : AppColors.border,
          width: isEarned ? 2 : 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isEarned 
                  ? AppColors.neonGreen.withOpacity(0.2)
                  : AppColors.border.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIcon(iconName),
              color: isEarned ? AppColors.neonGreen : AppColors.textSecondary,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: AppTextStyles.bodySmall.copyWith(
              color: isEarned ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: isEarned ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;
  final Color color;

  const _ActivityItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(height: 2),
                Text(subtitle, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Text(date, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
