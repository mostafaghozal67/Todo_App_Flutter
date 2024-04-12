import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layouts/TodoApp/cubit/TodoCubit.dart';
import '../../layouts/TodoApp/cubit/TodoStates.dart';
import '../../shared/components/components.dart';


class done_tasks_screen extends StatelessWidget {
  const done_tasks_screen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, States) {},
      builder: (context, States) {
        var tasks = AppCubit.get(context).doneTasks;
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index], context,"Done Tasks"),
            separatorBuilder: (context, index) =>
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[300],

                ),
            itemCount: tasks.length);
      },

    );
  }
}
