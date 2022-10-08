class Process {
  static const queue = 'Queue';
  static const wash = 'Wash';
  static const dry = 'Dry';
  static const fold = 'Fold';
  static const done = 'Done';
  static const delivered = 'Delivered';

  static List listToday = ['Queued', 'Processing', 'Done'];

  static List listMenu = [
    queue,
    wash,
    dry,
    fold,
    done,
    delivered,
  ];
}
