//
//  FriendsListController.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import UIKit

/// Сценарий списка друзей
final class FriendsListController: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var friends: [FriendsSection] = []
    var filteredFriends: [FriendsSection] = []
    var lettersOfNames: [String] = []
    var service = FriendsServiceManager()

    func searchBarAnimateClosure () -> () -> Void {
        return {
            guard
                let scopeView = self.searchBar.searchTextField.leftView,
                let placeholderLabel = self.searchBar.textField?.value(forKey: "placeholderLabel") as?
                    UILabel
            else {
                return
            }

            UIView.animate(withDuration: 0.3,
                           animations: {
                scopeView.frame = CGRect(x: self.searchBar.frame.width / 2 - 15,
                                         y: scopeView.frame.origin.y,
                                         width: scopeView.frame.width,
                                         height: scopeView.frame.height)
                placeholderLabel.frame.origin.x -= 20
                self.searchBar.layoutSubviews()
            })
        }
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.sectionFooterHeight = 0.0
        self.tableView.sectionHeaderHeight = 50.0
        searchBar.delegate = self
        fetchFriends()
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
            UIView.animate(withDuration: 0,
                           animations: self.searchBarAnimateClosure())
        })
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredFriends.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFriends[section].data.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = friends[section]

        return String(section.key)
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersOfNames
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                     for: indexPath) as? FriendsListCell
        else {
            return UITableViewCell()
        }

        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowRadius = 10
        cell.layer.shadowOpacity = 10

        let section = filteredFriends[indexPath.section]
        let name = section.data[indexPath.row].firstName
        let photo = section.data[indexPath.row].photo50
        cell.friendName.text = name

        DispatchQueue.main.async { [weak self] in
            self?.service.loadImage(url: photo) { image in
                cell.friendIcon.image = image
            }
        }

        return cell
    }

//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return createHeaderView(section: section)
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is CurrentFriendController {
            guard
                let vc = segue.destination as? CurrentFriendController,
                let indexPathSection = tableView.indexPathForSelectedRow?.section,
                let indexPathRow = tableView.indexPathForSelectedRow?.row
            else {
                return
            }
            let section = filteredFriends[indexPathSection]
            let firstName = section.data[indexPathRow].firstName
            let friendId = section.data[indexPathRow].id
            let photo = section.data[indexPathRow].photo50

            vc.friendName = firstName
            vc.friendId = String(friendId)
            vc.friendAvatar = photo
        }
    }
}

// MARK: - UISearchBarDelegate
extension FriendsListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriends = []

        if searchText == "" {
            filteredFriends = friends
        } else {
            for section in friends {
                for (_, friend) in section.data.enumerated() {
                    if friend.firstName.lowercased().contains(searchText.lowercased()) {
                        var searchedSection = section

                        if filteredFriends.isEmpty {
                            searchedSection.data = [friend]
                            filteredFriends.append(searchedSection)
                            break
                        }
                        var found = false
                        for (sectionIndex, filteredSection) in filteredFriends.enumerated() {
                            if filteredSection.key == section.key {
                                filteredFriends[sectionIndex].data.append(friend)
                                found = true
                                break
                            }
                        }
                        if !found {
                            searchedSection.data = [friend]
                            filteredFriends.append(searchedSection)
                        }
                    }
                }
            }
        }
        self.tableView.reloadData()
    }

    // отмена поиска
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true // показать кнопку кансл

        let cBtn = searchBar.value(forKey: "cancelButton") as! UIButton
        cBtn.backgroundColor = .lightGray
        cBtn.setTitleColor(.white, for: .normal)

        UIView.animate(withDuration: 0.3,
                       animations: {
            // Двигаем кнопку кансл
            cBtn.frame = CGRect(x: cBtn.frame.origin.x - 50,
                                y: cBtn.frame.origin.y,
                                width: cBtn.frame.width,
                                height: cBtn.frame.height)

            // Анимируем запуск поиска. -1 чтобы пошла анимация, тогда лупа плавно откатывается
            self.searchBar.frame = CGRect(x: self.searchBar.frame.origin.x,
                                          y: self.searchBar.frame.origin.y,
                                          width: self.searchBar.frame.size.width - 1,
                                          height: self.searchBar.frame.size.height)
            self.searchBar.layoutSubviews()
        })
    }

//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        // Анимацию возвращения в исходное состояние после нажатия кансл
//        UIView.animate(withDuration: 0.2,
//                       animations: {
//            searchBar.showsCancelButton = false // скрываем кнопку кансл
//            searchBar.text = nil
//            self.filteredFriends = self.friends
//            self.tableView.reloadData()
//            searchBar.resignFirstResponder() // скрываем клавиатуру
//        }, completion: { _ in
//            let closure = self.searchBarAnimateClosure()
//            closure()
//        })
//    }
}

// MARK: - Private
private extension FriendsListController {
    func loadLetters() {
        for user in friends {
            lettersOfNames.append(String(user.key))
        }
    }

    func fetchFriends() {
        service.loadFriends { [weak self] friends in
            guard let self = self else { return }
            self.friends = friends
            self.filteredFriends = friends
            self.loadLetters()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

//    func createHeaderView(section: Int) -> UIView {
//        let header = GradientView()
//        header.startColor = .systemPink
//        header.endColor = .white
//
//        let letter = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
//        letter.textColor = .white
//        letter.text = lettersOfNames[section]
//        letter.font = UIFont.systemFont(ofSize: 14)
//        header.addSubview(letter)
//        return header
//    }
}
