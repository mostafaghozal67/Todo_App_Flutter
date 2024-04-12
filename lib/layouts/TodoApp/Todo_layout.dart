import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/components/components.dart';
import 'cubit/TodoCubit.dart';
import 'cubit/TodoStates.dart';

class home_layout extends StatelessWidget
{
  var scaffoldkey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (BuildContext context , AppStates states){},
        builder:  (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldkey,
            appBar:AppBar(
              backgroundColor: Colors.blue,
              title: Center(child: Text(cubit.titles[cubit.current_index],style: const TextStyle(color: Colors.white),)),
            ),
            body: cubit.newTasks.length ==0 ? const Center(child: CircularProgressIndicator()) :cubit.screens[cubit.current_index],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.fabicon,color: Colors.white,),
              backgroundColor: Colors.blue,
              onPressed: () {
                if(cubit.isBottomSheetShown){
                  if(formKey.currentState!.validate()){
                    cubit.insertToDatabase(
                      title: titleController.text ,
                      date: dateController.text,
                      time: timeController.text,
                    ).then((value) {
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                      Navigator.pop(context); // to close the bottom sheet after adding the task
                      // cubit.GetFromDatabase(cubit.database).then((value) {
                      //   Navigator.pop(context);
                      //   cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                      // });
                    });
                  }
                }
                else{
                  scaffoldkey.currentState?.showBottomSheet((context) =>
                      SingleChildScrollView(
                        child: Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //Title Filed
                                defaultFormField(
                                    controller: titleController, type: TextInputType.text, label: 'Task Title', prefix: Icons.title,
                                    validate: (value){
                                      if(value == null || value.isEmpty){
                                        return 'Title must not be empty';
                                      }
                                      return null;
                                    }
                                ),
                                const SizedBox(height: 15.0),
                                //Time Field
                                defaultFormField(
                                    controller: timeController,
                                    type: TextInputType.datetime,
                                    label: 'Task Time',
                                    prefix: Icons.watch_later_outlined,
                                    ontap: (){
                                      showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now()).then((value) {
                                        timeController.text= value!.format(context).toString();
                                        //print(value?.format(context));
                                      });
                                    },
                                    onSubmit: (String value){
                                      //print("value");
                                    },
                                    validate: (value){
                                      if(value == null || value.isEmpty){
                                        return 'Time must not be empty';
                                      }
                                      return null;
                                    }
                                ),
                                //Date Field
                                const SizedBox(height: 15.0,),
                                defaultFormField(
                                    controller: dateController, type: TextInputType.datetime, label: 'Task Date ', prefix: Icons.calendar_today,
                                    ontap: (){
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.parse("2029-03-05"),
                                      ).then((value) {
                                        dateController.text= DateFormat.yMMMd().format(value!);
                                      });

                                    },
                                    onSubmit: (String value){
                                      //print("value");
                                    },
                                    validate: (value){
                                      if(value == null || value.isEmpty){
                                        return 'Date must not be empty';
                                      }
                                      return null;
                                    }
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },

            ),
            bottomNavigationBar: BottomNavigationBar(
              //type:BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).current_index,
              selectedItemColor: Colors.blue,
              onTap: (currentIndex){
                cubit.chagneIndex(currentIndex);


              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: "Tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check),
                  label: "Done",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: "Archived",
                ),
              ],

            ),
          );
        },
      ),
    );
  }
}




