//
//  ModularBagItemCell.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 19/12/2017.
//

import Foundation
import Lottie

open class ModularBagItemCell: SwipeToDeleteCell, ModularCell, AutoSizeableCell, EditableCell, TappableCell {

    // The type of this variable is UICollectionViewCell but the return type of NibInjectionResolver.loadViewFromNib is casted to ModularBagCell.
    // This is because loadViewFromNib is a generic method that relies on the return type for the generic parameter.
    // And the type of sizingCell should be UICollectionViewCell based on the AutoSizeableCell protocol.
    private static let internalSizingCell: UICollectionViewCell? = Bundle.main.loadNibNamed(String(describing: ModularBagItemCell.self), owner: nil, options: nil)?[0] as? ModularBagItemCell
    open class var sizingCell: UICollectionViewCell? {
        return ModularBagItemCell.internalSizingCell
    }
    
    @IBOutlet weak var productImageView: UIImageView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var colorLabel: UILabel?
    @IBOutlet weak var sizeLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var specialPriceLabel: UILabel?
    @IBOutlet weak var quantityLabel: UILabel?
    @IBOutlet weak var subtotalTitleLabel: UILabel?
    @IBOutlet weak var subtotalLabel: UILabel?
    @IBOutlet weak var brandLabel: UILabel?
    
    @IBOutlet weak var titleViewTrailingToViewTrailingConstraint: NSLayoutConstraint?
    @IBOutlet weak var deleteButtonWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var decreaseButtonWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var increaseButtonWidthConstraint: NSLayoutConstraint?
    @IBOutlet weak var editQuantityLabelWidthConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var editQuantityControlView: UIView?
    
    @IBOutlet weak var increaseQuantityButton: UIButton? {
        didSet {
            increaseQuantityButton?.addTarget(self, action: #selector(adjustQuantity), for: .touchUpInside)
            increaseQuantityButton?.setImage(UIImage(named: "ShoppingBagIncreaseBtn"), for: .normal)
        }
    }
    
    @IBOutlet weak var decreaseQuantityButton: UIButton? {
        didSet {
            decreaseQuantityButton?.addTarget(self, action: #selector(adjustQuantity), for: .touchUpInside)
            decreaseQuantityButton?.setImage(UIImage(named: "ShoppingBagDecreaseBtn"), for: .normal)
        }
    }
    
    @IBOutlet weak var editQuantityLabel: UILabel?
    @IBOutlet weak var editDeleteItemButton: UIButton? {
        didSet {
            editDeleteItemButton?.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        }
    }

    let increaseAndDecreaseButtonWidthConstraintInEditMode: CGFloat = 21
    let editQuantityLabelWidthConstraintInEditMode: CGFloat = 28

    weak var presenterDelegate: ModularBagItemCellPresenter?
    
    var bagItem: PoqBagItemViewData?
    
    let wishlistAnimationView = LOTAnimationView(name: "like")
    
    fileprivate func animateEditModeToggle() {
        UIView.animate(withDuration: 0.5) {
            self.contentView.setNeedsLayout()
            self.contentView.layoutIfNeeded()
        }
    }
    
    var inEditMode = false {
        didSet {
            deleteButtonWidthConstraint?.constant = inEditMode ? 40.0 : 0
            toggleEditQuantityControl(inEditMode)
            
            pan?.isEnabled = !inEditMode
        }
    }
    
    func toggleEditQuantityControl(_ inEditMode: Bool) {
        editQuantityControlView?.isHidden = !inEditMode
        increaseButtonWidthConstraint?.constant = inEditMode ? increaseAndDecreaseButtonWidthConstraintInEditMode : 0
        decreaseButtonWidthConstraint?.constant = inEditMode ? increaseAndDecreaseButtonWidthConstraintInEditMode : 0
        editQuantityLabelWidthConstraint?.constant = inEditMode ? editQuantityLabelWidthConstraintInEditMode : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        wishlistButton.addTarget(self, action: #selector(addToWishlistTapped), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        wishlistButton.addTarget(self, action: #selector(addToWishlistTapped), for: .touchUpInside)
    }
    
    override open func prepareForReuse() {
        super.prepareForReuse()
    
        sizeLabel?.text = nil
        colorLabel?.text = nil
        quantityLabel?.text = nil
        quantityLabel?.isHidden = false
        titleLabel?.text = nil
        priceLabel?.text = nil
        specialPriceLabel?.text = nil
        subtotalLabel?.text = nil
        brandLabel?.text = nil
        editQuantityControlView?.isHidden = true
        inEditMode = false
    }
    
    // Editable Cell
    public func setEditMode(to inEditMode: Bool, animate: Bool = false) {
        
        self.inEditMode = inEditMode
        
        if animate {
            
            animateEditModeToggle()
        } else {
            
            contentView.setNeedsLayout()
            contentView.layoutIfNeeded()
        }
    }
    
    // TappableCell implementation
    public func actionOnTap() {
        
        guard let bagItemId = bagItem?.id else {
            print("Unable to find bagItem id in bag. No action to perform")
            return
        }
        
        presenterDelegate?.didTapOnBagItem(id: bagItemId)
    }
    
    @objc func addToWishlistTapped() {
        
        if bagItem?.isWishlisted ?? false {
            bagItem?.isWishlisted = false
            removeWishlistAnimation()
            changeWishlistButtonTitle(to: "Add To Wishlist")
            
        } else {
            bagItem?.isWishlisted = true
            wishlistAnimationView.isHidden = false
            playWishlistLikeAnimation()
            changeWishlistButtonTitle(to: "Clear From Wishlist")
        }
        
      

        
        guard let bagItemId = bagItem?.id else {
            print("Unable to fetch bag item Id. Cannot add to wishlist")
            return
        }
        
        presenterDelegate?.updateWishlistStatus(id: bagItemId, isWishlisted: !(bagItem?.isWishlisted ?? false))
        
        // The should never update the view model but in this particular case, for wishlist, we don't get a response or wait for it.
       // bagItem?.isWishlisted = !(bagItem?.isWishlisted ?? true)
    }
    
    func addWishlistedAnimation() {
        wishlistAnimationView.frame = CGRect(x: 25, y: 100, width: 50, height: 50)
        wishlistAnimationView.contentMode = .scaleAspectFit
        wishlistAnimationView.isUserInteractionEnabled = false
        wishlistButton.addSubview(wishlistAnimationView)
        wishlistAnimationView.isHidden = true
    }
    
    func removeWishlistAnimation() {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.wishlistAnimationView.isHidden = true
        })
        
    }
    
    func changeWishlistButtonTitle(to title: String) {
        
        UIView.transition(with: wishlistButton,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            self?.wishlistButton.setTitle(title, for: .normal)
            }, completion: nil)
    }
    
