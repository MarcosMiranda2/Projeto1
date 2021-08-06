import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/repository.dart';
import 'package:flutter_application_1/screens/detail_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Listarepositorio extends StatelessWidget {
  const Listarepositorio(
      {Key? key, required this.controller, required this.repositories})
      : super(key: key);

  final List<Album> repositories;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    //return Text('${repositories.length}');

    var leading = (int index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetailImage(
                id: repositories[index].id,
                avatarUrl: repositories[index].avatarUrl,
                nome: repositories[index].name,
                descricao: repositories[index].description,
              ),
            ),
          );
        },
        child: Hero(
            tag: repositories[index].id,
            child: CachedNetworkImage(
              imageUrl: repositories[index].avatarUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fadeInDuration: Duration(milliseconds: 400),
            )));
    return ListView.builder(
      controller: controller,
      itemCount: repositories.length,
      itemBuilder: (context, index) {
        return Card(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(repositories[index].name),
                subtitle: Text(repositories[index].description),
                leading: leading(index),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                TextButton(
                    onPressed: () async {
                      var url = repositories[index].url;
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("url invalida")));
                      }
                    },
                    child: Text('Abrir'))
              ],
            )
          ]),
          elevation: 5.0,
        );
      },
    );
  }
}
