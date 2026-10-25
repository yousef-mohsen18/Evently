
class User {

  String? id;
  String? name;
  String? email;
  List<String>? favorites;

  User({required this.id,required this.email,required this.name, this.favorites });

  User.formFireStore(Map<String,dynamic>?data){
    id=data?["id"];
    name=data?["name"];//yousef
    email=data?["email"];
    favorites=List<String>.from(data?["favorites"] );
  }

 Map<String,dynamic>  toFireStore(){
    return
      {
        "id":id,
        "name":name,
        "email":email,
        "favorites":favorites
    };
  }

}