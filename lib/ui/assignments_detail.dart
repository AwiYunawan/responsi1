import 'package:flutter/material.dart';
import 'package:responsi/model/assignments.dart';
import 'package:responsi/ui/assignments_form.dart';
import 'package:responsi/ui/assignments_page.dart';

import '../bloc/assignments_bloc.dart';

class AssignmentsDetail extends StatefulWidget {
  Assignments? assignments;
  AssignmentsDetail({Key? key, this.assignments}) : super(key: key);
  @override
  _AssignmentsDetailState createState() => _AssignmentsDetailState();
}

class _AssignmentsDetailState extends State<AssignmentsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Assignments'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Judul : ${widget.assignments!.title}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Deskripsi : ${widget.assignments!.description}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Deadline : ${widget.assignments!.deadline}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        OutlinedButton(
            child: const Text("EDIT"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AssignmentsForm(
                            assignments: widget.assignments!,
                          )));
            }),
        OutlinedButton(
            child: const Text("DELETE"), onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        OutlinedButton(
          child: const Text("Ya"),
          onPressed: () {
            AssignmentsBloc.deleteAssignments(id: widget.assignments?.id)
                .then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AssignmentsPage()));
            });
          },
        ),
        OutlinedButton(
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(builder: (context) => alertDialog, context: context);
  }
}
