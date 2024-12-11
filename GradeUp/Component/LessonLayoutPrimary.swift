//
//  LessonLayoutPrimary.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI

struct LessonLayoutPrimary : View {
    @Binding var navigationPath: NavigationPath
    var backgroundColor : Color
    var lessonTitle : String
    var questionCount: Int
    var subjectLogo : Image!
    var chapterIndex : Int
    var subjectIndex : Int
    @Binding var isCompleted : Bool
    var body : some View {
        ZStack(alignment: .leading){
            Rectangle().fill(backgroundColor).frame(width: 346, height: 83)
                .clipShape(
                    RoundedRectangle(cornerRadius: 10)
                ).shadow(color: .black.opacity(0.25),radius: 4,x:0,y:4)
                
            HStack{
                subjectLogo.resizable().scaledToFit().frame(width: 46,height: 46).padding(20)
                VStack(alignment: .leading){
                    Text(lessonTitle).font(.system(size: 14,weight: .bold)).foregroundStyle(Color.primaryText)
                    Text("\(questionCount) Questions").font(.system(size: 10)).foregroundStyle(Color.primaryText).padding(.top,0.9)
                    Text(isCompleted ? "Completed" : "Not Complete").font(.system(size:8)).foregroundStyle(isCompleted ? Color.primaryText : Color.primaryText.opacity(0.5)).padding(.top,0.7)
                }
                .padding(.trailing, 20)
                
                StartLessonButtonPrimary(onClick: {navigationPath.append("Chapter \(subjectIndex) \(chapterIndex)")}).scaledToFit().frame(width: 96).padding(5)
                    .padding(.trailing, 20)
            }
            

        }
    }
}

#Preview {
    LessonLayoutPrimary(navigationPath: .constant(NavigationPath()), backgroundColor: Color.bluePastel, lessonTitle: "Nuclear Fussion", questionCount: 5, subjectLogo: Image("Physics"), chapterIndex: 0,subjectIndex: 0,isCompleted: .constant(true))
}
