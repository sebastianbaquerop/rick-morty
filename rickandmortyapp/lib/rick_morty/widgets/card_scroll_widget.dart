import 'package:flutter/material.dart';
import 'dart:math';

class CardScrollWidget extends StatelessWidget {
  var name;
  var imageUrl;
  var status;
  var species;

  CardScrollWidget(this.name, this.imageUrl, this.status, this.species);

  @override
  Widget build(BuildContext context) {
    var cardAspectRatio = 1.0 / 1.0;
    var widgetAspectRatio = cardAspectRatio * 1.2;

    return Card(
        color: Color.fromRGBO(255, 240, 201, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(15),
        elevation: 10,

        // Dentro de esta propiedad usamos ClipRRect
        child: ClipRRect(
          // Los bordes del contenido del card se cortan usando BorderRadius
          borderRadius: BorderRadius.circular(10),

          // EL widget hijo que será recortado segun la propiedad anterior
          child: Column(
            children: <Widget>[
              // Usamos el widget Image para mostrar una imagen
              // Usamos Container para el contenedor de la descripción
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Image(
                // Como queremos traer una imagen desde un url usamos NetworkImage
                image: NetworkImage(imageUrl),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text(
                              'Specie:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                            Text(species),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Status:',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(status),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
