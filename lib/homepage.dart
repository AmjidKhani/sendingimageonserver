import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  File? image;
  Future getImage()async{
  final  pickimage=await  ImagePicker().pickImage(source:ImageSource.gallery);
  if(pickimage==null){
    print("Image not found");

  }
  else{
    setState(() {
      image=File(pickimage.path);
    });

  }

  }

 Future<void> upladimages()async{
var stream=await ByteStream(image!.openRead());
stream.cast();
var uri=Uri.parse("https://fakestoreapi.com/products"
    "");
int length=await image!.length();
var request=http.MultipartRequest('post',uri);
request.fields['title']="static title";
var multiport=new http.MultipartFile("post", stream, length);
request.files.add(multiport);
var response=await request.send();
if (response.statusCode==200) {
  print("Uploaded Successfully");

}
else{
  print("Failed");
}


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child:image==null? Center(child: GestureDetector(
                onTap: ()
                {
                  getImage();
                },
                child: Text(" Tap to Upload Images"))):Container(
              height: 200,
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.green,
),

              child: Image.file(
                (
                  File(image!.path).absolute),
            ),
          ),
          ),
GestureDetector(
  onTap: (){
    upladimages();
  },
  child:   Container(

    height: 70,

    width: 230,

    decoration: BoxDecoration(

      color: Colors.purple,

      borderRadius: BorderRadius.circular(20)



    ),

    child: Center(child: Text("Upload",style: TextStyle(color: Colors.white),),),

  ),
)

        ],
      ),
    );
  }
}
