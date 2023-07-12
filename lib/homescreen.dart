
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/model/newsmodel.dart';
import 'package:newsapp/service/newsservice.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  
  
class _HomeScreenState extends State<HomeScreen> {
     
     News? datas;
  

  Future<News?> datafetch()async{
   await ApiService().getdata().then((value) => datas = value);
   return datas;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        surfaceTintColor: Colors.white,  
        backgroundColor:const Color.fromARGB(255, 255, 255, 255),
        toolbarHeight: 70,
        leading:const Image(image: AssetImage('assets/news.jpg'),fit: BoxFit.cover,),
        leadingWidth: 130,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: ()async{
             await FirebaseAuth.instance.signOut(); 
            }, icon:const Icon(Icons.logout_outlined)),
          )
        ],
      ),
      body: SafeArea(child:
      FutureBuilder(
        future: datafetch(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
          itemCount: snapshot.data!.articles!.length,  
         itemBuilder: (context, index) {
           return  Padding(
             padding:const  EdgeInsets.fromLTRB(12,3,12,3),
             child: Card( 
              color:const Color.fromARGB(255, 246, 246, 246), 
              child: SizedBox(
                width: double.infinity,
                height: 331,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190,
                        
                        decoration: 
                       datas!.articles![index].urlToImage != null ?
                        BoxDecoration(
                          image:DecorationImage(image: NetworkImage(snapshot.data!.articles![index].urlToImage!),fit: BoxFit.fill ),   
                          
                          borderRadius:const BorderRadius.all(Radius.circular(10))
                        ):const BoxDecoration()
                      ),
                     const SizedBox(height: 4,),
                      
                      Text(snapshot.data!.articles![index].title!,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 15 ),),
                      Flexible(child: Text(snapshot.data!.articles![index].description ??= 'no description',style:const TextStyle(fontSize: 13),)) 
                    ],
                  ),
                ), 
              ),
             ),
           ); 
         },
        );
          }else{
            return const Center(child: CircularProgressIndicator(color: Colors.black,),);  
          }
          
        }, 
      )),
    );
  }
}