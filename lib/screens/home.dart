import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_application_1/models/repository.dart';
import 'package:flutter_application_1/components/list_repository.dart';
import 'package:flutter_application_1/components/form_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _rolagemController = new ScrollController();

  List<Album> _repositories = [];
  var _loading = false;
  var _finalRolagem = false;
  var _pagAtual = 1;
  String _repo = '';

  @override
  void initState() {
    super.initState();
    _rolagemController.addListener(() {
      var pixels = _rolagemController.position.pixels;
      var rolagemSize = _rolagemController.position.maxScrollExtent;

      if (pixels == rolagemSize && !_finalRolagem) {
        procuraRepositorio(page: _pagAtual + 1);
      }
    });
  }

  Future<void> procuraRepositorio({int page = 1}) async {
    if (_loading) return;
    if (page == 1 && _repositories.isNotEmpty) {
      _repositories.clear();
    }

    setState(() {
      _loading = true;
      _finalRolagem = false;
    });
    var response = await http.get(Uri.parse(
        "https://api.github.com/search/repositories?q=$_repo&page=$page&per_page=10"));
    var data = jsonDecode(response.body);
    var items = data['items'] as List;
    setState(() {
      _loading = false;
      _pagAtual = page;
      if (items.isEmpty) {
        _finalRolagem = true;
        return;
      }
      _repositories += items.map((e) => Album.fromJson(e)).toList();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("git", style: TextStyle(fontSize: 24.0)),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            FormRepository(
              repo: _repo,
              changeRepo: (String value) => setState(() {
                _repo = value;
              }),
              onSearch: procuraRepositorio,
              loading: _loading,
            ),
            if (_repositories.isNotEmpty)
              Expanded(
                child: Listarepositorio(
                  controller: _rolagemController,
                  repositories: _repositories,
                ),
              ),
            if (_loading)
              Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}
