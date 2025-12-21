import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_event.dart';
import '../providers/auth_provider.dart';
import '../providers/event_provider.dart';
import '../providers/preferences_provider.dart';
import '../routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/auth_required.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = context.watch<AuthProvider>();
    final prefs = context.watch<PreferencesProvider>();
    final eventProvider = context.watch<EventProvider>();
    final currentIndex = prefs.loaded ? prefs.lastTabIndex : 0;

    if (!auth.isLoggedIn) {
      return const AuthRequired();
    }

    Future<void> openEventForm({AppEvent? existing}) async {
      final titleCtrl = TextEditingController(text: existing?.title ?? '');
      final descCtrl =
          TextEditingController(text: existing?.description ?? '');
      final dateCtrl = TextEditingController(text: existing?.date ?? '');
      final imageCtrl =
          TextEditingController(text: existing?.imageUrl ?? '');

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),
        builder: (ctx) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
              top: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  existing == null ? 'Add Event' : 'Edit Event',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: titleCtrl,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: dateCtrl,
                  decoration:
                      const InputDecoration(labelText: 'Date (e.g. 24.01.2026)'),
                ),
                TextField(
                  controller: imageCtrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (titleCtrl.text.isEmpty || dateCtrl.text.isEmpty) {
                        return;
                      }
                      try {
                        if (existing == null) {
                          await eventProvider.addEvent(
                            title: titleCtrl.text.trim(),
                            description: descCtrl.text.trim(),
                            date: dateCtrl.text.trim(),
                            imageUrl: imageCtrl.text.trim(),
                          );
                        } else {
                          await eventProvider.updateEvent(
                            existing.copyWith(
                              title: titleCtrl.text.trim(),
                              description: descCtrl.text.trim(),
                              date: dateCtrl.text.trim(),
                              imageUrl: imageCtrl.text.trim(),
                            ),
                          );
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                      } catch (e) {
                        if (ctx.mounted) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                            SnackBar(content: Text('Failed: $e')),
                          );
                        }
                      }
                    },
                    child: Text(existing == null ? 'Create' : 'Update'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        onPressed: () => openEventForm(),
        child: const Icon(Icons.add),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Events',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 48,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.98),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: const BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.blue.shade200,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        SizedBox(width: 4),
                        Text(
                          'Geri',
                          style: AppTextStyles.bodyWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (eventProvider.loading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }

                      if (eventProvider.error != null) {
                        return Center(
                          child: Text(
                            eventProvider.error!,
                            style: AppTextStyles.bodyWhite,
                          ),
                        );
                      }

                      if (eventProvider.events.isEmpty) {
                        return const Center(
                          child: Text(
                            'No events yet. Add your first one!',
                            style: AppTextStyles.bodyWhite,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: eventProvider.events.length,
                        itemBuilder: (context, index) {
                          final event = eventProvider.events[index];
                          return _EventCard(
                            event: event,
                            onEdit: () => openEventForm(existing: event),
                            onDelete: () =>
                                eventProvider.deleteEvent(event.id),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          prefs.setLastTab(index);
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, AppRoutes.categories);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, AppRoutes.home);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, AppRoutes.profile);
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final AppEvent event;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _EventCard({
    required this.event,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 110,
            height: 110,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: event.imageUrl.isNotEmpty
                ? Image.network(event.imageUrl, fit: BoxFit.cover)
                : Container(color: Colors.blue.shade100),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.date,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRoutes.eventDetail,
                          arguments: event,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit, color: Colors.black54),
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
