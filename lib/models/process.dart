class Process {
  static const queued = 'Queued';
  static const washing = 'Washing';
  static const drying = 'Drying';
  static const beingFolded = 'Being Folded';
  static const done = 'Done';
  static const taken = 'Taken';

  static List listToday = ['Queued', 'Processing', 'Done'];

  static List listMenu = [
    queued,
    washing,
    drying,
    beingFolded,
    done,
    taken,
  ];
}
