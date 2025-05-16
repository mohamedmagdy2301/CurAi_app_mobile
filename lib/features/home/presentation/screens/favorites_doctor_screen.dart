import 'package:curai_app_mobile/features/home/presentation/cubit/favorites_cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesCubit>().state;

    return Scaffold(
      appBar: AppBar(title: const Text('المفضلة')),
      body: favorites.isEmpty
          ? const Center(child: Text('لا يوجد أطباء مفضلين'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final doctor = favorites[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(doctor.profilePicture ?? ''),
                  ),
                  title: Text(doctor.username ?? ''),
                  subtitle: Text(doctor.specialization ?? ''),
                );
              },
            ),
    );
  }
}
