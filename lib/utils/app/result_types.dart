enum ResultTypes {
  singles(jpName: 'シングルス', enName: 'Singles'),
  doubles(jpName: 'ダブルス', enName: 'Doubles');

  const ResultTypes({
    required this.jpName,
    required this.enName,
  });

  final String jpName;
  final String enName;
}
