import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatPage extends StatefulWidget {

  const ChatPage({Key? key, required this.userId}) : super(key: key);
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
          title: const Text("チャットページ"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                    .collection("chat_room")
                    .orderBy("created_at", descending: true)
                    .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Container();
                    return ListView.separated(
                      padding: const EdgeInsets.all(10.0),
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
                        itemCount: snapshot.data!.docs.length,separatorBuilder: (context, index) {
                        return const Divider(height: 1.0);
                      },
                    );
                  }
                ),
              ),
                const Divider(height: 10.0),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20.0, right: 50.0, left: 50.0),
                    child: Row(
                      children: [
                      Flexible(
                        child: TextField(
                          controller: _controller,
                          onSubmitted: _handleSubmit,
                          decoration: const InputDecoration(
                              hintText: "メッセージの送信",
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue,),
                          onPressed: () {
                            _handleSubmit(_controller.text);
                          }),
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
        children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0,),
            Text(message),
          ],
        ),
        const Icon(Icons.person),
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
        children: [
          const Icon(Icons.person),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0,),
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

