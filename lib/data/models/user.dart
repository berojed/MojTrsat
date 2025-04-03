
class User {
  String id;
  String name;
  String email;
  String password;
  DateTime createdAt;

  User({required this.id,required this.name,required this.email,required  this.password, required this.createdAt});

  //method to convert User object data to map so supabase can store it as JSON 
  Map<String,dynamic> toMap()
  {
    return{

      'id':id,
      'name':name,
      'email':email,
      'password':password,
      'createdAt': createdAt.toIso8601String()
    };
  }

  //constructor to convert JSON to User object so app can use data from database
  factory User.fromMap(Map<String,dynamic> map)
  {
    String id = map['id'];
    String name = map['name'];
    String email = map['email'];
    String password = map['password'];
    DateTime createdAt = DateTime.parse(map['createdAt']);

    return User(id: id, name: name, email: email, password: password, createdAt: createdAt);
    
  }
 

  
}