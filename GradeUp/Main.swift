//
//  Main.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI
import FirebaseCore

struct Main: View {
    
    init(){
        FirebaseApp.configure()
        print("Configured FIrebase!")
    }
    
    @State var isUserSignUp : Bool = false

    @State var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
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
                    
                    segmentedView(isUserSignUp: $isUserSignUp)
                    
                    if isUserSignUp {
                        SignUpView(isUserRegisComplete: $isUserSignUp)
                    }
                    else {
                        SignInView(navigationPath: $navigationPath)
                    }
            
                    Spacer()
                    
                }.padding(.horizontal,46)
                    .navigationDestination(for: String.self) { value in
                        if (value == "Home"){
                            HomePageView(navigationPath: $navigationPath).navigationBarBackButtonHidden(true)
                        }
                        else if (value == "Profile"){
                            ProfilePageView(navigationPath: $navigationPath).navigationBarBackButtonHidden(true)
                        }
                        else if (value.hasPrefix("Subject")){
                            let valueArr = value.split(separator : " ")
                            let index = Int(valueArr.last!)
                            SubjectPageView(navigationPath:
                                                $navigationPath, subjectIndex: index!).navigationBarBackButtonHidden(true)
                        }
                        else if (value.hasPrefix("Chapter")){
                            let valueArr = value.split(separator : " ")
                            let subjectIndex = Int(valueArr[1])
                            let chapterIndex = Int(valueArr.last!)
                            
                            QuestionPageView(navigationPath:
                                                $navigationPath,chapterSelected: .constant(subjectsTemp[subjectIndex!].chapters[chapterIndex!]), subjectIndex:subjectIndex!).navigationBarBackButtonHidden(true)
                        }
                        else if (value.hasPrefix("Score")){
                            let valueArr = value.split(separator: " ")
                            let score = Int(valueArr[1])
                            
                            ScorePageView(score: score!, navigationPath: $navigationPath)
                                .navigationBarBackButtonHidden(true)
                        }
                        else if (value.hasPrefix("Subscription")){
                            SubscriptionPageView(navigationPath: $navigationPath)
                                .navigationBarBackButtonHidden(true)
                        }
                    }
                
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


struct segmentedView : View {
    @Binding var isUserSignUp : Bool
    
    var body : some View {
        VStack {
            
            HStack {
                Spacer()
                Button {
                    withAnimation{
                        isUserSignUp = false;
                    }
                } label: {
                    Text("SIGN IN")
                        .font(.system(size: 20, weight: isUserSignUp ? .regular : .semibold))
                        .frame(maxHeight: .infinity)
                        .foregroundColor(.black)
                }
                
                Spacer(minLength: 65)
                
                Button {
                    withAnimation{
                        isUserSignUp = true;
                    }
                } label : {
                    Text("SIGN UP")
                        .font(.system(size: 20, weight: isUserSignUp ? .semibold : .regular))
                        .frame(maxHeight: .infinity)
                        .foregroundColor(.black)
                }
                
                
                Spacer()
            }
            ZStack{
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.grey)
                        .frame(width: geometry.size.width, height: 2)
                        .cornerRadius(geometry.size.height/2)
                        .position(x: geometry.size.width/2, y: geometry.size.height/2)
                }
                GeometryReader { geometry in
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: geometry.size.width * 0.5, height: 4)
                        .cornerRadius(geometry.size.height/2)
                        .frame(maxWidth: geometry.size.width, alignment: isUserSignUp ? .trailing : .leading)
                }
            }
            .frame(maxHeight: 4, alignment: .center)
            .padding(.horizontal,20)
           
        }.frame(maxWidth: .infinity, maxHeight: 40)
    }
}
