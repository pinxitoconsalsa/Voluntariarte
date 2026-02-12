import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voluntariarte/core/theme/app_colors.dart';
import 'package:voluntariarte/core/theme/app_text_styles.dart';
import 'package:voluntariarte/features/shared/widgets/custom_button.dart';
import 'package:voluntariarte/models/event_model.dart';

class EventDetailScreen extends StatefulWidget {
  final EventModel event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool _isRegistered = false;
  bool _isLoading = false;

  Future<void> _handleRegistration() async {
    setState(() => _isLoading = true);
    
    // Simular registro
    await Future.delayed(const Duration(seconds: 1));
    
    setState(() {
      _isRegistered = !_isRegistered;
      _isLoading = false;
    });
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _isRegistered 
                ? '¡Te has inscrito exitosamente!' 
                : 'Has cancelado tu inscripción',
          ),
          backgroundColor: _isRegistered ? AppColors.success : AppColors.warning,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('EEEE, dd MMMM yyyy', 'es_ES');
    final timeFormat = DateFormat('HH:mm');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              // TODO: Implementar compartir
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_outline),
            onPressed: () {
              // TODO: Implementar guardar
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen del evento (placeholder)
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.neonGreen.withOpacity(0.3),
                          AppColors.cardBackground,
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 64,
                        color: AppColors.textSecondary.withOpacity(0.5),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Categoría y estado
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.neonGreen.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.neonGreen, width: 1),
                              ),
                              child: Text(
                                widget.event.category.toUpperCase(),
                                style: AppTextStyles.label.copyWith(
                                  color: AppColors.neonGreen,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              widget.event.isFull ? Icons.lock : Icons.check_circle,
                              size: 20,
                              color: widget.event.isFull ? AppColors.error : AppColors.success,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.event.isFull 
                                  ? 'Completo' 
                                  : '${widget.event.availableSpots} plazas disponibles',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: widget.event.isFull ? AppColors.error : AppColors.success,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Título
                        Text(widget.event.title, style: AppTextStyles.h2),
                        const SizedBox(height: 8),
                        
                        // Organización
                        Row(
                          children: [
                            const Icon(Icons.business, size: 20, color: AppColors.neonGreen),
                            const SizedBox(width: 8),
                            Text(
                              widget.event.organizationName,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Información clave
                        _InfoRow(
                          icon: Icons.calendar_today,
                          label: 'Fecha',
                          value: dateFormat.format(widget.event.date),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.access_time,
                          label: 'Hora',
                          value: timeFormat.format(widget.event.date),
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.location_on,
                          label: 'Ubicación',
                          value: widget.event.location,
                        ),
                        const SizedBox(height: 12),
                        _InfoRow(
                          icon: Icons.schedule,
                          label: 'Duración estimada',
                          value: '${widget.event.estimatedHours} horas',
                        ),
                        const SizedBox(height: 24),
                        
                        // Descripción
                        Text('Descripción', style: AppTextStyles.h4),
                        const SizedBox(height: 8),
                        Text(
                          widget.event.description,
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Habilidades requeridas
                        if (widget.event.requiredSkills.isNotEmpty) ...[
                          Text('Habilidades requeridas', style: AppTextStyles.h4),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: widget.event.requiredSkills.map((skill) {
                              return Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  skill,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 24),
                        ],
                        
                        // Participantes
                        Text('Participantes', style: AppTextStyles.h4),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: widget.event.currentVolunteers / widget.event.maxVolunteers,
                          backgroundColor: AppColors.border,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.neonGreen),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${widget.event.currentVolunteers} de ${widget.event.maxVolunteers} voluntarios inscritos',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Botón de acción
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: SafeArea(
              top: false,
              child: CustomButton(
                text: _isRegistered ? 'CANCELAR INSCRIPCIÓN' : '¡ME APUNTO!',
                onPressed: widget.event.isFull && !_isRegistered ? () {} : _handleRegistration,
                isLoading: _isLoading,
                backgroundColor: _isRegistered ? AppColors.error : AppColors.neonGreen,
                isOutlined: _isRegistered,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.neonGreen),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.bodySmall),
              const SizedBox(height: 2),
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
    );
  }
}
