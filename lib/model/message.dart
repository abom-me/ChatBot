
class Message {
  String? message;
  String? sender;
  String? receiver;
  String? time;
  String? image;
  Message({this.message, this.sender, this.receiver, this.time, this.image});
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      sender: json['sender'],
      receiver: json['receiver'],
      time: json['time'],
      image: json['image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'time': time,
      'image': image,
    };
  }
}