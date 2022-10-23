import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:rickandmortyapp/rick_morty/widgets/card_scroll_widget.dart';

class RickAndMorty extends StatefulWidget {
  const RickAndMorty({Key? key}) : super(key: key);

  @override
  _RickAndMortyState createState() => _RickAndMortyState();
}

class _RickAndMortyState extends State<RickAndMorty> {
  @override
  Widget build(BuildContext context) {
    String query = """
    query {
      characters(page:1) {
        info {
          count
        }
        results {
          name
          image
          status
          species
        }
      }
    }
  """;
    var currentPage = 0.0;
    PageController controller = PageController(initialPage: 0);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
      });
    });

    return Query(
      options: QueryOptions(
        document: gql(query), // this is the query string you just created
      ),
      // Just like in apollo refetch() could be used to manually trigger a refetch
      // while fetchMore() can be used for pagination purpose
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }
        if (result.isLoading) {
          return Center(
            child: const CircularProgressIndicator(
              semanticsLabel: 'Loading',
              color: Colors.white,
            ),
          );
        }
        List? repositories = result.data?['characters']?['results'];
        if (repositories == null) {
          return const Text('No repositories');
        }
        return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];
              return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
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
                            repository['name'] ?? '',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Image(
                          // Como queremos traer una imagen desde un url usamos NetworkImage
                          image: NetworkImage(repository['image'] ?? ''),
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(repository['species'] ?? ''),
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
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(repository['status'] ?? ''),
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
            });
      },
    );
  }
}
