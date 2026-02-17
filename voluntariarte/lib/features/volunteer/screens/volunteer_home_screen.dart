import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:voluntariarte/core/theme/app_colors.dart';
import 'package:voluntariarte/core/theme/app_text_styles.dart';
import 'package:voluntariarte/features/shared/widgets/bottom_nav_bar.dart';
import 'package:voluntariarte/features/shared/widgets/event_card.dart';
import 'package:voluntariarte/services/mock_data_service.dart';
import 'package:voluntariarte/models/event_model.dart';

class VolunteerHomeScreen extends StatefulWidget {
  const VolunteerHomeScreen({super.key});

  @override
  State<VolunteerHomeScreen> createState() => _VolunteerHomeScreenState();
}

class _VolunteerHomeScreenState extends State<VolunteerHomeScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'Todos';
  String _sortBy = 'Fecha';

  final List<String> _categories = [
    'Todos',
    'Medio Ambiente',
    'Social',
    'Educación',
    'Comunidad',
  ];

  final List<String> _sortOptions = ['Fecha', 'Distancia'];

  List<EventModel> get _filteredEvents {
    var events = MockDataService.mockEvents;
    
    if (_selectedCategory != 'Todos') {
      events = events.where((e) => e.category == _selectedCategory).toList();
    }
    
    // Aquí se podría ordenar por distancia si tuviéramos la ubicación del usuario
    if (_sortBy == 'Fecha') {
      events.sort((a, b) => a.date.compareTo(b.date));
    }
    
    return events;
  }

  void _onNavBarTap(int index) {
    setState(() => _currentIndex = index);
    
    switch (index) {
      case 0:
        // Ya estamos en home
        break;
      case 1:
        Navigator.pushNamed(context, '/impact-dashboard');
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('VoluntariArte'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implementar notificaciones
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Encuentra tu próxima aventura',
                  style: AppTextStyles.h3,
                ),
                const SizedBox(height: 16),
                
                // Categorías
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = category == _selectedCategory;
                      
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() => _selectedCategory = category);
                          },
                          backgroundColor: AppColors.cardBackground,
                          selectedColor: AppColors.neonGreen.withOpacity(0.3),
                          labelStyle: AppTextStyles.bodySmall.copyWith(
                            color: isSelected ? AppColors.neonGreen : AppColors.textSecondary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          side: BorderSide(
                            color: isSelected ? AppColors.neonGreen : AppColors.border,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                
                // Ordenar por
                Row(
                  children: [
                    const Icon(Icons.sort, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 8),
                    Text('Ordenar por:', style: AppTextStyles.bodySmall),
                    const SizedBox(width: 8),
                    DropdownButton<String>(
                      value: _sortBy,
                      items: _sortOptions.map((option) {
                        return DropdownMenuItem(
                          value: option,
                          child: Text(option, style: AppTextStyles.bodySmall),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => _sortBy = value);
                        }
                      },
                      underline: const SizedBox(),
                      dropdownColor: AppColors.cardBackground,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.neonGreen),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(height: 1),
          
          // Lista de eventos
          Expanded(
            child: _filteredEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textSecondary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No hay eventos disponibles',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = _filteredEvents[index];
                      // Simular distancia aleatoria
                      final distance = 2.5 + (index * 1.3);
                      
                      return EventCard(
                        event: event,
                        distance: distance,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/event-detail',
                            arguments: event,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
