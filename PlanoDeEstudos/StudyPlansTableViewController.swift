//
//  NotificationsTableViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2020 Eric Brito. All rights reserved.
//

import UIKit

final class StudyPlansTableViewController: UITableViewController {

    // MARK: - Properties
    var studyManager = StudyManager.shared
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        return dateFormatter
    }()
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onConfirmed(notification:)), name: NSNotification.Name("confirmed"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Methods
    @objc func onConfirmed(notification: Notification) {
        if let userInfo = notification.userInfo,
           let id = userInfo["id"] as? String {
           
            studyManager.setPlanDone(id: id)
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studyManager.studyPlans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let studyPlan = studyManager.studyPlans[indexPath.row]
        cell.textLabel?.text = studyPlan.section
        cell.detailTextLabel?.text = dateFormatter.string(from: studyPlan.date)
        cell.backgroundColor = studyPlan.done ? .systemGreen : .white
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            studyManager.removePlan(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
}
