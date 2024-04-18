import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("LoginBackground")
                VStack{
                    Text("Login")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    TextField("Username", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                        .border(.red,width:CGFloat(wrongUsername))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.white.opacity(1))
                        .cornerRadius(10)
                        .border(.red,width:CGFloat(wrongPassword))

                        Button("Login"){
                            authenticateUser(username: username, password: password)

                    }
                    .foregroundColor(.black)
                    .frame(width:300, height:50)
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    
                    NavigationLink(destination: SignUpScreen()){
                        Text("Sign Up")
                    }
                        .foregroundColor(.blue)
                        .font(.subheadline)
                    
                    NavigationLink(destination: MainTabView().navigationBarBackButtonHidden(true),isActive:$showingLoginScreen){
                        EmptyView()
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    func authenticateUser(username: String, password: String){
        if !username.isEmpty && !password.isEmpty {
            // Any non-empty username and password combination will be considered valid
            showingLoginScreen = true
            wrongUsername = 0
            wrongPassword = 0
        } else {
            // If either username or password is empty, show an error
            wrongUsername = username.isEmpty ? 2 : 0
            wrongPassword = password.isEmpty ? 2 : 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
