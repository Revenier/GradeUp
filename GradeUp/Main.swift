//
//  Main.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct Main: View {
    @State var isUserSignUp : Bool = false
    @State var isLoginSuccess : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                CircleBackground(isRegister: $isUserSignUp)
                
                VStack {
                    
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 164, height: 164)
                        .padding(.vertical,32)
                       
                    Picker(selection: $isUserSignUp, label: Text("Picker")) {
                        Text("SIGN IN").tag(false)
                        Text("SIGN UP").tag(true)
                    }
                        .pickerStyle(SegmentedPickerStyle())
                    
                    if isUserSignUp {
                        SignUpView(isUserRegisComplete: $isUserSignUp)
                    }
                    else {
                        SignInView(isLoginSuccess: $isLoginSuccess)
                    }
                    
                    NavigationLink(destination: HomePageView().navigationBarBackButtonHidden(true), isActive: $isLoginSuccess){
                        EmptyView()
                    }
                    
                    Spacer()
                 
                }.padding(.horizontal,46)
                
            }
        }
    }
}

struct CircleBackground: View {
    @Binding var isRegister : Bool
    var body: some View {
        ForEach(0..<3){index in
            Circle()
                .fill(RadialGradient(gradient: Gradient(colors: [Color(UIColor(named: isRegister ? "PinkPastel" : "BluePastel")!)
                .opacity(0.25),Color(hex: "73B7EF").opacity(0)]), center: .center, startRadius: 25, endRadius: 100))
                .frame(width: 400,height: 400)
                .position(x: CGFloat.random(in: 0...400), y: CGFloat.random(in: 0...800))
        }
    }
}

#Preview {
    Main()
}
