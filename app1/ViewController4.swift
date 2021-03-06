//
//  ViewController4.swift
//  app1
//
//  Created by Promptnow on 8/1/2562 BE.
//  Copyright © 2562 Promptnow. All rights reserved.
//

import UIKit
import  Firebase
import FirebaseFirestore

class Tab4Data {
    var title: String = ""
    var age: String = ""
    var dept: String = ""
    
    var isExpand: Bool = false
    
    init(title: String, age: String, dept: String, isExpand: Bool) {
        self.title = title
        self.age = age
        self.dept = dept
        self.isExpand = isExpand
    }
}

class ViewController4: UIViewController, DidTapHeader {

    @IBOutlet weak var tableView: UITableView!
    
    var defaultStore : Firestore?
    var location : [DocumentSnapshot] = []
    
    var data:[Tab4Data] = [Tab4Data]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.readData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "4"
    }
    
    func readData() {
        defaultStore = Firestore.firestore()
        defaultStore?.collection("Promptnow").getDocuments { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in snapshot!.documents {
                //    let docId = document.documentID
                    let name = document.get("name") as! String
                    let age = document.get("age") as! String
                    let dept = document.get("dept") as! String
                    print(name, age, dept)
                    let tempData = Tab4Data(title: name, age: age, dept: dept, isExpand: false)
                    self.data.append(tempData)
                }
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    func delegateDidTapHeader(index: Int) {
        self.data[index].isExpand = !self.data[index].isExpand
        self.tableView.reloadData()
    }
}
    
extension ViewController4: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.data[section].isExpand {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = self.data[indexPath.section].age
        }else {
            cell.textLabel?.text = self.data[indexPath.section].dept
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderCell
        headerView.label.text = self.data[section].title
    //    headerView.backgroundColor = .red
        headerView.backgroundColor = UIColor(red: 123, green: 122, blue: 0, alpha: 0.7)
        headerView.delegate = self
        headerView.index = section
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    


