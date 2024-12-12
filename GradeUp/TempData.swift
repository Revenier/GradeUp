//
//  TempData.swift
//  GradeUp
//
//  Created by prk on 12/10/24.
//

import Foundation
import SwiftUI
var optionsTemp : [String] = ["Cold", "Warm", "Hotter", "Cool"]
var questionsTemp : [Question] = [
    Question(number: 1, question: "What is the opposite of 'Hot'?", options: optionsTemp, answer: "Op1"),
    Question(number: 2, question: "What is the opposite of 'Cold'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guyawdaaaaaaaaaaaaaaaaaaaaa'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1"),
    Question(number: 3, question: "What is the opposite of 'Cool Guy'?", options: optionsTemp, answer: "Op1")
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
var subjectsTemp : [Subject] = [
    Subject(name: "Physics", chapters: chaptersTemp),
    Subject(name: "Mathematics", chapters: chaptersTemp),
    Subject(name: "Biology", chapters: chaptersTemp),
    Subject(name: "English", chapters: chaptersTemp)
]
var gradesTemp : [Grade] = [
    Grade(name: "Primary 1", subjects: subjectsTemp),
    Grade(name: "Primary 2", subjects: subjectsTemp),
    Grade(name: "Primary 3", subjects: subjectsTemp),
    Grade(name: "Primary 4", subjects: subjectsTemp),
    Grade(name: "Primary 5", subjects: subjectsTemp),
    Grade(name: "Primary 6", subjects: subjectsTemp)
]

var chapterColor: [Color] = [.babyRed, .babyPink,.babyOrange ,.babyBlue,.babyGreen]
var subjectColor: [Color] = [.orangePastel, .bluePastel, .greenPastel, .yellowPastel, .greyPastel, .pinkPastel, .brownPastel, .olivePastel, .purplePastel]

