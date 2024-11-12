enum TaskTodoEnum {
  today,
  tomorrow,
  week,
  month,
}

extension TasksFilterDescription on TaskTodoEnum{

  String get description {
    switch (this) {
      case TaskTodoEnum.today:
        return "DE HOJE";
      case TaskTodoEnum.tomorrow:
        return "DE AMANHÃ";
      case TaskTodoEnum.week:
        return "DA SEMANA";
      case TaskTodoEnum.month:
        return "DO MÊS";
    }
  }
}