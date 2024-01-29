//
//  Login.swift
//  estatemap
//
//  Created by  User on 9/28/23.
//

import SwiftUI

struct Login: View {
    @State var email = ""
    @State var pass = ""
    @State var color = Color.black.opacity(0.7)
    @State var visible = false
    @State var alert = false
    @State var error = ""
    @State var title = ""
    @State var gotoMain = false
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    func Verify() {
        Task{
            if self.email != "" && self.pass != ""{
                let result =  await LoginUser(email: self.email, password: self.pass)
                if result == true {
                    self.gotoMain.toggle()
                }else {
                    self.title = "Warning"
                    self.error = "Invalid User"
                    self.alert = true
                    
                }
            }else{
                self.title = "Warning"
                self.error = "Please fill all the content property"
                self.alert = true
            }
        }
        
    }
    var body: some View {
        NavigationView{
            VStack(){
                Image("Logo").resizable().frame(width: 352,height: 200,alignment: .top)
                Text("Sign in to your account")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 50)
                TextField("Username or Email",text:self.$email)
                                .autocapitalization(.none)
                                .padding()
                                .background(RoundedRectangle(cornerRadius:6).stroke(borderColor,lineWidth:2))
                                .padding(.horizontal,20)
                HStack(spacing: 15){
                                VStack{
                                    if self.visible {
                                        TextField("Password", text: self.$pass)
                                            .autocapitalization(.none)
                                    } else {
                                        SecureField("Password", text: self.$pass)
                                            .autocapitalization(.none)
                                    }
                                }
                                
                                Button(action: {
                                    self.visible.toggle()
                                }) {
                                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(self.color)
                                        .opacity(0.8)
                                }
                }.padding().background(RoundedRectangle(cornerRadius: 6).stroke(borderColor,lineWidth: 2)).padding(.horizontal,20).padding(.top,10)
                // Sign in button
                Button(action: {
                   self.Verify()
                }) {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.vertical)
                     .frame(width: UIScreen.main.bounds.width - 40)
                }
                .background(Color.blue)
                .cornerRadius(6)
                .padding(.top, 15)
                .alert(isPresented: $alert){()->Alert in
                    return Alert(title: Text("\(self.title)"), message: Text("\(self.error)"), dismissButton:
                        .default(Text("OK").fontWeight(.semibold)))
                }
                
                HStack(spacing: 5){
                    Text("Don't have an account ?")
                    NavigationLink(destination: Register()){
                        Text("Sign up")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    }
                    Text("now").multilineTextAlignment(.leading)
                    
                }.padding(.top, 25)
                NavigationLink(LocalizedStringKey("123"), destination: Main(),isActive: $gotoMain).hidden()
            }
        }
       
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
