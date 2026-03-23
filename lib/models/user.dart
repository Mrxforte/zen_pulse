class User {
  final bool isSubscribed;
  final String? selectedMood;

  const User({this.isSubscribed = false, this.selectedMood});

  User copyWith({bool? isSubscribed, String? selectedMood}) => User(
    isSubscribed: isSubscribed ?? this.isSubscribed,
    selectedMood: selectedMood ?? this.selectedMood,
  );
}
