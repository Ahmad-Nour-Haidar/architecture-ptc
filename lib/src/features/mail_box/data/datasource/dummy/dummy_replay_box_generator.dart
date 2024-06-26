import 'package:architecture_ptc/src/features/mail_box/data/models/replay_box_model.dart';
import 'package:faker/src/faker.dart';
import '../../../../../../core/data/datasource/dummy/dummy_data_generator.dart';
import '../../../../../../core/data/datasource/dummy/dummy_file_generator.dart';
import '../../../../../../core/data/datasource/dummy/dummy_user_generator.dart';

class DummyReplyBoxGenerator with DummyDataGenerator<ReplayBox> {
  @override
  generateDummyData() {
    return ReplayBox(
      id: faker.randomGenerator.integer(1000),
      title: faker.lorem.sentence(),
      subTitle: faker.lorem.sentence(),
      showDate: faker.date.dateTime(),
      sendId: faker.randomGenerator.integer(100),
      recivedId: faker.randomGenerator.integer(100),
      sendUser: DummyUserGenerator().generateDummyData(),
      recivedUser: DummyUserGenerator().generateDummyData(),
      countFilse: faker.randomGenerator.integer(10),
      files: List.generate(
        faker.randomGenerator.integer(5, min: 1),
        (index) => DummyFileGenerator().generateDummyData()!,
      ),
    );
  }
}
