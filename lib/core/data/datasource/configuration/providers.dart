class BlocProviderSingleton {
  static final BlocProviderSingleton _instance =
      BlocProviderSingleton._internal();
  static BlocProviderSingleton get instance => _instance;

  factory BlocProviderSingleton() {
    return _instance;
  }

  BlocProviderSingleton._internal();
}
