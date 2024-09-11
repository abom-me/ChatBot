


import 'dart:io';

import 'package:chatbot/colors.dart';
import 'package:chatbot/model/message.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';
import 'package:type_text/type_text.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController msg =TextEditingController();
  bool isTyping = false;
  bool isSend = false;
  File? image;
  List<Message> messages = [
    Message(
      message: "أهلا انا صديقك احمد كيف يمكنني مساعدتك اليوم؟",
      sender: "bot",
      time: DateTime.now().toString(),
      receiver: "user",
    )
  ];


ScrollController controller = ScrollController();
  Future  chat( String message) async {
    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash-latest',
        apiKey: "Enter your api key here",
        systemInstruction: Content.system("""انت خبير اقتصادي """)
      );

   if(image!=null){

     final prompt = TextPart(message);
     final imageParts = [
       DataPart('image/jpeg', await image!.readAsBytes()),
     ];
     final response = await model.generateContent([
       Content.multi([prompt, ...imageParts])
     ]);


     messages.add(Message(
       message: response.text,
       sender: "bot",
       time: DateTime.now().toString(),
       receiver: "user",
     ));
   }else{

      final prompt = TextPart(message);
      final response = await model.generateContent([
        Content.text(prompt.text)
      ]);



      print(response.text);
      messages.add(Message(
        message: response.text,
        sender: "bot",
        time: DateTime.now().toString(),
        receiver: "user",
      ));
   }
setState(() {

  _scrollToBottom();
});

    } catch (e) {
    }

  }
  void _scrollToBottom() {
    if (controller.hasClients) {
      controller.animateTo(controller.position.maxScrollExtent,curve: Curves.easeOut, duration: const Duration(milliseconds: 300));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          title: Text("بوت"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(

            children: [
              Expanded(child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                  itemCount: messages.length,

                  itemBuilder: (context,index){
                    return messages[index].sender=="user"?Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.7,
                          decoration: BoxDecoration(
                            color: MyColors().black,
                            borderRadius: BorderRadius.circular(10)
                          ),

                          margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              messages[index].image!=null?Container(

                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width*0.7
                                ),
                                padding: EdgeInsets.all(10),
                                // margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Image.file(File(messages[index].image!)),
                              ):Container(),
                              Container(
                                padding: EdgeInsets.all(10),

                                decoration: BoxDecoration(
                                  color: MyColors().black,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text(messages[index].message!,style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),),
                              )
                            ],
                          ),
                        ),
                      ],
                    ):Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                    constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width*0.7
                    ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Color(0xffF6F5FA),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: TypeText(
                            messages[index].message!,
                            duration: const Duration(seconds: 1),
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),

                            //You can use all the other Text widget fields
                          ),
                        )
                      ],
                    );
                  }
              )),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                // height: 100,
                child: Column(

                  children: [
                    image!=null?GestureDetector(
                      onLongPress: (){
                        setState(() {
                          image = null;
                        });
                      },
                      child: Container(
                        height: 150,
                        width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(image!),
                          fit: BoxFit.cover
                        )

                      ),
                      ),
                    ):Container(),
                    Row(
                      children: [
                        Expanded(child: TextField(
                          textInputAction: TextInputAction.send,
                          textAlign: TextAlign.right,
                          controller: msg,
                          onChanged: (value){
                            if(value.isNotEmpty){
                              setState(() {
                                isTyping = true;
                              });
                            }else{
                              setState(() {
                                isTyping = false;
                              });
                            }
                          },
                          decoration: InputDecoration(

                            suffixIcon: IconButton(
                              onPressed: (){
                                ImagePicker().pickImage(source: ImageSource.gallery).then((value){
                                  if(value!=null){
                                    image = File(value.path);
                                    setState(() {
                                    });
                                  }
                                });
                              },
                              icon: Icon(Icons.image),
                            ),
                            hintText: "ادخل الرسالة",

                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Focused border color

                              borderRadius: BorderRadius.circular(10)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black), // Focused border color

                                borderRadius: BorderRadius.circular(10)
                            ),
                              //border color


                          ),

                        )),
                       InkWell(
                         onTap: (){
                           if(msg.text.isNotEmpty){
                             messages.add(Message(
                               message: msg.text,
                               sender: "user",
                               time: DateTime.now().toString(),
                               receiver: "bot",
                              image: image?.path
                             ));
                             chat(msg.text);

                             msg.clear();
                             setState(() {
                               image=null;
                               _scrollToBottom();
                             });
                           }
                         },
                         child: Container(
                           margin: EdgeInsets.all(10),
                           width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: MyColors().black,
                              borderRadius: BorderRadius.circular(15)
                            ),
                           child: Icon(
                              Icons.send,
                              color: Colors.white,

                           ),

                         ),
                       )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
