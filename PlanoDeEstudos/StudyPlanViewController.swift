//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2020 Eric Brito. All rights reserved.

import UIKit

final class StudyPlanViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    // MARK: - Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IBActions
    @IBAction func schedule(_ sender: UIButton) {
    }
}
