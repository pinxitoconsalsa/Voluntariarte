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
        Navigator.pushNamed(context, '/volunteer-settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    value: '0',
                    label: 'Horas',
                    color: AppColors.neonGreen,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.event_available,
                    value: '0',
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
                    value: '0',
                    label: 'Medallas',
                    color: AppColors.warning,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.trending_up,
                    value: '0%',
                    label: 'Progreso',
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Progreso hacia siguiente nivel
            Text('Progreso hacia siguiente nivel', style: AppTextStyles.h4),
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
                        '0 / 50 horas',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '50 horas restantes',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: 0,
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
            
            earnedBadges.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 48,
                          color: AppColors.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Aún no has desbloqueado ninguna medalla',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Completa eventos para ganar medallas y badges especiales',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textSecondary.withOpacity(0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
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
            
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.history_outlined,
                    size: 48,
                    color: AppColors.textSecondary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No hay actividad aún',
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tu actividad aparecerá aquí cuando completes eventos',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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

