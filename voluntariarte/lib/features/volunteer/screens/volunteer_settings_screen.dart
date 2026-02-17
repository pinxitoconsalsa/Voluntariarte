import 'package:flutter/material.dart';
import 'package:voluntariarte/core/theme/app_colors.dart';
import 'package:voluntariarte/core/theme/app_text_styles.dart';
import 'package:voluntariarte/features/shared/widgets/bottom_nav_bar.dart';

class VolunteerSettingsScreen extends StatefulWidget {
  const VolunteerSettingsScreen({super.key});

  @override
  State<VolunteerSettingsScreen> createState() => _VolunteerSettingsScreenState();
}

class _VolunteerSettingsScreenState extends State<VolunteerSettingsScreen> {
  int _currentIndex = 3;
  
  bool _notificationsEnabled = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;
  String _theme = 'Oscuro';
  String _language = 'Español';

  void _onNavBarTap(int index) {
    setState(() => _currentIndex = index);
    
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/volunteer-home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/impact-dashboard');
        break;
      case 2:
        Navigator.pushNamed(context, '/volunteer-profile');
        break;
      case 3:
        // Ya estamos aquí
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
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
            // Perfil
            _SectionHeader(title: 'Perfil'),
            const SizedBox(height: 12),
            _SettingsListTile(
              icon: Icons.person_outline,
              title: 'Editar Perfil',
              subtitle: 'Actualiza tu información personal',
              onTap: () {
                // TODO: Implementar edición de perfil
              },
            ),
            const SizedBox(height: 8),
            _SettingsListTile(
              icon: Icons.lock_outline,
              title: 'Cambiar Contraseña',
              subtitle: 'Actualiza tu contraseña de seguridad',
              onTap: () {
                // TODO: Implementar cambio de contraseña
              },
            ),
            const SizedBox(height: 32),

            // Notificaciones
            _SectionHeader(title: 'Notificaciones'),
            const SizedBox(height: 12),
            _SettingsSwitchTile(
              icon: Icons.notifications_outlined,
              title: 'Habilitar Notificaciones',
              subtitle: 'Recibe alertas sobre eventos y actividades',
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
            const SizedBox(height: 8),
            _SettingsSwitchTile(
              icon: Icons.mail_outline,
              title: 'Notificaciones por Email',
              subtitle: 'Recibe actualizaciones por correo electrónico',
              value: _emailNotifications,
              onChanged: (value) {
                setState(() => _emailNotifications = value);
              },
            ),
            const SizedBox(height: 8),
            _SettingsSwitchTile(
              icon: Icons.notifications_active_outlined,
              title: 'Notificaciones Push',
              subtitle: 'Recibe notificaciones en tiempo real',
              value: _pushNotifications,
              onChanged: (value) {
                setState(() => _pushNotifications = value);
              },
            ),
            const SizedBox(height: 32),

            // Preferencias
            _SectionHeader(title: 'Preferencias'),
            const SizedBox(height: 12),
            _SettingsDropdown(
              icon: Icons.language_outlined,
              title: 'Idioma',
              value: _language,
              options: ['Español', 'English', 'Català'],
              onChanged: (value) {
                setState(() => _language = value);
              },
            ),
            const SizedBox(height: 8),
            _SettingsDropdown(
              icon: Icons.palette_outlined,
              title: 'Tema',
              value: _theme,
              options: ['Claro', 'Oscuro', 'Automático'],
              onChanged: (value) {
                setState(() => _theme = value);
              },
            ),
            const SizedBox(height: 32),

            // Privacidad y Seguridad
            _SectionHeader(title: 'Privacidad y Seguridad'),
            const SizedBox(height: 12),
            _SettingsListTile(
              icon: Icons.privacy_tip_outlined,
              title: 'Política de Privacidad',
              subtitle: 'Lee nuestra política de privacidad',
              onTap: () {
                // TODO: Mostrar política de privacidad
              },
            ),
            const SizedBox(height: 8),
            _SettingsListTile(
              icon: Icons.description_outlined,
              title: 'Términos de Servicio',
              subtitle: 'Lee nuestros términos y condiciones',
              onTap: () {
                // TODO: Mostrar términos de servicio
              },
            ),
            const SizedBox(height: 32),

            // Información
            _SectionHeader(title: 'Información'),
            const SizedBox(height: 12),
            _SettingsListTile(
              icon: Icons.info_outline,
              title: 'Acerca de VoluntariArte',
              subtitle: 'Información sobre la aplicación',
              onTap: () {
                // TODO: Mostrar información de la app
              },
            ),
            const SizedBox(height: 8),
            _SettingsListTile(
              icon: Icons.help_outline,
              title: 'Centro de Ayuda',
              subtitle: 'Preguntas frecuentes y soporte',
              onTap: () {
                // TODO: Abrir centro de ayuda
              },
            ),
            const SizedBox(height: 32),

            // Peligro
            _SectionHeader(
              title: 'Peligro',
              color: AppColors.error,
            ),
            const SizedBox(height: 12),
            _SettingsListTile(
              icon: Icons.logout_outlined,
              title: 'Cerrar Sesión',
              subtitle: 'Salir de tu cuenta',
              textColor: AppColors.error,
              onTap: () {
                _showLogoutDialog();
              },
            ),
            const SizedBox(height: 8),
            _SettingsListTile(
              icon: Icons.delete_forever_outlined,
              title: 'Eliminar Cuenta',
              subtitle: 'Borrar tu cuenta permanentemente',
              textColor: AppColors.error,
              onTap: () {
                _showDeleteAccountDialog();
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text(
          '¿Estás seguro de que deseas cerrar sesión?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar logout
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Cerrar Sesión',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar Cuenta'),
        content: const Text(
          'Advertencia: Esta acción es irreversible. Se eliminarán todos tus datos. ¿Estás seguro?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implementar eliminación de cuenta
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Eliminar',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Color? color;

  const _SectionHeader({
    required this.title,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.h4.copyWith(
        color: color,
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? textColor;

  const _SettingsListTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: textColor ?? AppColors.neonGreen,
                  size: 24,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppColors.neonGreen,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.neonGreen,
              activeTrackColor: AppColors.neonGreen.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsDropdown extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final List<String> options;
  final Function(String) onChanged;

  const _SettingsDropdown({
    required this.icon,
    required this.title,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  State<_SettingsDropdown> createState() => _SettingsDropdownState();
}

class _SettingsDropdownState extends State<_SettingsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: AppColors.neonGreen,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            DropdownButton<String>(
              value: widget.value,
              items: widget.options.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(
                    option,
                    style: AppTextStyles.bodySmall,
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.onChanged(value);
                }
              },
              underline: const SizedBox(),
              dropdownColor: AppColors.cardBackground,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: AppColors.neonGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
