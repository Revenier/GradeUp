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
    
    var userGrade: String {
        UserDefaults.standard.string(forKey: "Grade") ?? ""
    }
    
    func fetchData(){
        fetchChaptersData(for: userGrade, subjectName: subjectsTemp[subjectIndex].name){ chapters in
            setChapter(chaptersData: chapters)
                
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack(alignment:.top) {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                
                VStack() {
                    HeaderPrimary(title: subjectsTemp[subjectIndex].name, onBackBtnClick: {navigationPath.removeLast(1)}, offSet: -5)
       
                    
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(0..<subjectsTemp[subjectIndex].chapters.count){index in
                                LessonLayoutPrimary(navigationPath: $navigationPath, backgroundColor: chapterColor[index%5], lessonTitle: subjectsTemp[subjectIndex].chapters[index].name, questionCount: subjectsTemp[subjectIndex].chapters[index].questions.count, subjectLogo: Image(subjectsTemp[subjectIndex].name), chapterIndex: index, subjectIndex: subjectIndex)
                            }
                        }
                    }.padding(.bottom, 50)
                                        
                }
                
                .frame(width: .infinity)
                .padding(.horizontal,37)
                .onAppear(){
                    
                    fetchData()
                }
            }
            
        }
    }
}

#Preview {
    SubjectPageView(navigationPath: .constant(NavigationPath()),subjectIndex: 1)
}
