//
//  HomePageView.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct HomePageView: View {
    
    @State private var isUserOnGoingJourney = false;
    
    var body: some View {
        NavigationView{
            ZStack {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                VStack(spacing : 0 ) {
                    
                    homeHeader()
                    
                    userLastJourney(isUserOnGoingJourney: $isUserOnGoingJourney)
                    
                    Text("Categories")
                        .font(.system(size: 16))
                        .padding(.top,35)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                .frame(width: .infinity)
                .padding(.horizontal, 37)
            }
            
        }
        
    }
}

#Preview {
    HomePageView()
}

struct homeHeader : View {
    @State private var isProfile = false
    
    var body : some View {
        HStack {
            VStack(spacing: 0) {
                Text("Hi, Sarah")
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Text("Let's Start Learning")
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, maxHeight: 48, alignment: .leading)
            
            Button(action: {
                isProfile.toggle()
            }) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 57, height: 57)
                    .foregroundColor(.gray)
                    .padding(.vertical,32)
            }.frame(maxWidth: .infinity, alignment: .trailing)
            
            
            NavigationLink(destination: ProfilePageView().navigationBarBackButtonHidden(true), isActive: $isProfile){
                EmptyView()
            }
        }
    }
}

struct userLastJourney : View {
    @Binding var isUserOnGoingJourney: Bool
    
    var body : some View {
        VStack(spacing : 25){
            if (isUserOnGoingJourney) {
                Text("Continue your last journey")
                    .font(.system(size: 14))
                    .foregroundColor(Color(UIColor(named: "SecondaryTextColor")!))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 20)
                    .padding(.horizontal, 15)
                HStack(spacing : 35){
                    Image("PlaceholderSubject")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 46, height: 46)
                        .background(
                            RoundedRectangle(cornerRadius: 13)
                                .fill(Color(uiColor: UIColor(named: "LightGrey")!)).frame(width: 85 , height: 85)
                        )
                    
                    
                    VStack(spacing: 10){
                        Text("Physics - Nuclear Fusion")
                            .lineLimit(1)
                            .font(.system(size: 12))
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Text("Chapter 1")
                            .lineLimit(1)
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        ButtonSecondary(iconPos: .right, title: "Continue", onClick: {}, isEnabled: .constant(true), titleSize: 10, width: 102, height: 27)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal,35)
            }
            else {
                Text("Start Your learning\njourney by doing chapters")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .foregroundColor(Color(UIColor(named: "SecondaryTextColor")!))
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity , maxHeight: 163)
        .background {
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 10.0,
                bottomLeading: 10.0,
                bottomTrailing: 10.0,
                topTrailing: 50.0),
                                   style: .continuous)
            .foregroundStyle(.white)
            .shadow(color: .gray, radius: 2, x: 0, y: 4)
        }
    }
}



