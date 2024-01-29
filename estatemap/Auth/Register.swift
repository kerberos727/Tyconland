//
//  Register.swift
//  estatemap
//
//  Created by  User on 9/28/23.
//

import SwiftUI

struct Register: View {
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    
    @State var color = Color.black.opacity(0.7)
    
    @State var visible = false
    @State var revisible = false
    
    @State var title = ""
    @State var alert = false
    @State var error = ""
    
    let borderColor = Color(red: 107.0/255.0, green: 164.0/255.0, blue: 252.0/255.0)
    func onRegister(){
        if self.pass != self.repass {
            self.title = "Warning"
            self.error = "Please check Password again."
            self.alert = true
            return
        }
        Task{
            if self.email != "" && self.pass != ""{
                let result =  await RegisterUser(email: self.email, password: self.pass)
                if result == "Success" {
                    self.title = "Welcome"
                    self.error = "Registered successfully."
                    self.alert = true
                    
                }else {
                    self.title = "Warning"
                    self.error = result
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
        
        VStack{
            Image("Logo").resizable().frame(width: 352,height: 200,alignment: .top)
            Text("Sign up a new account")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 50)
            
            TextField("Username or Email",text:self.$email)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius:6).stroke(self.borderColor,lineWidth:2))
                .padding(.top, 0).padding(.horizontal,20)
            
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
                    //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
            .stroke(self.borderColor,lineWidth: 2))
            .padding(.top, 10).padding(.horizontal,20)
            
            
            // Confirm password
            HStack(spacing: 15){
                VStack{
                    if self.revisible {
                        TextField("Confirm Password", text: self.$repass)
                            .autocapitalization(.none)
                    } else {
                        SecureField("Confirm Password", text: self.$repass)
                            .autocapitalization(.none)
                    }
                }
                
                Button(action: {
                    self.revisible.toggle()
                }) {
                    //Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill").foregroundColor(self.color)
                        .opacity(0.8)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 6)
            .stroke(self.borderColor,lineWidth: 2))
            .padding(.top, 10).padding(.horizontal,20)
            // Sign up button
            Button(action: { self.onRegister()  }) {
                                    Text("Sign up")
                                        .foregroundColor(.white)
                                        .fontWeight(.bold)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 40)
                                }
                                .background(.blue)
                                .cornerRadius(6)
                                .padding(.top, 15)
                                .alert(isPresented: self.$alert){()->Alert in
                                    return Alert(title: Text("Sign up error"), message: Text("\(self.error)"), dismissButton:
                                        .default(Text("OK").fontWeight(.semibold)))
                                }
            
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
