import 'package:flutter/material.dart';
import 'package:responsi/bloc/assignments_bloc.dart';
import 'package:responsi/model/assignments.dart';
import 'package:responsi/ui/assignments_detail.dart';
import 'package:responsi/ui/assignments_form.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({Key? key}) : super(key: key);

  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Tugas'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: const Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AssignmentsForm()));
                },
              ))
        ],
      ),
      body: FutureBuilder<List>(
        future: AssignmentsBloc.getAssignments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListAssignments(
                  list: snapshot.data,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListAssignments extends StatelessWidget {
  final List? list;
  const ListAssignments({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list!.length,
        itemBuilder: (context, i) {
          return ItemAssignments(
            assignments: list![i],
          );
        });
  }
}

class ItemAssignments extends StatelessWidget {
  final Assignments assignments;

  const ItemAssignments({Key? key, required this.assignments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AssignmentsDetail(
                      assignments: assignments,
                    )));
      },
      child: Card(
        child: ListTile(
          title: Text(assignments.title!),
          subtitle: Text(assignments.description!),
        ),
      ),
    );
  }
}
