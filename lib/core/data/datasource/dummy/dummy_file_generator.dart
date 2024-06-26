import 'dart:math';
import 'package:architecture_ptc/src/features/core/data/models/file_model.dart';
import 'package:faker/src/faker.dart';
import 'dummy_data_generator.dart';

class DummyFileGenerator with DummyDataGenerator<FileModel> {
  @override
  generateDummyData() {
    return FileModel(
      id: faker.randomGenerator.integer(1000),
      name: faker.lorem.word() + '.pdf',
      path: faker.internet.httpUrl(),
      size: faker.randomGenerator.integer(10000, min: 500),
      type: faker.lorem.word(),
      sub_type: faker.lorem.word(),
    );
  }
}
