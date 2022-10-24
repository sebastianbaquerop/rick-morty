import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/crossword_model.dart';

class Crossword extends StatefulWidget {
  Crossword({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CrosswordState();
}

class _CrosswordState extends State<Crossword> {
  TextEditingController wordController = new TextEditingController();
  bool showText = false;
  bool showTexLocation = false;
  String text = '';
  String location = '';
  List<List<String>> crossword = [
    ['Z', 'E', 'E', 'K', 'T', 'F', 'O', 'R', 'G', 'E', 'E', 'K', 'T'],
    ['G', 'E', 'E', 'K', 'E', 'Q', 'U', 'I', 'Z', 'G', 'E', 'E', 'E'],
    ['I', 'D', 'E', 'Q', 'S', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'S'],
    ['I', 'T', 'E', 'S', 'O', 'R', 'O', 'A', 'C', 'T', 'I', 'C', 'O'],
    ['I', 'D', 'E', 'Q', 'R', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'R'],
    ['I', 'D', 'E', 'Q', 'O', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'O'],
    ['I', 'D', 'E', 'Q', 'A', 'P', 'R', 'A', 'C', 'T', 'I', 'C', 'Z'],
  ];

  List<int> xoYo = [];
  List<int> xfYf = [];
  List<List<int>> xiYiXfYf = [];
  List<List<int>> xfYf2 = [];
  List<Map<String, dynamic>> founds = [];

// These arrays are used to get row and column
// numbers of 8 neighboursof a given cell
  List<double> xDir = [-1, 0, 0, 1];
  List<double> yDir = [0, -1, 1, 0];

  @override
  void initState() {
    super.initState();
    generateCrossword();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(children: [
        Expanded(
          flex: 2,
          child: Container(
              constraints: new BoxConstraints(
                minHeight: size.height * .4,
                maxHeight: size.height * .4,
              ),
              alignment: Alignment.center,
              color: Colors.blueGrey,
              height: size.height,
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              child: GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossword[0].length,
                  ),
                  children: <Widget>[
                    for (int i = 0; i != crossword.length; ++i)
                      for (int j = 0; j != crossword[0].length; ++j)
                        (xoYo.length > 2 &&
                                xfYf.length > 2 &&
                                (i == xoYo[0] && j == xoYo[1] ||
                                    i == xfYf[0] && j == xfYf[1]))
                            ? Card(
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    crossword[i][j],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ))
                            : Card(
                                color: Color.fromRGBO(255, 240, 201, 1),
                                child: Center(
                                  child: Text(
                                    crossword[i][j],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ),
                  ])),
        ),
        Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                          controller: wordController,
                          style: TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Colors.white), //<-- SEE HERE
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3, color: Colors.blueGrey)),
                            iconColor: Colors.white,
                            fillColor: Colors.white,
                            labelText: 'Word to search',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white),
                            helperStyle: TextStyle(color: Colors.white),
                            floatingLabelStyle: TextStyle(color: Colors.white),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp("[a-zA-Z]")),
                          ],
                          onChanged: (newText) {
                            if (newText == '') {
                              setState(() {
                                showText = false;
                                text = newText;
                              });
                            }
                          }),
                    ),
                    Row(
                      children: [
                        if (showText)
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(255, 240, 201, 1),
                                )),
                          )),
                        if (showTexLocation)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(location,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(255, 240, 201, 1),
                                  )),
                            ),
                          )
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(color: Colors.grey)))),
                        child: Text('Buscar'),
                        onPressed: () {
                          if (wordController.text != '') {
                            // text = wordController.text.toUpperCase();
                            setState(() {
                              showText = true;
                              text = wordController.text;
                              _findWord();
                            });
                          }
                        }),
                  ],
                ),
              ),
            ))
      ]),
    );
  }

  _findWord() {
    List word = text.split("");
    findWords(crossword, word, word.length - 1);
  }

// The main function to find all occurrences of the
// word in a matrix
  findWords(crossword, word, n) {
    xoYo = [];
    xfYf = [];
    xiYiXfYf = [];
    location = '';
    int totalRows = crossword.length;
    int totalColS = crossword[0].length;
    String wordsFound;
    // traverse through the all cells of given matrix
    for (int i = 0; i < totalRows; ++i)
      for (int j = 0; j < totalColS; ++j)
        // occurrence of first character in matrix
        if (crossword[i][j] == word[0])
          // check and print if path exists
          checkPath(crossword, i, j, -1, -1, word, "", 0, n);
  }

// A utility function to do DFS for a 2D boolean
// matrix. It only considers the 4 neighbours as
// vertical and horizontal vertices
  checkPath(crossword, row, col, prevRow, prevCol, word, path, index, n) {
    // return if current character doesn't match with
    // the next character in the word
    if (index > n || crossword[row][col] != word[index]) return;

    // append current character position i and f to path
    if (index == 0 || index == n) {
      path += (word[index]) +
          "(" +
          (row).toString() +
          ", " +
          (col).toString() +
          ") ";
      xiYiXfYf.add([row, col]);
      founds.add({'row': row, 'col': col});
    }

// if (crossword[row][col] == word[index]) {
//       var position = wordToSearch.indexOf(word[index]);
//       if (position == 0 || position == wordToSearch.length - 1) {
//         xiYiXfYf.add([row, col]);
//         print('position = $position');
//       }
//     }
    // current character matches with the last character
    // in the word
    if (index == n) {
      location += path;
      print('location = $location');
      showTexLocation = true;
      print('location = $xiYiXfYf');

      print('founds = $founds');
      deleteDuplicated(founds);
      return;
    }

    // Recur for all connected neighbours
    for (int k = 0; k < xDir.length; ++k)
      if (isValid(row + xDir[k], col + yDir[k], prevRow, prevCol))
        checkPath(crossword, row + xDir[k], col + yDir[k], row, col, word, path,
            index + 1, n);
  }

// check whether given cell (row, col) is a valid
// cell or not.
  isValid(row, col, prevRow, prevCol) {
    int totalRows = crossword.length;
    int totalColS = crossword[0].length;
    // return true if row number and column number
    // is in range
    return (row >= 0) &&
        (row < totalRows) &&
        (col >= 0) &&
        (col < totalColS) &&
        !(row == prevRow && col == prevCol);
  }
}

void generateCrossword() {}

deleteDuplicated(founds) {
  var set = Set<CrosswordModel>.from(founds.map<CrosswordModel>(
      (position) => CrosswordModel(position['row'], position['col'])));
  var result = set.map((person) => person.toMap()).toList();
  print('result = $result');
}
