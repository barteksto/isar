import 'package:isar/isar.dart';

part 'log_entity.g.dart';

@Collection(accessor: 'logs')
class LogEntity {
  const LogEntity({
    required this.message,
  });

  final Id id = Isar.autoIncrement;

  final String message;
}
