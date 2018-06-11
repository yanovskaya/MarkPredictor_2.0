//
//  MarkModelWrapper.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 01.05.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import CoreML
import Foundation

final class MarkModelWrapper {
    
    private let model = MarkModel()
    
    func predictMark(visits: Int, homework: Int, test: Int) -> Int {
        do {
            let visitsInput = Double(visits)
            let homeworkInput = Double(homework)
            let testInput = Double(test)
            
            let input = MarkModelInput(Visits: visitsInput,
                                       Test: testInput,
                                       Homework: homeworkInput)
            let markModelOutput = try model.prediction(input: input)
            
            return Int(markModelOutput.Exam + 0.5)
        } catch {
            return 0
        }
    }
}
