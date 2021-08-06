class Utils {
  static String getUserName(String email) {
    return 'live:${email.split('@')[0]}';
  }

  static String getInitials(String name) {
    final List<String> nameSplit = name.split(' ');
    final String firstNameInitial = nameSplit[0][0];
    final String lastNameInitial = nameSplit[1][0];
    return firstNameInitial + lastNameInitial;
  }
}
