//
//  QuestionPageView.swift
//  GradeUp
//
//  Created by prk on 10/12/24.
//

//import SwiftUI
//
//struct QuestionPageView: View {
//    @State private var selectedQuestion: Int = 0
//    @Binding var navigationPath : NavigationPath
//    @Binding var chapterSelected : Chapter
//    var subjectIndex: Int
//    @State private var selectedOption: Int = -1
//    
//    @State private var isFinishAlert = false;
//    
//    var userGrade: String {
//        UserDefaults.standard.string(forKey: "Grade") ?? ""
//    }
//    
//    @State var numQuest: [Int] = []
//    @State var answer: [Int] = []
//    
//    func fetchData(){
//        fetchQuestiontsData(for: userGrade, subjectName: subjectsTemp[subjectIndex].name, chapterName: chapterSelected.name){ questions in
//            setQuestion(questionData: questions)
//            setOption(questionData: questions, questionNumber: chapterSelected.questions[selectedQuestion].number)
//        }
//    }
//
//    func saveAnswer(question: [Question], ans: Int){
//        for questionData in question{
//            numQuest.append(questionData.number)
//        }
////        answer[selectedQuestion] = ans
//        print(numQuest)
//        print(answer)
//        
//    }
//    var body: some View {
//        
//        ZStack(alignment: .top) {
//            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
//            VStack(alignment: .leading) {
//                HeaderPrimary(title: chapterSelected.name, onBackBtnClick: {navigationPath.removeLast(1)}, offSet: -5)
//                
//                VStack(alignment: .leading, spacing: 25){
//                    //Question Number Pick
//                    numbersScrollView(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion)
//                    //Question title
//                    Text("\(selectedQuestion + 1). \(chapterSelected.questions[selectedQuestion].question)").font(.system(size: 16))
//                }
//                //Answer options
//                answerOptions(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion, selectedOption: $selectedOption)
//                
//                //Buttons Footer
//                buttonFooter(chapterSelected: $chapterSelected,selectedQuestion: $selectedQuestion, isFinishAlert: $isFinishAlert)
//            }
//            .frame(width: .infinity, height: .infinity, alignment: .top)
//            .padding(.horizontal,37)
//            .onAppear(){
//                saveAnswer(question: chapterSelected.questions, ans: selectedOption)
//            }
//            
//            if isFinishAlert {
//                    // Background overlay
//                    Rectangle()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .background(Color.black)
//                        .opacity(0.35)
//                        .ignoresSafeArea()
//                        .onTapGesture {
//                            withAnimation {
//                                isFinishAlert.toggle()
//                            }
//                        }
//                    
//                    // Centered Alert VStack
//                VStack(alignment: .center, spacing: 10) {
//                        Text("Confirm finish?")
//                            .font(.title)
//                            .padding(.vertical,10)
//                        
//                        HStack {
//                            Button {
//                                // Cancel action
//                                isFinishAlert = false
//                            } label: {
//                                Text("Cancel")
//                                    .foregroundColor(.red)
//                                    .padding()
//                            }
//                            
//                            Button {
//                                // Finish action
//                                navigationPath.append("Score \(69)")
//                            } label: {
//                                Text("Finish")
//                                    .foregroundColor(.blue)
//                                    .padding()
//                            }
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                    .background(
//                        Color.white
//                            .cornerRadius(10)
//                    )
//                    .padding(.horizontal, 30)
//                    .padding(.vertical,15)
//                    .zIndex(2)
//                    .frame(maxWidth: 300, maxHeight: .infinity, alignment: .center) // Center this VStack
//                }
//            
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .onAppear(){
//            fetchData()
//        }
//        
//    }
//    
//}
//
//#Preview {
//    QuestionPageView(navigationPath: .constant(NavigationPath()),chapterSelected: .constant(subjectsTemp[0].chapters[1]), subjectIndex: 0)
//    
//}
//
//
//struct numbersScrollView : View{
//    @Binding var chapterSelected : Chapter
//    @Binding var selectedQuestion : Int
//    var body: some View{
//        
//        ScrollViewReader{scrollView in
//            ScrollView(.horizontal){
//                HStack(spacing: 10){
//                    ForEach(0..<chapterSelected.questions.count, id: \.self){index in
//                        NumberButtonPrimary(title: "\(index+1)", onClick: {
//                            selectedQuestion = index
//                        }, isSelected: .constant(index==selectedQuestion))
//                    }
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 3)
//                }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
//            }.onChange(of: selectedQuestion) { newIndex in
//                withAnimation {
//                    scrollView.scrollTo(newIndex, anchor: .center)
//                }
//            }
//        }
//    }
//}
//
//struct answerOptions : View{
//    @Binding var chapterSelected : Chapter
//    @Binding var selectedQuestion : Int
//    @Binding var selectedOption : Int
//    var clickState = false
//    var body: some View{
//        VStack(alignment: .leading, spacing: 0){
//            ForEach(0..<chapterSelected.questions[selectedQuestion].options.count){index in
//                AnswerButtonPrimary(choice: chapterSelected.questions[selectedQuestion].options[index], onClick: {selectedOption = index},isSelected: .constant(selectedOption == index))
//            }
//        }.frame(height: 300)
//    }
//}
//
//struct buttonFooter : View{
//    @Binding var chapterSelected : Chapter
//    @Binding var selectedQuestion: Int
//    @Binding var isFinishAlert : Bool
//    
//    var nextTitle : String{
//        selectedQuestion == chapterSelected.questions.count - 1 ? "Finish" : "Next"
//    }
//    var body: some View{
//        HStack(){
//            ButtonSecondary(iconPos: .left, title: "Prev", onClick: {selectedQuestion-=1}, isEnabled: .constant(selectedQuestion != 0), titleSize: 10, width: 91, height: 27)
//            Spacer()
//            ButtonSecondary(iconPos: .right, title: nextTitle, onClick: {nextQuestion()}, isEnabled: .constant(true), titleSize: 10, width: 91, height: 27)
//        }
//    }
//    func prevQuestion(){
//        if(selectedQuestion != 0){
//            selectedQuestion -= 1
//        }
//    }
//    func nextQuestion(){
//        if(selectedQuestion != chapterSelected.questions.count-1){
//            selectedQuestion += 1
//        }
//        else{
//            withAnimation {
//                isFinishAlert = true
//            }
//        }
//    }
//}


// ------------------- udh jalan --------------------------

// Q = [9,4,2,3,4,5,6,1,0] --> hasil generate baru

// QuestionTemp[ Q[selectedQuestion] ].number --> id

// Q[1] = 9
// QuestionTemp[9].number


import SwiftUI

struct QuestionPageView: View {
    @State private var selectedQuestion: Int = 0
    @Binding var navigationPath: NavigationPath
    @Binding var chapterSelected: Chapter
    var subjectIndex: Int
    @State private var selectedOptions: [Int: Int] = [:]
    @State private var isFinishAlert = false
    
    var userGrade: String {
        UserDefaults.standard.string(forKey: "Grade") ?? ""
    }

    func fetchData() {
        fetchQuestiontsData(for: userGrade, subjectName: subjectsTemp[subjectIndex].name, chapterName: chapterSelected.name) { questions in
            setQuestion(questionData: questions)
            setOption(questionData: questions, questionNumber: chapterSelected.questions[selectedQuestion].number)
        }
    }
    
    func countScore() -> Int {
        var score = 0
        for (index, userAnswer) in selectedOptions {
            print("Question Number : \(index), answer : \(userAnswer), Key : \(chapterSelected.questions[index].answer), \(selectedOptions)")
            if index < chapterSelected.questions.count,
               userAnswer == chapterSelected.questions[index].answer {
                score += 1
            }
        }
        print("score \(score)")
        return score*10
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor(named: "BackgroundColor")!).ignoresSafeArea()
            VStack(alignment: .leading) {
                HeaderPrimary(title: chapterSelected.name, onBackBtnClick: { navigationPath.removeLast(1) }, offSet: -5)

                VStack(alignment: .leading, spacing: 25) {
                    // Question Number Picker
                    numbersScrollView(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion)
                    // Question Title
                    Text("\(selectedQuestion + 1). \(chapterSelected.questions[selectedQuestion].question)")
                        .font(.system(size: 16))
                        .accessibilityLabel("Question \(selectedQuestion + 1)")
                }

                // Answer Options
                answerOptions(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion, selectedOptions: $selectedOptions)

                // Footer Buttons
                buttonFooter(chapterSelected: $chapterSelected, selectedQuestion: $selectedQuestion, isFinishAlert: $isFinishAlert)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 37)
            .onAppear {
                fetchData()
            }

            if isFinishAlert {
                    // Background overlay
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .opacity(0.35)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                isFinishAlert.toggle()
                            }
                        }
                    
                    // Centered Alert VStack
                VStack(alignment: .center, spacing: 10) {
                        Text("Confirm finish?")
                            .font(.title)
                            .padding(.vertical,10)
                        
                        HStack {
                            Button {
                                // Cancel action
                                isFinishAlert = false
                            } label: {
                                Text("Cancel")
                                    .foregroundColor(.red)
                                    .padding()
                            }
                            
                            Button {
                                // Finish action
                                navigationPath.append("Score \(countScore())")
                            } label: {
                                Text("Finish")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(
                        Color.white
                            .cornerRadius(10)
                    )
                    .padding(.horizontal, 30)
                    .padding(.vertical,15)
                    .zIndex(2)
                    .frame(maxWidth: 300, maxHeight: .infinity, alignment: .center) // Center this VStack
                }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear(){
            fetchData()
        }
        
    }
    
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

struct answerOptions: View {
    @Binding var chapterSelected: Chapter
    @Binding var selectedQuestion: Int
    @Binding var selectedOptions: [Int: Int]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(0..<chapterSelected.questions[selectedQuestion].options.count, id: \.self) { index in
                AnswerButtonPrimary(
                    choice: chapterSelected.questions[selectedQuestion].options[index],
                    onClick: {
                        selectedOptions[selectedQuestion] = index
                    },
                    isSelected: .constant(selectedOptions[selectedQuestion] == index)
                )
            }
        }
        .frame(maxHeight: 300)
        .accessibilityElement()
    }
}

struct buttonFooter : View{
    @Binding var chapterSelected : Chapter
    @Binding var selectedQuestion: Int
    @Binding var isFinishAlert : Bool

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
            withAnimation {
                isFinishAlert = true
            }
        }
    }
}

// -------------------yang baru--------------------------


