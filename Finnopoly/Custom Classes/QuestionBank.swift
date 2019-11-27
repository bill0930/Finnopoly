//
//  QuestionBank.swift
//  Finnopoly
//
//  Created by IVAN CHUNG on 25/11/2019.
//  Copyright © 2019 Finnopoly. All rights reserved.
//

import Foundation
import SpriteKit

class QuestionBank{
    var CorrectAnswer = String()
    var questions = [String : [String]]()
    
    init() {
        setupQuestions()
    }
    
    func setupQuestions(){
        //Q1
        questions["What is the purpose of personal financial planning?"] = ["A. Diversifying sources of income from different financial institutions","false", "B. Providing employment opportunities for the society", "false", "C. Through appropriate consumption, investment and retirement planning to achieve personal financial goals", "correct", "D. Achieve sales targets for banks or investment funds, and help clients invest", "false"]
        
        //Q2
        questions["Which financial product is not suitable for long-term retirement savings?"] = ["A. Certificate of Deposit","false", "B. Emerging market stocks", "correct", "C. Exchange Fund Notes", "false", "D. Insurance plan with savings component", "false"]
        
        //Q3
        questions["Which statement about personal financial planning is correct?"] = ["A. In the process of personal financial planning, we ignore environmental factors&only consider our financial ability.","false", "B. The most important goal of financial planning is to earn the greatest return on investment.", "false", "C. We should set a timetable to ensure that the financial plan can be implemented smoothly.", "correct", "D. After we have established a financial plan, we cannot change it.", "false"]
        
        //Q4
        questions["According to the life cycle concept of financial planning, in which stage of life does a person have the strongest demand for insurance?"] = ["A. Young and unmarried","false", "B. Married with young children", "correct", "C. Retirement", "false ", "D. Divorced", "false"]
        
        //Q5
        questions["Hong Kong's Mandatory Provident Fund System"] = ["A. Help employees save medical expenses they need during their retirement.","false", "B. Ensure that individuals save regularly for retirement before retirement.", "correct", "C. Ensure that employees have enough money to live after retirement.", "false", "D. Allow employees to retire at any time if they have enough savings", "false"]
        
        //Q6
        questions["Which of the following is not an explanation for investment risk?"] = ["A. Loss beyond expectations","false", "B. Guarantee of return on investment", "correct", "C. Potential maximum loss", "false", "D. Differences in investment results", "false"]

        //Q7
        questions["Which one is true about the financial needs of college graduates who have just graduated?"] = ["A. They do not have the need for retirement planning.","false", "B. They do not need to buy insurance.", "false", "C. They are generally more aggressive investments than middle-aged people.", "correct", "D. They should only make long-term investments.", "false"]
        //Q8
        questions["Which of the following must contribute to the MPF scheme?"] = ["A. 38 years old and work for a billionaire with salary of 15000hkd","false", "B. 70 years old and being a waiter at restaurant with salary of 8000hkd", "false", "C. 20 years old and being office assistant with salary of 4200HKD", "false", "D. 35 years old and being temporary chef at a hotel with salary of 18,000 yuan for two months.", "correct"]
        
        //Q9
        questions["Which one is not the principle of preparing a financial budget?"] = ["A. The analysis must be forward-looking.","false", "B. The budget figures must be compared to actual results for evaluation.", "false", "C. Past figures are not useful for preparing future budgets.", "correct", "D. Information on the financial budget must be clearly expressed.", "false"]
        
        //Q10
        questions["Which of the following is not related to personal financial planning?"] = ["A. A housewife is considering purchasing an insurance plan to protect her family.","false", "B. A financial planner is planning to collect money from colleagues to purchase a lottery ticket.", "correct", "C. A young couple is considering an investment-linked insurance plan.", "false", "D. A family with newborn babies is comparing different bank referral loan plans.", "false"]
    }
    
    func RandomQuestions () -> (String, String, String, String, String, String, String, String, String){
        let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        let index = questions.index(questions.startIndex, offsetBy: randomIndex)
        let question = questions.keys[index]
        let answers = Array(questions.values[index])
        // options
        let option1 = answers[0]
        let option2 = answers[2]
        let option3 = answers[4]
        let option4 = answers[6]
        // correct/false
        let result1 = answers[1]
        let result2 = answers[3]
        let result3 = answers[5]
        let result4 = answers[7]
        return (question, option1, result1, option2, result2, option3, result3, option4, result4)
    }
}
