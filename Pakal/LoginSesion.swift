//
//  LoginSesion.swift
//  Pakal
//
//  Created by Antonio Medina on 02/04/25.
//

import SwiftUI

struct LoginSesion: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var showingSignUp = false
    @State private var isLoggedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        if isLoggedIn {
            HomeView()
        } else {
            NavigationStack {
                ZStack {
                    
                    VStack(spacing: 20) {
                        
                        Text("App Para el Hakaton")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        
                        VStack(spacing: 15) {
                            TextField("Usuario o correo", text: $username)
                                .padding()
                                .background(Color(.systemGray6).opacity(0.9))
                                .cornerRadius(10)
                            
                            ZStack(alignment: .trailing) {
                                if showPassword {
                                    TextField("Contraseña", text: $password)
                                } else {
                                    SecureField("Contraseña", text: $password)
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.gray)
                                }
                                .padding(.trailing, 8)
                            }
                            .padding()
                            .background(Color(.systemGray6).opacity(0.9))
                            .cornerRadius(10)
                        }
                        .padding(.horizontal, 30)
                        
                        Button(action: {
                            login()
                        }) {
                            Text("Iniciar Sesión")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 200, height: 50)
                        }
                        .background(Color.blue)
                        .cornerRadius(10)
                        
                        
                        HStack {
                            Button("¿Olvidaste tu contraseña?") {
                                
                            }
                            .foregroundColor(.black)
                            
                            Spacer()
                            
                            Button("Registrarse") {
                                showingSignUp = true
                            }
                            .foregroundColor(.black)
                        }
                        .font(.caption)
                        .padding(.horizontal, 30)
                    }
                }
                .navigationDestination(isPresented: $showingSignUp) {
                    SignUpView()
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
    
    private func login() {
        //AQUI VAN VALIDACIONES PERO NUNCA ME FUNCIONARON XD
        isLoggedIn = true
    }
    
    struct LoginSesion_Previews: PreviewProvider {
        static var previews: some View {
            LoginSesion()
        }
    }
}
