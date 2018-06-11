//
//  ViewController.swift
//  MarkPredictor
//
//  Created by Елена Яновская on 28.04.2018.
//  Copyright © 2018 Elena Yanovskaya. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Оценка за экзамен"
        static let visitLabel = "Процент посещенных занятий"
        static let testLabel = "Оценка за контрольную работу"
        static let homeworkLabel = "Оценка за домашнюю работу"
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet private var visitLabel: UILabel!
    @IBOutlet private var homeworkLabel: UILabel!
    @IBOutlet private var testLabel: UILabel!
    
    @IBOutlet private var visitSlider: CustomSlider!
    @IBOutlet private var homeworkSlider: CustomSlider!
    @IBOutlet private var testSlider: CustomSlider!
    
    @IBOutlet private var examLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let modelWrapper = MarkModelWrapper()
    private let notificationCenter = NotificationCenter.default
    
    private var visits: Int = {
        let visits = UserDefaults.standard.integer(forKey: UserDefaultsKeys.visits)
        return visits > 0 ? visits : 50
    }()
    
    private var homework: Int = {
        let homework = UserDefaults.standard.integer(forKey: UserDefaultsKeys.homework)
        return homework > 0 ? homework : 5
    }()
    
    private var test: Int = {
        let test = UserDefaults.standard.integer(forKey: UserDefaultsKeys.test)
        return test > 0 ? test : 5
    }()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNotification()
        configureNavigationBar()
        configureLabels()
        configureVisitSlider()
        configureTestSlider()
        configureHomeworkSlider()
    }
    
    // MARK: - Private Methods
    
    private func configureNotification() {
        notificationCenter.addObserver(self, selector: #selector(appDidEnterBackground), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
    }
    
    private func configureNavigationBar() {
        title = Constants.title
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = .white
    }
    
    private func configureLabels() {
        visitLabel.textColor = UIColor.darkText
        visitLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        visitLabel.text = Constants.visitLabel
        
        homeworkLabel.textColor = UIColor.darkText
        homeworkLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        homeworkLabel.text = Constants.homeworkLabel
        
        testLabel.textColor = UIColor.darkText
        testLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        testLabel.text = Constants.testLabel
        
        examLabel.textColor = UIColor.darkText
        examLabel.font = UIFont.systemFont(ofSize: 100, weight: .regular)
        examLabel.text = String(modelWrapper.predictMark(visits: visits, homework: homework, test: test))
    }
    
    private func configureVisitSlider() {
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        visitSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 3
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 100) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        visitSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0%", attributes: labelTextAttributes))
        visitSlider.setMaximumLabelAttributedText(NSAttributedString(string: "100%", attributes: labelTextAttributes))
        visitSlider.initialConfigure()
        visitSlider.fraction = CGFloat(visits) / 100
        visitSlider.contentViewColor = PaletteColors.blue
        visitSlider.observeTracking(label: visitLabel)
        visitSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func configureHomeworkSlider() {
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        homeworkSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        homeworkSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        homeworkSlider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
        homeworkSlider.initialConfigure()
        homeworkSlider.fraction = CGFloat(homework) / 10
        homeworkSlider.contentViewColor = PaletteColors.green
        homeworkSlider.observeTracking(label: homeworkLabel)
        homeworkSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    private func configureTestSlider() {
        let labelTextAttributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.white]
        testSlider.attributedTextForFraction = { fraction in
            let formatter = NumberFormatter()
            formatter.maximumIntegerDigits = 2
            formatter.maximumFractionDigits = 0
            let string = formatter.string(from: (fraction * 10) as NSNumber) ?? ""
            return NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .bold), .foregroundColor: UIColor.black])
        }
        testSlider.setMinimumLabelAttributedText(NSAttributedString(string: "0", attributes: labelTextAttributes))
        testSlider.setMaximumLabelAttributedText(NSAttributedString(string: "10", attributes: labelTextAttributes))
        testSlider.initialConfigure()
        testSlider.fraction = CGFloat(test) / 10
        testSlider.contentViewColor = PaletteColors.teal
        testSlider.observeTracking(label: testLabel)
        testSlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }
    
    @objc private func sliderValueChanged() {
        visits = Int(visitSlider.fraction * 100 + 0.5)
        homework = Int(homeworkSlider.fraction * 10 + 0.5)
        test = Int(testSlider.fraction * 10 + 0.5)
        examLabel.text = String(modelWrapper.predictMark(visits: visits, homework: homework, test: test))
    }
    
    @objc private func appDidEnterBackground() {
        UserDefaults.standard.set(visits, forKey: UserDefaultsKeys.visits)
        UserDefaults.standard.set(homework, forKey: UserDefaultsKeys.homework)
        UserDefaults.standard.set(test, forKey: UserDefaultsKeys.test)
    }
    
}
