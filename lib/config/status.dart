class Status {
  static const queue = 'Queue';
  static const washing = 'Washing';
  static const drying = 'Drying';
  static const beingFolded = 'Being Folded';
  static const done = 'Done';
  static const taken = 'Taken';
  static List listToday = [queue, 'Process', done];

  static List listMenu = [
    queue,
    washing,
    drying,
    beingFolded,
    done,
    taken,
  ];
}
