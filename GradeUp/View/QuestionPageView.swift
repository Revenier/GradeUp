//
//  QuestionPageView.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

import SwiftUI

struct QuestionPageView: View {
    @State private var selectedQuestion: Int = 0
    var chapterSelected : Chapter
    var body: some View {
        NavigationView{
            ZStack(alignment:.top) {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                VStack() {
                    Text(chapterSelected.name)
                        .font(.system(size: 18,weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    
                    VStack(alignment: .leading, spacing: 25){
                        //Question Number Pick
                        HStack(spacing: 10){
                            ForEach(0..<chapterSelected.questions.count){index in
                                NumberButtonPrimary(title: "\(index+1)", onClick: {
                                    selectedQuestion = index
                                }, isSelected: .constant(index==selectedQuestion))
                            }
                        }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                        //Question title
                        Text("\(selectedQuestion + 1). \(chapterSelected.questions[selectedQuestion].question)").font(.system(size: 16))
                    }
                    //Answer options
                    VStack(alignment: .leading, spacing: 25){
                        ForEach(0..<chapterSelected.questions[selectedQuestion].options.count){index in
                            AnswerButtonPrimary(choice: chapterSelected.questions[selectedQuestion].options[index], onClick: {})
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
    QuestionPageView(chapterSelected: subjectsTemp[0].chapters[1])
}
