import 'package:first_project/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layouts/TodoApp/cubit/TodoCubit.dart';
import '../../layouts/TodoApp/cubit/TodoStates.dart';


class new_tasks_screen extends StatefulWidget {
  //const new_tasks_screen({super.key});
  @override
  new_tasks_screen_State createState() => new_tasks_screen_State();
}
class new_tasks_screen_State extends State<new_tasks_screen>
{

  @override
  Widget build(BuildContext context) {
    //return Container();
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, States){},
      builder: (context, States){
        var tasks= AppCubit.get(context).newTasks;
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index],context,"New Tasks"),
            separatorBuilder: (context,index) => Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
            itemCount: tasks.length);
      },

    );

  }


}
