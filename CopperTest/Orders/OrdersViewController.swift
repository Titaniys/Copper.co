//
//  OrdersViewController.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit
import CoreData

final class OrdersViewController: UIViewController {
        
    private let viewModel: OrdersViewModel

    private(set) lazy var fetchedResultsController: NSFetchedResultsController<OrderDB> = {
        let fetchRequest: NSFetchRequest<OrderDB> = OrderDB.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: viewModel.viewContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        controller.delegate = self
        return controller
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: "OrderCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .black
        return collectionView
    }()
    
    private lazy var loaderView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()
    
    init(viewModel: OrdersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        try? fetchedResultsController.performFetch()

        guard viewModel.isFirstLaunch else { return }
        subscribeViewModel()
    }
    
    private func configureUI() {
        view.addSubviews([collectionView, loaderView])
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loaderView.heightAnchor.constraint(equalToConstant: 44),
            loaderView.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func subscribeViewModel() {
        viewModel.fetchOrders() { [weak self] status in
            guard let self = self else { return }
            switch status {
            case .loaded:
                self.loaderView.stopAnimating()
            case .loading:
                self.loaderView.isHidden = false
                self.loaderView.startAnimating()
            case .error:
                self.loaderView.isHidden = false
                print("you can show error view")
            }
        }
    }

}

extension OrdersViewController: UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width, height: 63)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let order = fetchedResultsController.object(at: indexPath)
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell",
                                                            for: indexPath) as? OrderCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: OrderCellViewModel(order: Order(orderDB: order)))
        return cell
    }

}

extension OrdersViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        collectionView.reloadData()
    }
}
