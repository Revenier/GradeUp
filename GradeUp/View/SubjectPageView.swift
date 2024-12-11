//
//  SubjectPageView.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI


struct SubjectPageView: View {
    @Binding var navigationPath: NavigationPath
    var subjectIndex: Int
    var body: some View {
        NavigationView{
            ZStack(alignment:.top) {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                
                VStack() {
                    HeaderPrimary(title: subjectsTemp[subjectIndex].name, onBackBtnClick: {navigationPath.removeLast(1)}, offSet: -5)
       
                    
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(0..<subjectsTemp[subjectIndex].chapters.count){index in
                                LessonLayoutPrimary(navigationPath: $navigationPath, backgroundColor: chapterColor[index%5], lessonTitle: subjectsTemp[subjectIndex].chapters[index].name, questionCount: subjectsTemp[subjectIndex].chapters[index].questions.count, subjectLogo: Image(subjectsTemp[subjectIndex].name), chapterIndex: index, subjectIndex: subjectIndex, isCompleted: .constant(true))
                            }
                        }
                    }.padding(.bottom, 50)
                    
                    
                }
                
                .frame(width: .infinity)
                .padding(.horizontal,37)
            }
            
        }
    }
}

#Preview {
    SubjectPageView(navigationPath: .constant(NavigationPath()),subjectIndex: 1)
}
