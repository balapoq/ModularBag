//
//  PoqModularBagViewController.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 11/12/2017.
//

import Foundation
import UIKit

public class  PoqModularBagViewController: UIViewController {

    var poqSpinner: UIActivityIndicatorView?
    
    // MARK: - IBOutlets
    @IBOutlet weak open var collectionView: UICollectionView? {
        didSet {
            
            collectionView?.delegate = collectionViewDelegate
            collectionView?.dataSource = collectionViewDataSource
            
            if let collectionViewFlowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
                collectionViewFlowLayout.minimumLineSpacing = 0
                collectionViewFlowLayout.minimumInteritemSpacing = 0
            }
        }
    }
    
    @IBOutlet weak var checkoutButton: UIButton? {
        didSet {
            checkoutButton?.addTarget(self, action: #selector(checkoutButtonTapped), for: .touchUpInside)
        }
    }
    @IBOutlet weak var numberItemsLabel: UILabel?
    @IBOutlet weak var totalLabel: UILabel?
    
    // MARK: - Properties
    public var presenter: ModularBagPresenter?
    public var collectionViewDataSource: ModularCollectionViewDataSource?
    public var collectionViewDelegate: ModularCollectionViewDelegate?
    public var content: [PoqModularBagViewData]? {
        didSet {
            
            collectionViewDataSource?.content = content
            collectionViewDelegate?.content = content
            
            rightBarButtonItemIsEnabled = (content?.count ?? 0 > 0) || inEditMode ?? false
            checkoutButtonEnabled = (content?.count ?? 0 > 0)

            if content != nil, let collectionViewUnwrapped = collectionView {
                
                    collectionViewDataSource?.registerCells(with: collectionViewUnwrapped)
                    contentUpdated()
                    setupCheckoutPanel()
            }

        }
    }
    public var editButton: UIBarButtonItem?
    public var rightBarButtonItemIsEnabled: Bool = false {
        
        didSet {
            
            editButton?.isEnabled = rightBarButtonItemIsEnabled
        }
    }
    
    public var checkoutButtonEnabled: Bool = false {
        
        didSet {
            
            checkoutButton?.isEnabled = checkoutButtonEnabled
        }
    }

    func viewStateHandler(action: BagViewState.Action?) {
        
        switch action {
        case .changedEditMode?:
            
            let navBarRightButtonTitle = (presenter?.inEditMode ?? false) ? "Done" : "Edit"
            editButton?.title = navBarRightButtonTitle
            guard let collectionViewUnwrapped = collectionView else {
                    fatalError("Collection View instance is nil!")
            }

            collectionViewDelegate?.setEditMode(on: collectionViewUnwrapped, to: presenter?.inEditMode ?? false)

        case .scrolled?:
            
            break
            
        case .error(let erroMessage)?:
            
            removeSpinner()
            showErrorMessage(erroMessage)
            
        case .loading?:
            
            displaySpinner()
            
        case .none:
        
            break
        }
        
    }
    
    func contentStoreHandler(action: ContentStore<PoqModularBagViewData>.Action?, content: [PoqModularBagViewData]?) {
        
        switch action {
            
        case .set(let content)?, .update(let content)?:
            
           self.content = content
           editButton?.title = "Edit"
           
           guard let collectionViewUnwrapped = collectionView else {
               fatalError("Collection View instance is nil!")
           }
           collectionViewDelegate?.setEditMode(on: collectionViewUnwrapped, to: false)
           removeSpinner()
            
        case .edit(let content)?:
            
            self.content = content
            
        case .deleted(let indices, _)?:
            
            collectionView?.performBatchUpdates({
                indices.forEach() { index in
                    self.content?.remove(at: index)
                    self.collectionView?.deleteItems(at: [IndexPath(row: index, section: 0)])
                }
            })
            
        case .none:
            
            break
            
        default:
           break
        }
    }
    
    func displaySpinner() {
        
        poqSpinner = UIActivityIndicatorView()
        poqSpinner?.frame.size = CGSize(width: 44, height: 44)
        poqSpinner?.center = view.center
        if let poqSpinner = poqSpinner {
            view.addSubview(poqSpinner)
        }
        poqSpinner?.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        poqSpinner?.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        poqSpinner?.startAnimating()
    }
    
    func removeSpinner() {
    
      poqSpinner?.stopAnimating()
      poqSpinner?.removeFromSuperview()
      poqSpinner = nil
    }
    
    // MARK: - Actions
    @objc func toggleEditMode() {
        
        presenter?.toggleEditMode()
    }
    
    func setupCheckoutPanel() {
        let numberOfItems = presenter?.numberOfItems ?? 0
        numberItemsLabel?.text = String(numberOfItems) + (numberOfItems == 1 ? " Item" : " Items")
        let total = (presenter?.bagTotal ?? 0).currencyString ?? "0"
        totalLabel?.text = "Total " + String(describing: total)
    }
    
    @objc func checkoutButtonTapped() {
        
        presenter?.presentCheckout()
    }
    
    // MARK: - Presentation
    func showErrorMessage(_ errorMessage: String) {
        
        let validAlertController = UIAlertController.init(title: "Error Fetching Bag", message: errorMessage, preferredStyle: UIAlertControllerStyle.alert)
        
        validAlertController.addAction(UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default))
        
        present(validAlertController, animated: true)
    }
    
    // MARK: - Update View
    func contentUpdated() {
        
        collectionView?.reloadData()
    }
    
    // MARK: - View Controller Delegates
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        editButton = UIBarButtonItem(title: "Edit", style: .bordered, target: self, action: #selector(toggleEditMode))
        navigationItem.rightBarButtonItem = editButton
        presenter?.viewDidLoad()
        presenter?.addViewStateHandler(viewStateHandler)
        presenter?.addContentHandler(contentStoreHandler)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        
        presenter?.viewWillAppear()
        
        super.viewWillAppear(animated)
        
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
    }
    
    public func didSelectItem(at: IndexPath) {
        
        // presenter?.didSelectItem(at: IndexPath)
    }
}

extension PoqModularBagViewController: ModularBagItemCellPresenter {
    
    public var inEditMode: Bool? {
        
        return presenter?.inEditMode
    }
    
    public func deleteBagItem(id: Int) {
        
        presenter?.deleteBagItem(id: id)
    }
    
    // ToDo: Finish this implementation
    public func addBagItemToWishList(id: Int) {
        
    }
    
    public func updateQuantity(of bagItemId: Int, to quantity: Int) {
        
        presenter?.updateQuantity(of: bagItemId, to: quantity)
    }
    
    public func didTapOnBagItem(id: Int) {
        
        presenter?.didTapOnBagItem(id: id)
    }
    
    public func updateWishlistStatus(id: Int, isWishlisted: Bool) {
        
        presenter?.updateWishlistStatus(id: id, isWishlisted: isWishlisted)
    }
    
}
