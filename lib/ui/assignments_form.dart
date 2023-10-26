import 'package:flutter/material.dart';
import 'package:responsi/bloc/assignments_bloc.dart';
import 'package:responsi/model/assignments.dart';
import 'package:responsi/ui/assignments_page.dart';
import 'package:responsi/widget/warning_dialog.dart';

class AssignmentsForm extends StatefulWidget {
  Assignments? assignments;
  AssignmentsForm({Key? key, this.assignments}) : super(key: key);

  @override
  _AssignmentsFormState createState() => _AssignmentsFormState();
}

class _AssignmentsFormState extends State<AssignmentsForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH TUGAS";
  String tombolSubmit = "SIMPAN";

  final _titleTextboxController = TextEditingController();
  final _descriptionTextboxController = TextEditingController();
  final _deadlineTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.assignments != null) {
      setState(() {
        judul = "UBAH TUGAS";
        tombolSubmit = "UBAH";
        _titleTextboxController.text = widget.assignments!.title!;
        _descriptionTextboxController.text = widget.assignments!.description!;
        _deadlineTextboxController.text = widget.assignments!.deadline!;
      });
    } else {
      judul = "TAMBAH TUGAS";
      tombolSubmit = "SIMPAN";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _titleTextField(),
                _descriptionTextField(),
                _deadlineTextField(),
                _buttonSubmit()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul Tugas"),
      keyboardType: TextInputType.text,
      controller: _titleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Judul Tugas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi Tugas"),
      keyboardType: TextInputType.text,
      controller: _descriptionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deskripsi Tugas harus diisi";
        }
        return null;
      },
    );
  }

  Widget _deadlineTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline"),
      keyboardType: TextInputType.text,
      controller: _deadlineTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Deadline harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
        child: Text(tombolSubmit),
        onPressed: () {
          var validate = _formKey.currentState!.validate();
          if (validate) {
            if (!_isLoading) {
              if (widget.assignments != null) {
                ubah();
              } else {
                simpan();
              }
            }
          }
        });
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });
    Assignments createAssignments = Assignments(id: null);
    createAssignments.title = _titleTextboxController.text;
    createAssignments.description = _descriptionTextboxController.text;
    createAssignments.deadline = _deadlineTextboxController.text;

    AssignmentsBloc.addAssignments(assignments: createAssignments).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentsPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Simpan gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }

  ubah() {
    setState(() {
      _isLoading = true;
    });
    Assignments updateAssignments = Assignments(id: null);
    updateAssignments.id = widget.assignments!.id;
    updateAssignments.title = _titleTextboxController.text;
    updateAssignments.description = _descriptionTextboxController.text;
    updateAssignments.deadline = _deadlineTextboxController.text;
    AssignmentsBloc.updateAssignments(assignments: updateAssignments).then(
        (value) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const AssignmentsPage()));
    }, onError: (error) {
      showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
                description: "Permintaan ubah data gagal, silahkan coba lagi",
              ));
    });
    setState(() {
      _isLoading = false;
    });
  }
}
