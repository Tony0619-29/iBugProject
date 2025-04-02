//
//  SignUpView.swift
//  Pakal
//
//  Created by Antonio Medina on 02/04/25.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Crear Cuenta")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                TextField("Nombre completo", text: $name)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                TextField("Correo electrónico", text: $email)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
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
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                
                SecureField("Confirmar contraseña", text: $confirmPassword)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                if isLoading {
                    ProgressView()
                } else {
                    Button(action: {
                        register()
                    }) {
                        Text("Registrarse")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Registro")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Registro", isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                if alertMessage.contains("éxito") {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }
    
   
    private func register() {
        guard !name.isEmpty else {
            alertMessage = "Por favor ingresa tu nombre completo"
            showAlert = true
            return
        }
        
        guard !email.isEmpty else {
            alertMessage = "Por favor ingresa tu correo electrónico"
            showAlert = true
            return
        }
        
        guard isValidEmail(email) else {
            alertMessage = "Por favor ingresa un correo electrónico válido"
            showAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertMessage = "Por favor ingresa una contraseña"
            showAlert = true
            return
        }
        
        guard password.count >= 6 else {
            alertMessage = "La contraseña debe tener al menos 6 caracteres"
            showAlert = true
            return
        }
        
        guard password == confirmPassword else {
            alertMessage = "Las contraseñas no coinciden"
            showAlert = true
            return
        }
        
        isLoading = true
        //Validacion del Usurio se aguarda de manera local en el dispositivo
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UserDefaults.standard.set(name, forKey: "userName")
            UserDefaults.standard.set(email, forKey: "userEmail")
            UserDefaults.standard.set(password, forKey: "userPassword")
            
            isLoading = false
            alertMessage = "¡Registro exitoso!."
            showAlert = true
        }
    }
    //Validacion de Caracteres del correo electronico
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
