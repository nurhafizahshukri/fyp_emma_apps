import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_tags/flutter_tags.dart';

class Interest extends StatefulWidget {

  @override
  _InterestState createState() => _InterestState();
}

class _InterestState extends State<Interest> {

  final List<String> _list = [
  ];
final List<String> _listSug =[
              "conferences",
              "seminar",
              "workshops",
              "expo",
              "award",
              "festival",
              "leadership",
              "creative",
              "cooking",
              "foreign language",
              "art",
              "robotic",
              "religious",
              "self improvement",
              "sport",
            ];

  @override
  void initState() {
    super.initState();

    _items = _list.toList();
  }

  List _items;


  @override
  Widget build(BuildContext context) {
    //List<Item> lst = _tagStateKey.currentState?.getAllItem; lst.forEach((f) => print(f.title));
    return 
      Column(children:[Padding(
        padding: const EdgeInsets.only(bottom:40),
        child: _tags2,
      ),_tags3] ); 
          
    
  }
  // Position for popup menu
  Widget get _tags2 {
    //popup Menu

    ItemTagsCombine combine = ItemTagsCombine.onlyText;


    return Tags(
      symmetry: false,
      horizontalScroll: false,
      verticalDirection:
          VerticalDirection.down,
      textDirection:  TextDirection.ltr,
      heightHorizontalScroll: 60 * (14 / 14),
      textField: _textField,
      itemCount: _items.length,

      itemBuilder: (index) {
        final item = _items[index];

        return GestureDetector(
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            activeColor: Colors.red[400],
            combine: combine,
            removeButton: ItemTagsRemoveButton(
              backgroundColor: Colors.red[900],
              onRemoved: () {
                setState(() {
                  _listSug.add(item);
                  _items.removeAt(index);

                });
                return true;
              },
            ),
            textScaleFactor:
                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
       
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      hintText: "Enter Your Interest",
      autofocus: false,
      hintTextColor: Colors.black,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      textStyle: TextStyle(
        fontSize: 15,
        //height: 1
      ),
      enabled: true,
      constraintSuggestion: true,
      textCapitalization:TextCapitalization.words ,
      suggestions: _listSug,
        
      onSubmitted: (String str) {
        setState(() {
          _items.add(str);
        });
      },
    );
  }

Widget get _tags3 {
    //popup Menu

    ItemTagsCombine combine = ItemTagsCombine.onlyText;


    return Tags(
      symmetry: false,
      columns: 4,
      horizontalScroll: false,
      verticalDirection:
          VerticalDirection.down,
      textDirection:  TextDirection.ltr,
      heightHorizontalScroll: 60 * (14 / 14),
      itemCount: _listSug.length,

      itemBuilder: (index) {
        final item = _listSug[index];

        return GestureDetector(
          onTap:() =>{
               setState(() {
          _items.add(item);
          _listSug.remove(item);
        })
            },

          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            
          
            pressEnabled: false,
            activeColor: Colors.red[400],
            combine: combine,
            textScaleFactor:
                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(
              fontSize: 14,
            ),
          ),
       
        );
      },
    );
  }

    }
