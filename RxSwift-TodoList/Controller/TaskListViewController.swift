//
//  TaskListViewController.swift
//  RxSwift-TodoList
//
//  Created by kawaharadai on 2019/10/30.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
import RxSwift

class TaskListViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController, let addTaskVC = nc.topViewController as? AddTaskViewController else {
            fatalError()
        }

        addTaskVC.taskSubjectObservable.subscribe(onNext: { task in
            print(task)
        }).disposed(by: disposeBag)
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
