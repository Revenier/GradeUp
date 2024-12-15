//
//  TempData.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import Foundation
import SwiftUI

var optionsTemp : [String] = [
    "Cold", "Warm", "Hotter", "Cool"
]




var questionsTemp : [Question] = [
    Question(number: 1, question: "What is the opposite of 'Hot'?", options: optionsTemp, answer: 1),
    Question(number: 2, question: "What is the opposite of 'Cold'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guyawdaaaaaaaaa'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: 1)
]

var subjectsTemp : [Subject] = [
    Subject(name: "Physics", chapters: chaptersTemp),
    Subject(name: "Mathematics", chapters: chaptersTemp),
    Subject(name: "Biology", chapters: chaptersTemp),
    Subject(name: "English", chapters: chaptersTemp),
]

var chaptersTemp : [Chapter] = [
    Chapter(name: "Basic English", questions: questionsTemp),
    Chapter(name: "Hard English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp),
    Chapter(name: "Horse English", questions: questionsTemp)
]

var gradesTemp : Grade = Grade(name: "Primary 1", subjects: subjectsTemp)

func setGrade(gradeData:Grade){
    gradesTemp = gradeData
    
}

// Set Data

func setOption(questionData: [Question], questionNumber:Int){
    optionsTemp.removeAll()
    for data in questionData {
        if(data.number == questionNumber){
            optionsTemp.append(contentsOf: data.options)
//                print("success add \(data)")
        }
    }
}

func setQuestion(questionData: [Question]){
    questionsTemp.removeAll()
    for data in questionData {
            questionsTemp.append(data)
        }
//    print("success questions \(chaptersTemp)")
//    print("success subject \(subjectsTemp)")
}

func setChapter(chaptersData: [Chapter]){
        chaptersTemp.removeAll()
        for data in chaptersData {
            chaptersTemp.append(data)
//            print("success add chapter \(data)")
//            print("success subjects \(subjectsTemp)")
        }
}

func setSubject(subjectsData: [Subject]){
    subjectsTemp.removeAll()
        for data in subjectsData {
            subjectsTemp.append(data)
        }
//    print(gradesTemp)
}

//var gradesTemp : [Grade] = [
//    Grade(name: "Primary 1", subjects: subjectsTemp),
//    Grade(name: "Primary 2", subjects: subjectsTemp),
//    Grade(name: "Primary 3", subjects: subjectsTemp),
//    Grade(name: "Primary 4", subjects: subjectsTemp),
//    Grade(name: "Primary 5", subjects: subjectsTemp),
//    Grade(name: "Primary 6", subjects: subjectsTemp)
//]



var chapterColor: [Color] = [.babyRed, .babyPink,.babyOrange ,.babyBlue,.babyGreen]
var subjectColor: [Color] = [.orangePastel, .bluePastel, .greenPastel, .yellowPastel, .greyPastel, .pinkPastel, .brownPastel, .olivePastel, .purplePastel]


func setData(subjectsData: [Subject], chaptersData: [Chapter], questionsData: [Question], optionsData: [String], gradesData: Grade) {
    subjectsTemp.removeAll()
    for data in subjectsData {
        let temp = Subject(name: data.name, chapters: data.chapters)
        subjectsTemp.append(temp)
        print("success add \(temp)")
    }
    
    chaptersTemp.removeAll()
    for data in chaptersData {
        chaptersTemp.append(data)
//        print("success add \(data)")
    }
    
    questionsTemp.removeAll()
    for data in questionsData {
        questionsTemp.append(data)

    }
    
    optionsTemp.removeAll()
    for data in optionsData {
        optionsTemp.append(data)
    }

    gradesTemp = gradesData
    print("Data has been successfully set.")
}


