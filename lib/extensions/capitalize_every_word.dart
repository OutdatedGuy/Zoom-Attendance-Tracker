extension StringExtension on String {
  String capitalizeEveryWord() {
    if (isEmpty) {
      return this;
    }

    List<String> words = split(" ");
    words = words.map((word) {
      if (word.isNotEmpty) {
        return "${word[0].toUpperCase()}${word.substring(1)}";
      } else {
        return "";
      }
    }).toList();

    return words.join(" ");
  }
}
