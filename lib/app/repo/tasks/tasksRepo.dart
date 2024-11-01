abstract interface class TasksRepo {

  Future<void> save(DateTime date, String description);

}