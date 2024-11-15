import 'package:todo_list_project/app/core/notifier/defaultNotifier.dart';
import 'package:todo_list_project/app/models/monthTask.dart';
import 'package:todo_list_project/app/models/task.dart';
import 'package:todo_list_project/app/models/taskTodoEnum.dart';
import 'package:todo_list_project/app/models/totalTask.dart';
import 'package:todo_list_project/app/models/weekTask.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';

class HomeController extends DefaultNotifier {

  final TasksService _tasksService;
  var filterSelected = TaskTodoEnum.today;
  TotalTask? todayTotalTask;
  TotalTask? tomorrowTotalTask;
  TotalTask? weekTotalTask;
  TotalTask? monthTotalTask;
  List<TaskModel> allTasks =  [];
  List<TaskModel> filteredtasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectedDay;
  bool showFinishingTasks = false;

  HomeController({required TasksService tasksService}) : _tasksService = tasksService;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
      _tasksService.getMonth()
    ]);

    final todayTask = allTasks[0] as List<TaskModel>;
    final tomorrowTask = allTasks[1] as List<TaskModel>;
    final weekTask = allTasks[2] as WeekTask;
    final monthTask = allTasks[3] as MonthTask;


    todayTotalTask = TotalTask(
      tasks: todayTask.length,
      tasksFinished: todayTask.where((task)=> task.isFinished).length,
    );

    tomorrowTotalTask = TotalTask(
      tasks: tomorrowTask.length,
      tasksFinished: tomorrowTask.where((task)=> task.isFinished).length,
    );

    weekTotalTask = TotalTask(
      tasks: weekTask.tasks.length,
      tasksFinished: weekTask.tasks.where((task)=> task.isFinished).length,
    );

    monthTotalTask = TotalTask(
      tasks: monthTask.tasks.length,
      tasksFinished: monthTask.tasks.where((task)=> task.isFinished).length,
    );
    notifyListeners();
  }

  Future<void> findTasks({required TaskTodoEnum filter}) async {
    filterSelected = filter;
    showLoading();
    notifyListeners();

    List<TaskModel> tasks;

    switch (filter) {
      case TaskTodoEnum.today:
        tasks = await _tasksService.getToday();
        break;
      case TaskTodoEnum.tomorrow:
        tasks = await _tasksService.getTomorrow();
        break;
      case TaskTodoEnum.week:
        final weekModel = await _tasksService.getWeek();
        initialDateOfWeek = weekModel.start;
        tasks = weekModel.tasks;
      case TaskTodoEnum.month:
        final monthModel = await _tasksService.getMonth();
        tasks = monthModel.tasks;
      
      }

    filteredtasks = tasks;
    allTasks = tasks;

    if(filter == TaskTodoEnum.week){
      if(selectedDay != null){
        filterByDay(selectedDay!);
      }else if(initialDateOfWeek != null){
        filterByDay(initialDateOfWeek!);
      }
    }else{
      selectedDay = null;
    }

    if(!showFinishingTasks){
      filteredtasks = filteredtasks.where((task) => !task.isFinished).toList();
    }



    hideLoading();
    notifyListeners();
  }

  void filterByDay(DateTime date){
    selectedDay = date;
    filteredtasks = allTasks.where((task)=> task.dateTime == date).toList();
    notifyListeners();
    
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();

    notifyListeners();
    
  }
  
    Future<void> checkOrUncheckTask(TaskModel task) async {
      showLoadingAndResetState();
      notifyListeners();

      final taskUpdate = task.copyWith(isFinished: !task.isFinished);
      await _tasksService.checkOrUncheckTask(taskUpdate);

      hideLoading();
      refreshPage();
    }

  void showOrHideFinishingTasks(){
    showFinishingTasks =!showFinishingTasks;
    refreshPage();
  }

  Future<void> deleteTask(int id) async {
    await _tasksService.removeById(id);
    refreshPage();
  }


}