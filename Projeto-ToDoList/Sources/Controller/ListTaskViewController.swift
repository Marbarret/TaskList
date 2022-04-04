//
//  ListTaskViewController.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 03/04/22.
//

import UIKit

class ListTaskViewController: UIViewController {

    // MARK: - Properties
    
    // MARK: - Outlets

    @IBOutlet weak var tableListTask: UITableView!
    @IBOutlet weak var btnNewTask: UIButton!
    
    private var list: [Task] = []
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        tableListTask.delegate = self
        tableListTask.dataSource = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadItens()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? EditListTableController {
            guard let task = sender as? Task else {return}
            controller.task = task
        }
    }
    
    // MARK: - Actions
    @IBAction func btnCreateTask(_ sender: Any) {
        self.callCreateNewTask(task: nil)
    }
    
    // MARK: - Methods
    private func registerNib() {
        tableListTask.register(UINib(nibName: ClearTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ClearTableViewCell.identifier)
    }
    
    private func loadItens() {
        self.list = TaskDefaultHelper().getListTask()
        self.tableListTask.reloadData()
    }
    
    private func callCreateNewTask(task: Task?) {
        self.performSegue(withIdentifier: "createNewTaskSegue", sender: task)
    }
}

// MARK: - Extensions
extension ListTaskViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count > 0 ? self.list.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.list.count > 0 {
            let cell: TaskTableCell = tableView.dequeueReusableCell(withIdentifier: "cellTask", for: indexPath) as! TaskTableCell
            let task: Task = self.list[indexPath.row]
            cell.setTitle(title: task.title)
            cell.setDate(date: task.date)
            cell.setHour(hour: task.time)
            return cell
        } else {
            let cell: ClearTableViewCell = tableView.dequeueReusableCell(withIdentifier: ClearTableViewCell.identifier, for: indexPath) as! ClearTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return list.count > 0 ? 75 : 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.list.count > 0 {
            self.callCreateNewTask(task: self.list[indexPath.row])
        } else {
            self.callCreateNewTask(task: nil)
        }
    }
}
