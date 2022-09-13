//
//  HomeViewController.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//

import UIKit

class HomeViewController: UIViewController {
    static let syncingBadgeKind = "syncing-badge-kind"

    var myData: CardDetailItem = CardDetailItem(title: "data", id: "1", body: "efg", created_time: 56, image: "img")
    
    enum Section {
        case albumBody
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, CardDetailItem>! = nil
    var viewModel: HomeViewModel = HomeViewModel()

    @IBOutlet weak var notesListCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        notesListCollectionView.collectionViewLayout = generateLayout()
        notesListCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        configureDataSource()
       
    }

    @IBAction func refreshData(_ sender: Any) {
        viewModel.fetchFromApi()
    }
    
    @IBAction func eraseData(_ sender: Any) {
        viewModel.deleteAllData(entity: "Notes")
    }

}

extension HomeViewController {

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, CardDetailItem>(collectionView: notesListCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, detailItem: CardDetailItem) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCollectionViewCell", for: indexPath) as! NotesCollectionViewCell
            cell.backgroundColor = .random
            cell.notesTitle.text = detailItem.title
            return cell
        }
    
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func generateLayout() -> UICollectionViewLayout {
        let syncingBadgeAnchor = NSCollectionLayoutAnchor(edges: [.top, .trailing], fractionalOffset: CGPoint(x: -0.3, y: 0.3))
        let syncingBadge = NSCollectionLayoutSupplementaryItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .absolute(20),
                heightDimension: .absolute(20)),
            elementKind: HomeViewController.syncingBadgeKind,
            containerAnchor: syncingBadgeAnchor)

        let fullPhotoItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/3)),
            supplementaryItems: [syncingBadge])
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let trailingGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)),
            subitem: pairItem,
            count: 2)

        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [mainItem, trailingGroup])

        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)),
            subitems: [tripletItem, tripletItem, tripletItem])

        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [trailingGroup, mainItem])

        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, CardDetailItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CardDetailItem>()
        snapshot.appendSections([Section.albumBody])
        let items = itemsForAlbum()
        snapshot.appendItems(items)
        return snapshot
    }

    func itemsForAlbum() -> [CardDetailItem] {
        return [myData]
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("tapped tapped !! -- ")
    }
}
