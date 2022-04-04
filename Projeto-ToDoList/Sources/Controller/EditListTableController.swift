//
//  EditListTableController.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 03/04/22.
//

import UIKit
import FSCalendar

class EditListTableController: UITableViewController {

    private var hour: String = ""
    private var date: String = ""
    public var task: Task?
    
    @IBOutlet weak var textTitleTask: UITextField!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var timeSelected: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        configView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TimePickerController {
            controller.delegate = self
        }
    }
    
    // MARK: - Table view data source
    @IBAction func createTask(_ sender: Any) {
        self.createTask()
    }
    
    @IBAction func deleteTask(_ sender: Any) {
        TaskDefaultHelper().deleteTask(task: self.task!)
        dismiss(animated: true)
    }
    
    @IBAction func openComponent(_ sender: Any) {
        performSegue(withIdentifier: "segueComponent", sender: nil)
    }
    
    @IBAction func backView(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configView() {
        self.btnRemove.isHidden = self.task == nil
        guard let taskAux = self.task else {return}
        self.timeSelected.setTitle(taskAux.time, for: .normal)
        self.textTitleTask.text = taskAux.title
        self.date = taskAux.date
        self.hour = taskAux.time
    }
    
    private func createTask() {
        if self.task != nil {
            self.task!.date = self.date
            self.task!.time = self.hour
            self.task!.title = self.textTitleTask.text!
            
            TaskDefaultHelper().updateTask(task: self.task!)
        } else {
            var list: [Task] = TaskDefaultHelper().getListTask()
            let task: Task = Task(id: TaskDefaultHelper().getNextID(), title: self.textTitleTask.text ?? "", time: self.hour, date: self.date)
            list.append(task)
            TaskDefaultHelper().saveListTask(list: list)
        }        
        self.dismiss(animated: true)
    }
    
}
extension EditListTableController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.date == dateAux {
                return .green
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.date == dateAux {
                return .black
            }
        }
        return nil
    }
}

extension EditListTableController: TimePickerProtocol {
    func sendTime(_ time: String) {
        self.timeSelected.setTitle(time, for: .normal)
        self.hour = time
    }
}

extension EditListTableController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
