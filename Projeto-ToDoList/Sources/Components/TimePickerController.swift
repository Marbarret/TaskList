//
//  TimePickerController.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 03/04/22.
//

import UIKit

protocol TimePickerProtocol {
    func sendTime (_ time: String)
}

class TimePickerController: UIViewController {

    // MARK: - Properties
    var delegate: TimePickerProtocol?
    
    // MARK: - Outlets
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Actions
    @IBAction func close(_ sender: UIButton) {
        if sender == btnOk {
            self.dismiss(animated: true) {
                guard let delegate = self.delegate else {return}
                let dateSelect: Date = self.datePicker.date
                let dateString = Date().convertDateToString(date: dateSelect, dateFormatter: "HH:mm")
                delegate.sendTime(dateString)
            }
        } else {
            self.dismiss(animated: true)
        }
    }
    // MARK: - Methods
    
    // MARK: - Extensions


}
