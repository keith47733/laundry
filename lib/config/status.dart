class Status {
  static const queue = 'Queue';
  static const washing = 'Washing';
  static const beingDry = 'Being Dry';
  static const beingPrepared = 'Being Prepared';
  static const done = 'Done';
  static const taken = 'Taken';
  static List listToday = [
		{'status': queue, 'count': '0'},
		{'status': 'Process', 'count': '0'},
		{'status': done, 'count': '0'},
	];

  static List listMenu = [
    queue,
    washing,
    beingDry,
    beingPrepared,
    done,
    taken,
  ];
}
