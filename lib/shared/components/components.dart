import 'package:flutter/material.dart';
import '../../layouts/TodoApp/cubit/TodoCubit.dart';


Widget defaultButton({
  double width= double.infinity,
  Color background= Colors.blue,
  bool isUpperCase = true,
  required Function() function,
  //required void Function()? function,

  required String text,}) => Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

      ),
    );
//----------------------------------------------------------------------------
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  Function(String)? onSubmit,
  Function()? ontap,
  Function(String)? onchange,
  //required Function() validate,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) => TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  validator: validate,
  onChanged: onchange,
  onTap : ontap,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,//color: Colors.blue,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,color: Colors.blue,
      ),
    ) : null,
    border: const OutlineInputBorder(),
  ),
);
//-------------------------------------------------------------------------------

Widget buildTaskItem(Map model,context,String screenTitle) =>  Dismissible(
  key: Key(model['id'].toString()),
  child: Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text('${model['time']}',style: const TextStyle(color: Colors.white),),
          backgroundColor: Colors.blue,
        ),
        const SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${model['title']}",style: const TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold,),maxLines: 1,),
              Text("${model['date']}",style: const TextStyle(color: Colors.black),),
            ],
          ),
        ),
        const SizedBox(width: 20.0,),
        if(screenTitle != 'Done Tasks')
          IconButton(
          onPressed: (){
            AppCubit.get(context).UpdateDatabase(status: 'done', id: model['id']);
            //emit(AppDoneTasksState);
          },
          icon: const Icon(Icons.check_box,),color: Colors.blue,),
        if(screenTitle != 'Archived Tasks')
          IconButton(
            onPressed: (){
              AppCubit.get(context).UpdateDatabase(status: 'archive', id: model['id']);
            }, icon: const Icon(Icons.archive),color: Colors.blue),
      ],
    ),
  ),
  onDismissed: (direction){// bydiny al direction ely 3ml dismiss fih
    AppCubit.get(context).DeleteDatabase(id: model['id']);
    },
);
//-------------------------------------------------------------------------------
