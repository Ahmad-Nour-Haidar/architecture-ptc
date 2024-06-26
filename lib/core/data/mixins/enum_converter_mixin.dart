

mixin EnumConverter {
  T? convertEnum<T>(String? value, List<T> enumValues,T? defaultNullValue, T? defaultValue) {
    if (value == null) return defaultNullValue??defaultValue;
    return enumValues.where(
          (e) => e.toString().split('.')[1].toLowerCase() == value.toLowerCase(),

    ).firstOrNull?? defaultValue;
  }
}