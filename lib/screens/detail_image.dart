import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_application_1/models/repository.dart';
import 'package:flutter_application_1/components/list_repository.dart';
import 'package:flutter_application_1/components/form_repository.dart';

class DetailImage extends StatelessWidget {
  const DetailImage(
      {Key? key,
      required this.id,
      required this.avatarUrl,
      required this.nome,
      required this.descricao})
      : super(key: key);
  final int id;
  final String avatarUrl;
  final String nome;
  final String descricao;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('image'),
        ),
        body: Center(
            child: Hero(
          tag: id,
          child: CachedNetworkImage(
            imageUrl: avatarUrl,
            imageBuilder: (context, imageProvider) => Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(100),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.all(30),
                  padding: EdgeInsets.all(20),
                  child: ListView(children: <Widget>[
                    Text(nome,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text(
                      descricao,
                      textAlign: TextAlign.center,
                    ),
                  ]),
                )),
              ],
            ),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fadeInDuration: Duration(milliseconds: 400),
          ),
        )));
  }
}
