//
//  SubscriptionPageView.swift
//  GradeUp
//
//  Created by Kalyana Mitta on 14/12/24.
//

import SwiftUI

struct SubscriptionPageView: View {
    @Binding var navigationPath : NavigationPath
    
    var userEmail: String {
        UserDefaults.standard.string(forKey: "userEmail") ?? ""
    }
    
    var body: some View {
        ZStack (alignment: .top){
            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
            VStack(spacing: 20) {
                HeaderPrimary(title: "Subscription", onBackBtnClick: {navigationPath.removeLast(1)}, offSet: -5)
                    .padding(.bottom,20)
                
                SubscriptionItem(title: "Free Trial", description: "Try for free to use GradeUp for 3 days", price: 0, onClick: {
                    addSubscription(email: userEmail, subscription: "Free Trial", days: 3) { error in
                        if let error = error {
                            print("Failed to add subscription: \(error.localizedDescription)")
                        } else {
                            print("Subscription added successfully!")
                            navigationPath.removeLast(1)
                        }
                    }
                    
                    
                        
                    
                })
                
                SubscriptionItem(title: "Monthly", description: "Get full access to use GradeUp for 30 days", price: 10000, onClick: {
                    addSubscription(email: userEmail, subscription: "Monthly", days: 30) { error in
                        if let error = error {
                            print("Failed to add subscription: \(error.localizedDescription)")
                        } else {
                            print("Subscription added successfully!")
                            navigationPath.removeLast(1)
                        }
                    }
                    

                })
                
                SubscriptionItem(title: "Yearly (Save up to 20%)", description: "Get full access to use GradeUp for 365 days", price: 100000, onClick: {
                    addSubscription(email: userEmail, subscription: "Yearly", days: 365) { error in
                        if let error = error {
                            print("Failed to add subscription: \(error.localizedDescription)")
                        } else {
                            print("Subscription added successfully!")
                            navigationPath.removeLast(1)
                        }
                    }

                })
                
            }.padding(.horizontal,37)
        }
    }
}


struct SubscriptionItem : View {
    var title : String
    var description : String
    var price : Int
    var onClick : (() -> Void)

    var body : some View {
        VStack(spacing : 25){

            Text(title)
                .lineLimit(1)
                .font(.system(size: 24))
                .bold()
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(.top,30)
                .padding(.horizontal, 20)
            
            Text(description)
                .font(.system(size: 14))
                .foregroundColor(Color(UIColor(named: "SecondaryTextColor")!))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            
            HStack(spacing: 0){
                
                
                Text("IDR. \(price)")
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .foregroundColor(Color(UIColor(named: "SecondaryTextColor")!))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ButtonSecondary(iconPos: .right, title: "Buy This", onClick: {
                    onClick()
                }, isEnabled: .constant(true), titleSize: 10, width: 102, height: 27)
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.trailing,30)
            .padding(.leading, 20)
            
            
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity , maxHeight: 163)
        .background {
            RoundedRectangle(cornerRadius: CGFloat(10))
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 4)
        }
    }
}

#Preview {
    SubscriptionPageView(navigationPath: .constant(NavigationPath()))
}
