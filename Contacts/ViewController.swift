//
//  ViewController.swift
//  Contacts
//
//  Created by Евгений Бияк on 19.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var contacts: [ContactProtocol] = [] {
        didSet {
            contacts.sort{ $0.title < $1.title }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }
    
    
    // alert with fields for adding new contact in contacts
    @IBAction func showAddContactAlert() {
        let alert = UIAlertController(title: "New contact", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let doneAction = UIAlertAction(title: "Done", style: .default) {_ in
            guard let title = alert.textFields?[0].text else { return }
            guard let phone = alert.textFields?[1].text else { return }
            self.contacts.append(Contact(title: title, phone: phone))
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        alert.addTextField { $0.placeholder = "Jhon D..." }
        alert.addTextField { $0.placeholder = "+380..." }
        self.present(alert, animated: true)
    }
    
    // test data
    private func loadContacts() {
        contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
        contacts.append(Contact(title: "Сильвестр Сталонович", phone: "+380674975199"))
        contacts.append(Contact(title: "Шварц Арнольдович", phone: "+380974389524"))
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if exist reusable cell by indentifier - use him. Else create new UITableViewCell
        var cell = tableView.dequeueReusableCell(withIdentifier: "contactCellIdentifier") ??
        UITableViewCell(style: .default, reuseIdentifier: "contactCellIdentifier")
        configure(&cell, for: indexPath)
        return cell
    }
    
    // reusable code
    private func configure(_ cell: inout UITableViewCell, for indexPath: IndexPath) {
        var conf = cell.defaultContentConfiguration()
        conf.text = contacts[indexPath.row].title
        conf.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = conf
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "delete") { _, _, _ in
            print("contactWillDeleted")
            self.contacts.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

