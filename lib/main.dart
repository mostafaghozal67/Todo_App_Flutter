import 'package:first_project/layouts/TodoApp/Todo_layout.dart';
import 'package:flutter/material.dart';




void main(){
  // Bloc.observer = MyBlocObserver();
  runApp(Myapp());

}
class Myapp extends StatelessWidget  
{
  

  @override
  Widget build(BuildContext context) { 
        return MaterialApp(  
          home: home_layout(),
          debugShowCheckedModeBanner: false,

        );
      }


}





