import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/botton.dart';

class FormRepository extends StatefulWidget {
  const FormRepository(
      {Key? key,
      required this.repo,
      required this.changeRepo,
      required this.onSearch,
      required this.loading})
      : super(key: key);
  final String repo;
  final Function changeRepo;
  final Function onSearch;
  final bool loading;

  @override
  _FormRepositoryState createState() => _FormRepositoryState();
}

class _FormRepositoryState extends State<FormRepository> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: true,
              onChanged: (value) => widget.changeRepo(value),
              decoration: const InputDecoration(
                labelText: 'Pesquisa',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, coloque um texto';
                }
                return null;
              }),
          Botton(
            onPressed: widget.loading || widget.repo.isEmpty
                ? null
                : () {
                    if (_formkey.currentState!.validate()) {
                      widget.onSearch();
                    }
                  },
            text: 'Pesquisar',
          ),
        ],
      ),
    );
  }
}
