import 'dart:io';

import 'package:curai_app_mobile/core/api/end_points.dart';
import 'package:curai_app_mobile/core/dependency_injection/service_locator.dart';
import 'package:curai_app_mobile/features/user/data/models/doctor/doctor_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// 🟢 States
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  DoctorLoaded(this.doctors, this.hasMore);
  final List<DoctorModel> doctors;
  final bool hasMore;
}

class DoctorError extends DoctorState {
  DoctorError(this.message);
  final String message;
}

// 🟢 Cubit
class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit(this.repository) : super(DoctorInitial());
  final DoctorRepository repository;

  int currentPage = 1;
  bool hasMore = true;
  List<DoctorModel> doctors = [];

  Future<void> fetchDoctors({String search = '', bool loadMore = false}) async {
    if (state is DoctorLoading || (!loadMore && hasMore == false)) return;

    if (!loadMore) {
      currentPage = 1;
      hasMore = true;
      doctors.clear();
      emit(DoctorLoading());
    }

    try {
      final newDoctors =
          await repository.getDoctors(page: currentPage, search: search);

      if (newDoctors.isEmpty) {
        hasMore = false;
      }

      doctors.addAll(newDoctors);
      currentPage++;

      emit(DoctorLoaded(doctors, hasMore));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}

// 🟢 Repository
class DoctorRepository {
  Future<List<DoctorModel>> getDoctors({
    int page = 1,
    String search = '',
  }) async {
    try {
      final response = await sl<DioHelper>().getData(
        url: EndPoints.getAllDoctor,
        query: {'page': page, 'search': search},
      );

      if (response.data == null || response.data['results'] == null) {
        return [];
      }

      return (response.data['results'] as List)
          .map((json) => DoctorModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching doctors: $e');
    }
  }
}

// 🟢 Dio Helper
class DioHelper {
  DioHelper() {
    _configureDio();
  }
  final Dio client = Dio();

  void _configureDio() {
    (client.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      return httpClient;
    };

    client.options
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.json
      ..followRedirects = false
      ..validateStatus = (status) => status != null && status < 500;
  }

  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return client.get(url, queryParameters: query);
  }
}

// 🟢 UI Screen
class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<DoctorCubit>().fetchDoctors();
  }

  void _onScroll() {
    final cubit = context.read<DoctorCubit>();
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        cubit.state is DoctorLoaded &&
        (cubit.state as DoctorLoaded).hasMore) {
      cubit.fetchDoctors(loadMore: true);
    }
  }

  void _onSearch() {
    context.read<DoctorCubit>().fetchDoctors(search: _searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Doctors')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctor...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<DoctorCubit, DoctorState>(
              builder: (context, state) {
                if (state is DoctorLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DoctorError) {
                  return Center(child: Text(state.message));
                }

                final doctors = (state as DoctorLoaded).doctors;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: doctors.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(doctors[index].username ?? ''),
                    subtitle: Text(doctors[index].email ?? ''),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
