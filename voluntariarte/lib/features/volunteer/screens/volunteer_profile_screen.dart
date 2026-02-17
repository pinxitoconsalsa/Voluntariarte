import 'package:flutter/material.dart';
import 'package:voluntariarte/core/theme/app_colors.dart';
import 'package:voluntariarte/core/theme/app_text_styles.dart';
import 'package:voluntariarte/features/shared/widgets/bottom_nav_bar.dart';
import 'package:voluntariarte/features/shared/widgets/custom_button.dart';
import 'package:voluntariarte/services/mock_data_service.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({super.key});

  @override
  State<VolunteerProfileScreen> createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  int _currentIndex = 2;

  void _onNavBarTap(int index) {
    setState(() => _currentIndex = index);
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/volunteer-home');
        break;
      case 1:
        Navigator.pushNamed(context, '/impact-dashboard');
        break;
      case 2:
        // Ya estamos aquí
        break;
      case 3:
        Navigator.pushNamed(context, '/volunteer-settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.mockVolunteer;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Editar perfil
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header con foto y nombre
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.neonGreen, width: 3),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.neonGreen.withOpacity(0.3),
                          AppColors.cardBackground,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.neonGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Text(user.name, style: AppTextStyles.h2),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Bio
                  if (user.bio != null)
                    Text(
                      user.bio!,
                      style: AppTextStyles.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Información personal
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Información Personal', style: AppTextStyles.h4),
                  const SizedBox(height: 16),
                  
                  _InfoTile(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: user.phone ?? 'No especificado',
                  ),
                  const SizedBox(height: 12),
                  _InfoTile(
                    icon: Icons.calendar_today,
                    label: 'Miembro desde',
                    value: '${user.createdAt.day}/${user.createdAt.month}/${user.createdAt.year}',
                  ),
                  const SizedBox(height: 24),
                  
                  // Habilidades
                  Text('Habilidades', style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  if (user.skills != null && user.skills!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: user.skills!.map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.neonGreen.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.neonGreen),
                          ),
                          child: Text(
                            skill,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.neonGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Text(
                      'No has agregado habilidades',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 24),
                  
                  // Intereses
                  Text('Intereses', style: AppTextStyles.h4),
                  const SizedBox(height: 12),
                  if (user.interests != null && user.interests!.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: user.interests!.map((interest) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            interest,
                            style: AppTextStyles.bodySmall,
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Text(
                      'No has agregado intereses',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  const SizedBox(height: 32),
                  
                  // Botones de acción
                  CustomButton(
                    text: 'EDITAR PERFIL',
                    onPressed: () {
                      // TODO: Editar perfil
                    },
                    icon: Icons.edit,
                  ),
                  const SizedBox(height: 12),
                  CustomButton(
                    text: 'COMPARTIR PERFIL',
                    onPressed: () {
                      // TODO: Compartir perfil
                    },
                    icon: Icons.share,
                    isOutlined: true,
                  ),
                  const SizedBox(height: 24),
                  
                  // Cerrar sesión
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/user-type-selection',
                          (route) => false,
                        );
                      },
                      child: Text(
                        'Cerrar Sesión',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.error,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
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
          Icon(icon, color: AppColors.neonGreen, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.bodySmall),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
