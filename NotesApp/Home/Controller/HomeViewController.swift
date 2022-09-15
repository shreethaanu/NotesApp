//
//  HomeViewController.swift
//  NotesApp
//
//  Created by ShreeThaanu on 09/09/22.
//

import UIKit

class HomeViewController: UIViewController {

    static let syncingBadgeKind = "syncing-badge-kind"

    enum Section {
        case albumBody
    }

    var dataSource: UICollectionViewDiffableDataSource<Section, CardDetailItem>! = nil
    var viewModel: HomeViewModel = HomeViewModel()
    private let refreshControl = UIRefreshControl()

    @IBOutlet weak var notesListCollectionView: UICollectionView!
    @IBOutlet weak var addNotes: UIButton!

    fileprivate func setupCollectionView() {
        notesListCollectionView.collectionViewLayout = generateLayout()
        notesListCollectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        notesListCollectionView.alwaysBounceVertical = true
        notesListCollectionView.refreshControl = refreshControl
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addNotes.layer.cornerRadius = 20
        setupCollectionView()
        configureDataSource()
    }

    @IBAction func refreshData(_ sender: Any) {
        viewModel.fetchFromApi { [self] notes in
            DispatchQueue.main.async {
                self.configureDataSource()
                self.notesListCollectionView.reloadData()
            }
        }
    }

    @IBAction func eraseData(_ sender: Any) {
        viewModel.deleteAllData(entity: "Notes")
        configureDataSource()
    }

    @objc
    private func didPullToRefresh(_ sender: Any) {
        self.configureDataSource()
        self.notesListCollectionView.reloadData()
        refreshControl.endRefreshing()
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

    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, CardDetailItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CardDetailItem>()
        snapshot.appendSections([Section.albumBody])
        let items = viewModel.getData()
        snapshot.appendItems(viewModel.sortChronologically(items: items))
        return snapshot
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var items = viewModel.getData()
        items = viewModel.sortChronologically(items: items)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "notesDetailViewController") as! notesDetailViewController
        nextViewController.notesDetail = items[indexPath.row]
        nextViewController.isDetailPageController = true
        self.present(nextViewController, animated:true, completion:nil)
    }
}
