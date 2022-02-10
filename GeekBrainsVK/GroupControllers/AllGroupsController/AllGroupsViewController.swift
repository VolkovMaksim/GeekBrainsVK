//
//  AllGroupsViewController.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import UIKit

final class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    private let service = GroupService()
    private let serviceImage = FriendsServiceManager()

    var groups: [Group] = []
    // определим переменную в которой будет хранится массив по моделе Group
    var filteredGroups: [Group] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // назначим поиск бару делегата
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AllGroupsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AllGroupsCell
        else {
            return UITableViewCell()
        }
        cell.configure(group: filteredGroups[indexPath.row])

        return cell
    }
}

// MARK: - UISearchBarDelegate
// расширим наш класс назначим ему родителя серчбар настроим поиск
extension AllGroupsViewController: UISearchBarDelegate {

    // нативным методом определим логику работы поиск бара
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        // определим константу текст и определим если true то пробел если false то вводимый текст
        let text = searchText.isEmpty ? " " : searchText
        // очистим наш массив
        filteredGroups = []
        // запустим метод поиска груп и передадим в нее искомый текст
        // в замыкании передадим результат
        service.loadGroupSearch(searchText: text) { [weak self] result in
            switch result {
                // если запрос успешен то в потоке майн запишем в константу гроуп результат запроса
            case .success(let group):
                self?.filteredGroups = group
                DispatchQueue.main.async {
                    // перезагрузим данные
                    self?.tableView.reloadData()
                }
                // при не удачном запросе вернуть ошибку
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
