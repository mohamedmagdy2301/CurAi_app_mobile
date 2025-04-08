// ignore_for_file: one_member_abstracts, document_ignores

import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<String, Map<String, dynamic>>> getAllDoctor({
    int page,
    String? query,
  });
}
