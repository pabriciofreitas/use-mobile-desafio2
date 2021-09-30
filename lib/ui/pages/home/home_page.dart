import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart';

import '../page.dart';
import '../ver_mais/ver_mais.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpAdapter controller = HttpAdapter(client: Client());
  /*
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }*/
  // ModelFilme
  Future carregaDados() async {
    final response = await controller.request(
        url: "https://imdb-api.com/br/API/Keyword/k_wgr1o4iu/dramas",
        method: "get");
    print("response1 $response");
    // response[""]
    //List<ModelFilme> people = response .map((f) => ModelFilme.fromJson(f as Map<String, dynamic>)) .toList();
    //var listaDrama = ModelFilme.fromMap(Map<String, dynamic>.from(response));

    var listaDrama = response['items'];
    debugPrint("$listaDrama[1]");
    //  return listaDrama;
  }

  @override
  void initState() {
    super.initState();
    carregaDados();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: MinhaAppBar(text: "NerdFlix"),
      body: CustomScrollView(
        slivers: [
          //Filme em destaque
          SliverPadding(
            padding: EdgeInsets.only(top: size.height * 0.04),
            sliver: SliverToBoxAdapter(
              child: FilmeDestaque(
                url:
                    "https://imdb-api.com/images/original/MV5BNGU0ZDRlMTgtYmU0Zi00NGI4LTllZTItMGUyMDJlNGM2OWY5XkEyXkFqcGdeQXVyMjUyNDQ0NDE@._V1_Ratio1.7600_AL_.jpg",
                text: Text(
                  "Lançamento",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                size: size,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetalhePage()));
                },
              ),
            ),
          ),
          //
          // Para você
          SliverPadding(
            padding: EdgeInsets.only(
                top: size.height * 0.025, left: size.width * 0.04, right: 0.04),
            sliver: SliverToBoxAdapter(
              child: RowGenero(
                text: "Para Você",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerMaisPage(
                                textTema: "Para voce",
                              )));
                },
              ),
            ),
          ),
          //lista de filmes na horizontal
          SliverPadding(
            padding: EdgeInsets.only(
              top: size.height * 0.001,
            ),
            sliver: SliverToBoxAdapter(
              child: ListFilmeHorizontal(size: size),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: size.width * 0.04, right: 4),
            sliver: SliverToBoxAdapter(
              child: RowGenero(
                text: "Ação",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerMaisPage(
                                textTema: "Ação",
                              )));
                },
              ),
            ),
          ),
          //lista de filmes na horizontal
          SliverPadding(
            padding: EdgeInsets.only(
              top: size.height * 0.001,
            ),
            sliver: SliverToBoxAdapter(
              child: ListFilmeHorizontal(size: size),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(left: size.width * 0.04, right: 4),
            sliver: SliverToBoxAdapter(
              child: RowGenero(
                text: "Drama",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerMaisPage(
                                textTema: "Drama",
                              )));
                },
              ),
            ),
          ),
          //lista de filmes na horizontal
          SliverPadding(
            padding: EdgeInsets.only(
              top: size.height * 0.001,
            ),
            sliver: SliverToBoxAdapter(
              child: ListFilmeHorizontal(size: size),
            ),
          ),
        ],
      ),
    );
  }
}
