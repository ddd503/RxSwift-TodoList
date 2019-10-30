//
//  TaskListViewController.swift
//  RxSwift-TodoList
//
//  Created by kawaharadai on 2019/10/30.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension TaskListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
