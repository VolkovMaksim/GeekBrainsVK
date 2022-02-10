//
//  AllGroupsCell.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import UIKit

final class AllGroupsCell: UITableViewCell {

    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var groupImage: TestView!

    private let imageService = FriendsServiceManager()

    func configure(group: Group) {
        nameGroup.text = group.name

        imageService.loadImage(url: group.photo100) { [weak self] image in
            guard let self = self else { return }
            self.groupImage.image = image
        }
    }
}
