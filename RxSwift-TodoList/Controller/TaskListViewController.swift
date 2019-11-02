//
//  TaskListViewController.swift
//  RxSwift-TodoList
//
//  Created by kawaharadai on 2019/10/30.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var segmentedControl: UISegmentedControl!

    private var disposeBag = DisposeBag()
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filterTasks = BehaviorRelay<[Task]>(value: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nc = segue.destination as? UINavigationController, let addTaskVC = nc.topViewController as? AddTaskViewController else {
            fatalError()
        }

        addTaskVC.taskSubjectObservable.subscribe(onNext: { [weak self] task in
            guard let self = self else { return }
            self.tasks.accept(self.tasks.value + [task])
            if let selectedPriority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex - 1) {
                self.filterTasks.accept(self.filterTask(by: selectedPriority, tasks: self.tasks.value))
            } else {
                // allのケース
                self.filterTasks.accept(self.tasks.value)
            }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }

    func filterTask(by selectedPriority: Priority, tasks: [Task]) -> [Task] {
        return tasks.filter { $0.priority == selectedPriority }
    }
}

extension TaskListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(filterTasks.value.count)
        return filterTasks.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
}
