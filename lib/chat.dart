import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatefulWidget {

  ChatPage({Key? key, required this.userId}) : super(key: key);
  final String userId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("チャットページ"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                    .collection("chat_room")
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return ListView.separated(
                      padding: EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (BuildContext context, int index) {
                        DocumentSnapshot document =
                        snapshot.data!.docs[index];

                        bool isOwnMessage = false;
                        if (document['user_id'] == widget.userId) {
                          isOwnMessage = true;
                        }
                        return isOwnMessage
                            ? _ownMessage(
                            document['message'], document['user_id'],)
                            : _message(
                            document['message'], document['user_id'],);
                      },
                        itemCount: snapshot.data!.docs.length,
                      separatorBuilder: (context, index) {
                        print('separator: $index');
                        return Divider(height: 1.0);
                      },
                    );
                  }
                ),
              ),
                Divider(height: 1.0),
                  Container(
                    margin: EdgeInsets.only(bottom: 20.0, right: 10.0, left: 10.0),
                    child: Row(
                      children: <Widget>[
                      Flexible(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: _handleSubmit,
                          decoration: InputDecoration.collapsed(
                              hintText: "メッセージの送信"),
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.send, color: Colors.blue,),
                            onPressed: () {
                              _handleSubmit(_controller.text);
                            }),
                      ),
                      ],
                    ),
                  ),
              ],
          ),
        )
    );
  }

  Widget _ownMessage(String message, String userName, ) {
    return Container(
      height: 50,
        width: 50,
        clipBehavior: Clip.hardEdge,
        decoration:
        BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.cyan,
        ),
        child: 
      Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16.0,),
            Text(message),
          ],
        ),
        Icon(Icons.person),
      ],
    )
    );
  }

  Widget _message(String message, String userName, ) {
    return Container(
      height: 50,
      width: 50,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.white38),
      child:
      Row(
        children: <Widget>[
          Icon(Icons.person),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 16.0,),
              Text(message),
            ],
          ),
        ],
      ),
    );
  }

  _handleSubmit(String message) {
    _controller.text = "";
    var db = FirebaseFirestore.instance;
    db.collection("chat_room").add({
      "user_id": widget.userId,
      "message": message,
      "created_at": DateTime.now()
    });
  }
}

