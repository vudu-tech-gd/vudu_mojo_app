import 'mojoResult.dart';

class MojoException implements Exception {
  final dynamic error;
  final MojoResult result;

  MojoException({required this.error, required this.result});
}
