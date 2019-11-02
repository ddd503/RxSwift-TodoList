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

        // 遷移先のsaveアクションを購読して下記を実行
        addTaskVC.taskSubjectObservable.subscribe(onNext: { [weak self] task in
            guard let self = self else { return }
            self.tasks.accept(self.tasks.value + [task])
            let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex - 1)
            self.filterTasks(by: priority, tasks: self.tasks.value)
            self.updateTableView()
        }).disposed(by: disposeBag)
    }

    @IBAction func priorityValueChanged(_ sender: UISegmentedControl) {
        // allならPriorityはnilになる
        let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
        filterTasks(by: priority, tasks: tasks.value)
        updateTableView()
    }

    /// 渡したプライオリティーでタスクをフィルタリングする
    /// - Parameter selectedPriority: Priority, nilならAll
    /// - Parameter tasks: 保持しているタスク配列
    func filterTasks(by selectedPriority: Priority?, tasks: [Task]) {
        if let selectedPriority = selectedPriority {
            let filterTasks = tasks.filter { $0.priority == selectedPriority }
            self.filterTasks.accept(filterTasks)
        } else {
            // allのケース
            self.filterTasks.accept(self.tasks.value)
        }
    }

    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TaskListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterTasks.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filterTasks.value[indexPath.row].title
        return cell
    }
}
