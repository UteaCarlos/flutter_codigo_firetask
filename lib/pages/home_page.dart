import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasks/ui/general/colors.dart';
import 'package:tasks/ui/widgets/button_normal_widget.dart';
import 'package:tasks/ui/widgets/general_widget.dart';
import 'package:tasks/ui/widgets/item_task_widget.dart';
import 'package:tasks/ui/widgets/task_form_widget.dart';
import 'package:tasks/utils/task_search_delegate.dart';
import '../models/task_model.dart';
import '../ui/widgets/textfield_normal_widget.dart';

class HomePage extends StatelessWidget {
  List<TaskModel> tasksGeneral = [];

  CollectionReference tasksReference =
      FirebaseFirestore.instance.collection('tasks');
/*
  Stream<int> counter() async*{
    for(int i=0;i<10;i++){
      yield i;
      await Future.delayed(const Duration(seconds: 2));
    }
  }
  Future<int> getNumber() async{
    return 1000;
  }
  */
  final TextEditingController _searchController = TextEditingController();
  showTaskForm(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: TaskFormWidget(),
          );
          //fin container
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF4F6FF),
        floatingActionButton: InkWell(
          onTap: () {
            showTaskForm(context);
          },
          borderRadius: BorderRadius.circular(14.0),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: kBrandPrymaryColor),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Nueva tarea",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                ],
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 22.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    )
                  ],
                ),
                child: SafeArea(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenido",
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff2c3550),
                          ),
                        ),
                        divider6(),
                        Text(
                          "Mis tareas",
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff2c3550),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 12,
                                offset: const Offset(4, 4),
                              ),
                            ],
                          ),
                          child: TextFieldNormalWidget(
                            icon: Icons.search,
                            hintText: "Buscar tarea",
                            controller: _searchController,
                            onTap: () async {
                              await showSearch(
                                  context: context,
                                  delegate:
                                      TaskSearchDelegate(tasks: tasksGeneral));
                            },
                          ),
                        ),
                      ]),
                ),
              ),
              divider10(),
              Padding(
                padding: EdgeInsets.all(14),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Todas mis tareas",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: kBrandPrymaryColor),
                      ),
                      StreamBuilder(
                        stream: tasksReference.snapshots(),
                        builder: (BuildContext context, AsyncSnapshot snap) {
                          if (snap.hasData) {
                            List<TaskModel> tasks = [];
                            QuerySnapshot collection = snap.data;
                            /*
                      1 forma
                      collection.docs.forEach((element) {
                      Map<String,dynamic> myMap = element.data() as Map<String,dynamic>;
                      tasks.add(TaskModel.fromJson(myMap));
                      });*/
                            //2da forma
                            /*
                            tasks = collection.docs
                                .map((e) => TaskModel.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .toList();
                            */
                            //obteniendo el id
                            tasks = collection.docs.map((e) {
                              TaskModel task = TaskModel.fromJson(
                                  e.data() as Map<String, dynamic>);
                              task.id = e.id;
                              return task;
                            }).toList();
                            tasksGeneral.clear();
                            tasksGeneral = tasks;

                            return ListView.builder(
                                itemCount: tasks.length,
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemTaskWidget(
                                    taskModel: tasks[index],
                                  );
                                });
                          }
                          return loadingWidget();
                        },
                      ),
                    ]),
              )
            ],
          ),
        )
        /*
      StreamBuilder(
        stream: tasksReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snap){
          if(snap.hasData){
            QuerySnapshot collection = snap.data;
            List<QueryDocumentSnapshot> docs = collection.docs;
            List<Map<String, dynamic>> docsMap = docs.map((e)=> e.data() as Map<String,dynamic>).toList();
            print(docsMap);
            return ListView.builder(
              itemCount: docsMap.length,
              itemBuilder:(BuildContext context, int index){
                return ListTile( 
                  title: Text(docsMap[index]["title"]),
                );
              }
              );
          }
          return Center(child: CircularProgressIndicator(),);
        }
      )/*
      */
      StreamBuilder(stream: counter() ,
      builder: (BuildContext context, AsyncSnapshot snap){
        if(snap.hasData){
          QuerySnapshot collection = snap.data;
        }
        return Center(child: CircularProgressIndicator(),);
      },
      /* llamando a la instrucción de stream
      StreamBuilder(stream: counter() ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          int data = snapshot.data;
          return Center(child: Text(data.toString(),),);
        }
        return Center(child: CircularProgressIndicator(),);
      },*/
      )
      */
        );
  }
}
