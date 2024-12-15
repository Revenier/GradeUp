//
//  ButtonPrimary.swift
//  GradeUp
//
//  Created by prk on 06/12/24.
//

import SwiftUI

struct SubjectPrimary : View {
    var backgroundColor : Color
    var subjectTitle : String
    var subjectLogo : Image!
    var subjectIndex: String
    @Binding var remainingTime: String
    @Binding var navigationPath : NavigationPath
    var body : some View {
        ZStack{
            Rectangle().fill(backgroundColor).frame(width: 96, height: 126)
                .clipShape(
                    .rect(
                        topLeadingRadius: 5,bottomLeadingRadius: 20, bottomTrailingRadius: 5,topTrailingRadius: 20
                    )
                ).shadow(color: .black.opacity(0.25),radius: 4,x:0,y:4)
            VStack{
                subjectLogo.resizable().scaledToFit().frame(width: 46,height: 46).padding(7)
                Text(subjectTitle).font(.system(size: 10,weight: .bold)).padding(.bottom,1)
                
                StartButtonPrimary(onClick: {
                    
                    if(remainingTime == "0d 0h 0m 0s"){
                        //                    button to subscription page
                        navigationPath.append("Subscription")
                    }else{
                        navigationPath.append("Subject \(subjectIndex)")
                    }
                    
                }).scaledToFit().frame(width: 96).padding(5)
                
            }

        }
    }
}

#Preview {
    SubjectPrimary(backgroundColor: Color.bluePastel, subjectTitle: "Physics", subjectLogo: Image("Physics"), subjectIndex: "0", remainingTime: .constant(""),navigationPath: .constant(NavigationPath()))
}
