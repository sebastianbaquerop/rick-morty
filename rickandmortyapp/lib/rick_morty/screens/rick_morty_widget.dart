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
              color: Color.fromRGBO(255, 240, 201, 1),
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
              return CardScrollWidget(
                  repository['name'] ?? '',
                  repository['image'] ?? '',
                  repository['status'] ?? '',
                  repository['species'] ?? '');
            });
      },
    );
  }
}
