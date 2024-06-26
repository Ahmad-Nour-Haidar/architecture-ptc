import 'dart:math';

import 'package:architecture_ptc/src/features/core/data/models/user_model.dart';
import 'package:faker/src/faker.dart';
import 'dummy_data_generator.dart';

class DummyUserGenerator with DummyDataGenerator<UserModel> {
  @override
  generateDummyData() {
    return UserModel(
      id: Random().nextInt(1000),
      email: faker.internet.email(),
      firstName: faker.person.firstName(),
      lastName: faker.person.lastName(),
      password: faker.internet.password(),
      about: faker.lorem.sentence(),
    );
  }
}
