import 'package:FlutterNews/pages/featured/content_featured.dart';
import 'package:FlutterNews/pages/home/home_bloc.dart';
import 'package:FlutterNews/pages/info/info.dart';
import 'package:FlutterNews/pages/news/content_news.dart';
import 'package:FlutterNews/util/bloc_provider.dart';
import 'package:FlutterNews/widgets/bottom_navigation.dart';
import 'package:FlutterNews/widgets/search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  static Widget create(){
    return BlocProvider<HomeBloc>(
      bloc: HomeBloc(),
      child: HomePage(),
    );
  }

  @override
  Widget build(BuildContext context) {

    HomeBloc bloc = BlocProvider.of<HomeBloc>(context);

    return new Scaffold(
      body: new Container(
        color: Colors.grey[200],
        child:  new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(
              child: new SearchWidget(),
            ) ,
            new Expanded(
                child: _getContent(bloc)
            )
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigation((index){
        bloc.selectTab(index);
      }), // This trailing comma makes auto-formatting nicer for build methods.
    );


  }

  Widget _getContent(HomeBloc bloc){

    return StreamBuilder(
        stream: bloc.tabPosition,
        initialData: 0,
        builder:  (BuildContext context, AsyncSnapshot snapshot){

          var position = snapshot.data;

          switch(position){
            case 0:return ContentFeaturedPage.create();break;
            case 1: return ContentNewsPage.create();break;
            default: return Info();
          }

        }
    );
  }

}