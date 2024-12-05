//
//  ContentView.swift
//  GradeUp
//
//  Created by prk on 16/11/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {
 
    @State var isRegister : Bool = false
    
    var body: some View {
        ZStack{
            Color(hex: "#F0F3F8").ignoresSafeArea()
            CircleBackground(isRegister: $isRegister)
            
            VStack {
                
                Image(systemName: "moon.stars.fill")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 164, height: 164)
                    .padding(.vertical,32)
                   
                
                Picker(selection: $isRegister, label: Text("Picker")) {
                    Text("SIGN IN").tag(false)
                    Text("SIGN UP").tag(true)
                }
                    .pickerStyle(SegmentedPickerStyle())
                
                
                if isRegister {
                    SignUpView()
                }
                else {
                    SignInView()
                }
                
                Spacer()
             
            }.padding(.horizontal,46)
            
            
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}

struct CircleBackground: View {
    
    @Binding var isRegister : Bool
    
    var body: some View {
        ForEach(0..<3){index in
            Circle().fill(RadialGradient(gradient: Gradient(colors: [Color(hex: isRegister ? "FCA6BF" : "7D8FE1").opacity(0.25),Color(hex: "73B7EF").opacity(0)]), center: .center, startRadius: 25, endRadius: 100))
                .frame(width: 400,height: 400)
                .position(x: CGFloat.random(in: 0...400), y: CGFloat.random(in: 0...800))
        }
    }
}

struct SignUpView: View {
    
    var body: some View {
        TextFieldPrimary(placeholderText: "Name")
            .padding(.top,37)
        TextFieldPrimary(placeholderText: "Grade")
            .padding(.top,28)
        TextFieldPrimary(placeholderText: "Email")
            .padding(.top,28)
        TextFieldPrimary(placeholderText: "Password")
            .padding(.top,28)
        ButtonPrimary(title: "REGISTER", onClick: {})
            .padding(.top,32)
    }
}

struct SignInView: View {
    var body: some View {
        TextFieldPrimary(placeholderText: "Email")
            .padding(.bottom,29)
            .padding(.top,37)
        
        TextFieldPrimary(placeholderText: "Password")
        
        ButtonPrimary(title: "LOGIN", onClick: {})
            .padding(.top,37)
    }
}

struct ButtonPrimary : View {
    var title : String
    var onClick : (() -> Void)
    
    var body : some View {
        Button { 
            onClick()
        } label : {
            Text(title)
                .font(.system(size: 20,weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 150, height: 44)
                .background(Color.init(hex: "50575C"))
                .cornerRadius(10)
        }
    }
}

struct TextFieldPrimary: View {
    
    var placeholderText : String
    
    var body: some View {
        TextField(placeholderText, text: .constant(""))
            .font(.system(size: 15))
            .padding(10)
            .background(.white)
            .cornerRadius(10)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
            
    }
}
