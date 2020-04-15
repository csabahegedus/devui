//
//  FAQ.swift
//  Devui
//
//  Created by Emilio Schepis on 15/04/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import Foundation

struct FAQ: Identifiable {
    
    let id: Int
    let questionKey: String
    let answerKey: String
    let relatedURL: URL?
    
    var question: String { NSLocalizedString(questionKey, comment: "") }
    var answer: String { NSLocalizedString(answerKey, comment: "") }
}

let allFAQs = [
    FAQ(id: 1, questionKey: "faq_question_1", answerKey: "faq_answer_1", relatedURL: nil),
    FAQ(id: 2, questionKey: "faq_question_2", answerKey: "faq_answer_2", relatedURL: nil),
    FAQ(id: 3, questionKey: "faq_question_3", answerKey: "faq_answer_3", relatedURL: URL(string: "https://github.com/emilioschepis/devui")),
]
