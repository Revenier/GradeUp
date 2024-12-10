//
//  SubjectPageView.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import SwiftUI


struct SubjectPageView: View {
    var body: some View {
        NavigationView{
            ZStack(alignment:.top) {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                VStack() {
                    
                    Text(subjectsTemp[0].name)
                        .font(.system(size: 18,weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(0..<subjectsTemp[0].chapters.count){index in
                                LessonLayoutPrimary(backgroundColor: chapterColor[index%5], lessonTitle: subjectsTemp[0].chapters[index].name, questionCount: subjectsTemp[0].chapters[index].questions.count, subjectLogo: Image(subjectsTemp[0].name), isCompleted: .constant(true))
                            }
                        }
                    }
                    
                    
                }
                
                .frame(width: .infinity)
                .padding(37)
            }
            
        }
    }
}

#Preview {
    SubjectPageView()
}
