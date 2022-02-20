//
//  MyGroupCell.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import UIKit

final class MyGroupCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupIcon: UIImageView!

    private let imageService = FriendsServiceManager()

    func configure(group: Group) {
        groupName.text = group.name
        
        imageService.loadImage(url: group.photo100) { [weak self] image in
            guard let self = self else { return }
            self.groupIcon.image = image
        }
    }
}
