
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_project/app/core/notifier/defaultNotifier.dart';
import 'package:todo_list_project/app/core/ui/messages.dart';

class DefaultListener {
  final DefaultNotifier changeNotifier;

  DefaultListener({ required this.changeNotifier});



  void listener({
    EverVoidCallback? everCallback,
    ErrorVoidCallback? error,
    required SuccessVoidCallback succesCallback,
    required BuildContext context
  }){
    changeNotifier.addListener((){
      if(everCallback != null){
        everCallback(changeNotifier, this);
      }
      
      if(changeNotifier.loading){
        Loader.show(context);
      }else{
        Loader.hide();
      }

      if(changeNotifier.hasError){
        if(error!= null){
          error(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Internal error');
      }else if(changeNotifier.isSuccess){
        succesCallback(changeNotifier, this); 
      
      }


    });

  }

  void dispose(){
    changeNotifier.removeListener((){});
  }

}

typedef SuccessVoidCallback = void Function(
  DefaultNotifier notifier, DefaultListener listenerIntance
);
typedef ErrorVoidCallback = void Function(
  DefaultNotifier notifier, DefaultListener listenerIntance
);
typedef EverVoidCallback = void Function(
  DefaultNotifier notifier, DefaultListener listenerIntance
);