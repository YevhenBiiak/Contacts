//
//  ViewController.swift
//  Contacts
//
//  Created by Евгений Бияк on 19.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var contacts: [ContactProtocol] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContacts()
    }

    
    // test data
    private func loadContacts() {
        contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
        contacts.append(Contact(title: "Сильвестр Сталонович", phone: "+380674975199"))
        contacts.append(Contact(title: "Шварц Арнольдович", phone: "+380974389524"))
        contacts.sort{ $0.title < $1.title }
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

