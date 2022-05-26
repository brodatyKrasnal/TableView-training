//
//  by: Tymek (iTmi) on: 20/05/2022 | ViewController.swift : TableView training
// Copyright (c) 2022, all rights reserved. UIID: 7D24D296-97AF-4C04-8E52-33145EA997F5

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayTable: UITableView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var datePickerElement: UIDatePicker!
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("TableViewTraining.plist")
    var listOfMemos = [Memo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        displayTable.dataSource = self
        displayTable.delegate = self
        displayTable.register(UINib(nibName: "ReusableCell", bundle: .none), forCellReuseIdentifier: "ReusableCell")
        
        readSavedData()
        
    }
    
    @IBAction func AddItemPressed(_ sender: UIButton) {
        if itemTextField.text != "" {
            listOfMemos.insert(Memo(itemName:  itemTextField.text!, itemContent: nil, itemCompleted: false, itemDueDate: datePickerElement.date), at: 0)
            saveData()
            displayTable.reloadData()
            itemTextField.text = ""
        } else {
            itemTextField.placeholder = "Add your item first"
        }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMemos.count
    }
    // TODO: - fix the issue with disappearing content note
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = displayTable.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! ReusableCell
        let memo =  listOfMemos[indexPath.row]
        cell.descriptionLablel.text = memo.itemName
        cell.dateLabel.text = memo.itemDueDate.formatted(date: .abbreviated, time: .shortened)
        cell.taskCompletionImage.image = memo.itemCompleted ? UIImage(systemName: "chevron.right.square.fill") : UIImage(systemName: "chevron.right.square")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listOfMemos[indexPath.row].itemCompleted = !listOfMemos[indexPath.row].itemCompleted
        if listOfMemos[indexPath.row].itemCompleted == true {
            listOfMemos.insert(listOfMemos[indexPath.row], at: listOfMemos.count)
            listOfMemos.remove(at: indexPath.row)
            saveData()
        } else {
            let index = indexPath.row
            listOfMemos.insert(listOfMemos[indexPath.row], at: 0)
            listOfMemos.remove(at: index + 1)
            saveData()
        }
        tableView.reloadData()
    }

}

// MARK: - Methods handling data persistance
extension ViewController {
    func saveData () {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.listOfMemos)
            try data.write(to: dataFilePath!)
        } catch {
            print(error)
        }
    }
    
    func readSavedData () {
        if let readData = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                listOfMemos = try decoder.decode([Memo].self, from: readData)
            } catch{
                print(error)
            }
        }
    }
}


