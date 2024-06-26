import 'dart:math';

import 'package:architecture_ptc/src/features/mail_box/data/models/request_box_model.dart';
import 'package:faker/src/faker.dart';
import '../../../../../../core/data/datasource/dummy/dummy_data_generator.dart';
import '../../../../../../core/data/datasource/dummy/dummy_file_generator.dart';
import '../../../../../../core/data/datasource/dummy/dummy_info_file_generator.dart';
import '../../../../../../core/data/datasource/dummy/dummy_user_generator.dart';
import 'dummy_replay_box_generator.dart';

class DummyRequestBoxGenerator with DummyDataGenerator<RequestBox> {
  @override
  generateDummyData() {
    return RequestBox(
      id: faker.randomGenerator.integer(1000),
      title: faker.lorem.sentence(),
      subTitle: faker.lorem.sentence(),
      showDate: faker.date.dateTime(),
      sendId: faker.randomGenerator.integer(100),
      recivedId: faker.randomGenerator.integer(100),
      requestTypeId: faker.randomGenerator.integer(10),
      requestType: faker.lorem.word(),
      sendUser: DummyUserGenerator().generateDummyData(),
      recivedUser: DummyUserGenerator().generateDummyData(),
      countReplayBoxes: faker.randomGenerator.integer(10),
      countFilse: faker.randomGenerator.integer(10),
      files: List.generate(
        faker.randomGenerator.integer(5, min: 1),
        (index) => DummyFileGenerator().generateDummyData()!,
      ),
      replayBoxes: List.generate(
        faker.randomGenerator.integer(5, min: 1),
        (index) => DummyReplyBoxGenerator().generateDummyData()!,
      ),
    );
  }
}
