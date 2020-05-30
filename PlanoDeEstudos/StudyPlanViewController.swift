//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2020 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

final class StudyPlanViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    // MARK: - Properties
    let studyManager = StudyManager.shared
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
    }

    // MARK: - IBActions
    @IBAction func schedule(_ sender: UIButton) {
        let id = UUID().uuidString
        let studyPlan = StudyPlan(
            course: tfCourse.text!,
            section: tfSection.text!,
            date: dpDate.date,
            done: false,
            id: id)
        studyManager.addPlan(studyPlan)
        
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria: \(studyPlan.course)"
        content.body = "Hora de estudar \(studyPlan.section)"
        content.categoryIdentifier = "Lembrete"
        content.sound = UNNotificationSound(named: "sonic.mp3")
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: dpDate.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        navigationController?.popViewController(animated: true)
    }
}
