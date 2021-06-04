import 'package:vudu_mojo_app/helpers/resultType.dart';

class MojoResult {
  final String? message;
  final ResultType resultType;
  final String? body;

  MojoResult({required this.resultType, this.message, this.body});
}
