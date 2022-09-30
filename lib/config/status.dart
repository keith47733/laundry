class Status {
  static const queue = 'Queue';
  static const washing = 'Washing';
  static const beingDry = 'Being Dry';
  static const beingPrepared = 'Being Prepared';
  static const done = 'Done';
  static const taken = 'Taken';
  static List listToday = [queue, 'Process', done];

  static List listMenu = [
    queue,
    washing,
    beingDry,
    beingPrepared,
    done,
    taken,
  ];
}