    func playWishlistLikeAnimation() {
        
        wishlistAnimationView.play { (finished) in
           self.reset(animate: true)
        }
        
    }
    
    @objc func deleteButtonTapped() {
        
        guard let bagItemId = bagItem?.id else {
            print("Unable to fetch bag item Id. Cannot delete cell")
            return
        }
        
        presenterDelegate?.deleteBagItem(id: bagItemId)
        
    }
    
    @objc func adjustQuantity(_ sender: UIButton) {
        
        let adjustment = sender === decreaseQuantityButton ? -1 : 1
        
        let updatedQuantity = (Int(editQuantityLabel?.text ?? "1") ?? 1) + adjustment
        
        guard let bagItemId = bagItem?.id else {
            print("Unable to fetch bag item Id. Cannot delete cell")
            return
        }
        
        presenterDelegate?.updateQuantity(of: bagItemId, to: updatedQuantity)
    }

    open func setup(with bagItem: PoqBagItemViewData, delegate: ModularBagItemCellPresenter?) {
        
        self.bagItem = bagItem
        
        presenterDelegate = delegate
        
        if let imageUrlString = bagItem.productImageUrl, let imageUrl = URL(string: imageUrlString) {
            do {
                try productImageView?.image = UIImage(data: Data(contentsOf: imageUrl))
            } catch {
                print("Error loading image")
            }
        }
        
        titleLabel?.text = bagItem.productTitle
        brandLabel?.text = bagItem.brandName
        
        if let price = bagItem.price, let priceString = price.currencyString {
            
            if let specialPrice = bagItem.specialPrice, specialPrice > price, let specialPriceString = specialPrice.currencyString {
                priceLabel?.text = String(format: "Orig: %@", priceString)
                specialPriceLabel?.text = String(format: "Now: %@", specialPriceString)
            } else {
                priceLabel?.textColor = UIColor.black
                priceLabel?.text = priceString
            }
        }
        
        if let quantity = bagItem.quantity {
            quantityLabel?.text = "Qty: " + String(describing: quantity)
            editQuantityLabel?.text =  String(describing: quantity)
            quantityLabel?.isHidden = false
            // Update the buttons states depending on the quantity
            decreaseQuantityButton?.isEnabled = quantity != 1
        }
        
        if let subtotal = bagItem.subTotal {
            subtotalLabel?.text = String(describing: subtotal)
        } else {
            subtotalLabel?.isHidden = true
            subtotalTitleLabel?.isHidden = true
        }
        
        addWishlistedAnimation()
        if bagItem.isWishlisted ?? false {
            
            wishlistButton.setTitle("Clear From Wishlist", for: .normal)
            wishlistAnimationView.isHidden = false
        }
        
        inEditMode = presenterDelegate?.inEditMode ?? false
    }
}

extension Decimal {
    
    var currencyString: String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: self as NSDecimalNumber)
    }
}
