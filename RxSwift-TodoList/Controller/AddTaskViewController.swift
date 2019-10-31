//
//  AddTaskViewController.swift
//  RxSwift-TodoList
//
//  Created by kawaharadai on 2019/10/31.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak private var segmentedControl: UISegmentedControl!
    @IBOutlet weak private var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func save(_ sender: UIButton) {
        guard let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex),
            let title = textField.text else {
                return
        }

        let task = Task(title: title, priority: priority)
    }
}
