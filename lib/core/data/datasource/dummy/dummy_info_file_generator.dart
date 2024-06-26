import 'package:faker/src/faker.dart';
import '../../models/info_file_model.dart';
import 'dummy_data_generator.dart';

class DummyInfoFileGenerator with DummyDataGenerator<InfoFile> {
  @override
  generateDummyData() {
    return InfoFile(
      path: faker.randomGenerator.string(20),
      name: faker.randomGenerator.string(20),
      size: faker.randomGenerator.integer(500).toString(),
      key: faker.guid.guid(),
      progress: faker.randomGenerator.integer(100).toString(),
      complete: faker.randomGenerator.boolean(),
      run: faker.randomGenerator.boolean(),
    );
  }
}
