import CreateML
import Foundation

// Specify Data
let trainingCSV = URL(fileURLWithPath: "/Users/Shared/Marks-Dataset.csv")

let marksData = try MLDataTable(contentsOf: trainingCSV)

// Create Model
let examMark = try MLRegressor(trainingData: marksData, targetColumn: "Exam")

// Save Model
let modelInfo = MLModelMetadata(author: "Elena Yanovskaya", shortDescription: "Predicts the exam mark", license: nil, version: "2.0", additional: nil)
try examMark.write(to: URL(fileURLWithPath: "/Users/Shared/MarkModel.mlmodel"), metadata: modelInfo)
