
import 'package:todo_list_project/app/core/notifier/defaultNotifier.dart';
import 'package:todo_list_project/app/services/tasks/tasksService.dart';

class TaskController  extends DefaultNotifier{
  final TasksService _tasksService;
  DateTime? _selectedDate;

  TaskController({
    required TasksService tasksService
  }): _tasksService = tasksService;

  set selectedDate(DateTime? selectedDate){
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  DateTime? get selectedDate => _selectedDate;

  Future<void> save(String text) async {
    try {
      showLoadingAndResetState();
      notifyListeners();
      if(_selectedDate != null){
        await _tasksService.save(_selectedDate!,text);
        success(); 
      }else{
        setError('Data da tarefa não selecionada!');
      }
      
    } catch (e) {
      setError('Erro ao cadastrar tarefa');
    }finally{
      hideLoading();
      notifyListeners();
    }

  }

  
}