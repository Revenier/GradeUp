//
//  QuestionPageView.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

import SwiftUI

struct QuestionPageView: View {
    @State private var selectedQuestion: Int = 0
    @Binding var navigationPath : NavigationPath
    @Binding var chapterSelected : Chapter
    @State private var selectedOption: Int = -1
    var body: some View {
        NavigationView{
            ZStack(alignment:.top) {
                Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
                VStack() {
                    HeaderPrimary(title: chapterSelected.name, onBackBtnClick: {navigationPath.removeLast(1)}, offSet: -5)
                    
                    VStack(alignment: .leading, spacing: 25){
                        //Question Number Pick
                        numbersScrollView(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion)
                        //Question title
                        Text("\(selectedQuestion + 1). \(chapterSelected.questions[selectedQuestion].question)").font(.system(size: 16))
                    }
                    //Answer options
                    answerOptions(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion, selectedOption: $selectedOption)
                    
                    //Buttons Footer
                    buttonFooter(chapterSelected: $chapterSelected,selectedQuestion: $selectedQuestion)
                }
                .frame(width: .infinity)
                .padding(.horizontal,37)
            }
            
        }
    }
}

#Preview {
    QuestionPageView(navigationPath: .constant(NavigationPath()),chapterSelected: .constant(subjectsTemp[0].chapters[1]))
}


struct numbersScrollView : View{
    @Binding var chapterSelected : Chapter
    @Binding var selectedQuestion : Int
    var body: some View{
        
        ScrollViewReader{scrollView in
            ScrollView(.horizontal){
                HStack(spacing: 10){
                    ForEach(0..<chapterSelected.questions.count, id: \.self){index in
                        NumberButtonPrimary(title: "\(index+1)", onClick: {
                            selectedQuestion = index
                        }, isSelected: .constant(index==selectedQuestion))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 3)
                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
            }.onChange(of: selectedQuestion) { newIndex in
                withAnimation {
                    scrollView.scrollTo(newIndex, anchor: .center)
                }
            }
        }
    }
}

struct answerOptions : View{
    @Binding var chapterSelected : Chapter
    @Binding var selectedQuestion : Int
    @Binding var selectedOption : Int
    var clickState = false
    var body: some View{
        VStack(alignment: .leading, spacing: 0){
            ForEach(0..<chapterSelected.questions[selectedQuestion].options.count){index in
                AnswerButtonPrimary(choice: chapterSelected.questions[selectedQuestion].options[index], onClick: {selectedOption = index},isSelected: .constant(selectedOption == index))
            }
        }.frame(height: 300)
    }
}

struct buttonFooter : View{
    @Binding var chapterSelected : Chapter
    @Binding var selectedQuestion: Int
    
    var nextTitle : String{
        selectedQuestion == chapterSelected.questions.count - 1 ? "Finish" : "Next"
    }
    var body: some View{
        HStack(){
            ButtonSecondary(iconPos: .left, title: "Prev", onClick: {selectedQuestion-=1}, isEnabled: .constant(selectedQuestion != 0), titleSize: 10, width: 91, height: 27)
            Spacer()
            ButtonSecondary(iconPos: .right, title: nextTitle, onClick: {nextQuestion()}, isEnabled: .constant(true), titleSize: 10, width: 91, height: 27)
        }
    }
    func prevQuestion(){
        if(selectedQuestion != 0){
            selectedQuestion -= 1
        }
    }
    func nextQuestion(){
        if(selectedQuestion != chapterSelected.questions.count-1){
            selectedQuestion += 1
        }
        else{
            
        }
    }
}
