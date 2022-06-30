class UserModel {
   String? email ;
   String? name;
   String? phone;
   String? uId;

   UserModel(this.email,this.name,this.phone,this.uId);

   UserModel.formJson(Map<String , dynamic> json){
     email = json['email'];
     name = json['name'];
     phone = json['phone'];
     uId = json['uId'];

   }

   Map<String , dynamic> userMap(){
      return {
         'email' : email,
         'name' : name,
         'phone' : phone,
         'uId' : uId,

      };
   }

}