//
//  FriendCollectionViewLayout.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 10.02.2022.
//

import UIKit

class FriendsCollectionViewLayout: UICollectionViewLayout {

    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()

    var collumnsCount = 2

    var cellHeight: CGFloat = 170

    private var totalCellHeight: CGFloat = 0

    override func prepare() {
        self.cacheAttributes = [:]

        guard let collectionView = self.collectionView else { return }

        let itemsCount = collectionView.numberOfItems(inSection: 0)
        guard itemsCount > 0 else { return }

        let bigCellWidth = collectionView.frame.width
        let smallCellWidth = collectionView.frame.width / CGFloat(self.collumnsCount)

        var lastY: CGFloat = 0
        var lastX: CGFloat = 0

        for index in 0..<itemsCount {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)

            let isBigCell = (index + 1) % (self.collumnsCount + 1) == 0

            if isBigCell {
                attributes.frame = CGRect(x: 0, y: lastY, width: bigCellWidth, height: cellHeight)
                lastY += self.cellHeight
            } else {
                attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWidth, height: cellHeight)
                let isLastCollumn = (index + 2) % (collumnsCount + 1) == 0 || index == itemsCount - 1
                if isLastCollumn {
                    lastX = 0
                    lastY += cellHeight
                } else {
                    lastX += smallCellWidth
                }
            }

            cacheAttributes[indexPath] = attributes
        }
        self.totalCellHeight = lastY
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.frame.width ?? 0,
                      height: totalCellHeight)
    }
}
