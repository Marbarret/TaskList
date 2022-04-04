//
//  TaskTableCell.swift
//  Projeto-ToDoList
//
//  Created by Marcylene Barreto on 03/04/22.
//

import UIKit

class TaskTableCell: UITableViewCell {

    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public func setTitle(title: String) {
        self.lblTitle.text = title
    }

    public func setDate(date: String) {
        self.lblData.text = date
    }
    
    public func setHour(hour: String) {
        self.lblHour.text = hour
    }
}
