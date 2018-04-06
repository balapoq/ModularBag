import Foundation

//
//  SwipeToDeleteCell.swift
//  PoqPlatform
//
//  Created by Balaji Reddy on 22/01/2018.
//

import Foundation
import UIKit

open class SwipeToDeleteCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    var actionViews: [UIView]?
    var pan: UIPanGestureRecognizer?
    var wishlistButton: UIButton!
    var deleteButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActionViews()
        addActionViewsToContentView()
        setupPanView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActionViews()
        addActionViewsToContentView()
        setupPanView()
    }
    
    open override func didMoveToWindow() {
        if window != nil {
            setViewFrames(startingFrom: 0.0)
        }
    }
    
    fileprivate func getWishlistButton() -> UIButton {
        
        let  wishlistButton = UIButton(type: .custom)
        wishlistButton.setTitle("Add To Wishlist", for: .normal)
        wishlistButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        wishlistButton.titleLabel?.textAlignment = .center
        wishlistButton.setTitleColor(UIColor.white, for: .normal)
        wishlistButton.backgroundColor = UIColor.hexColor("#fc8435")
        
        return wishlistButton
        
    }
    
    fileprivate func getDeleteButton() -> UIButton {
  
        let deleteButton = UIButton(type: .custom)
        deleteButton.setTitle("Delete", for: .normal) 
        deleteButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 10.0)
        deleteButton.titleLabel?.textAlignment = .center
        deleteButton.setTitleColor(UIColor.white, for: .normal)
        deleteButton.backgroundColor = UIColor.red
        
        return deleteButton
    }
    
    public func setupActionViews() {
        
        wishlistButton = getWishlistButton()
        deleteButton = getDeleteButton()
        actionViews = [wishlistButton, deleteButton]
    }

    fileprivate func addActionViewsToContentView() {
        
        actionViews?.forEach { actionView in
            self.insertSubview(actionView, belowSubview: self.contentView)
        }
    }
    
    fileprivate func setViewFrames(startingFrom xPos: CGFloat) {
        let contentViewWidth = contentView.frame.width
        let contentViewHeight = contentView.frame.height
        
        self.contentView.frame = CGRect(x: xPos, y: 0, width: contentViewWidth, height: contentViewHeight)
        self.wishlistButton.frame = CGRect(x: xPos + contentViewWidth, y: 0, width: 100, height: contentViewHeight)
        self.deleteButton.frame = CGRect(x: xPos + contentViewWidth + wishlistButton.frame.size.width, y: 0, width: 100, height: contentViewHeight)
    }
    
    public func reset(animate: Bool = false) {
        
        if animate {
            UIView.animate(withDuration: 0.3, animations: {
                self.setViewFrames(startingFrom: 0.0)
            })
        } else {
            setViewFrames(startingFrom: 0.0)
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let panUnwrapped = pan else {
            print("Pan gesture not initialised.")
            return
        }
        
        var translation = panUnwrapped.translation(in: self)
        
        // Ignore pan to right - Only swipes left
        guard translation.x < 0.0 else {
            
            setViewFrames(startingFrom: 0.0)
            return
        }
        
        // If pan has revealed all the action views, don't pan any more.
        let sumOfActionViewWidths: CGFloat = 200.0
        translation.x = (translation.x + sumOfActionViewWidths) < 0 ? -sumOfActionViewWidths : translation.x
        
        if panUnwrapped.state == UIGestureRecognizerState.changed {
            
            // print("Recognizer state changed")
            setViewFrames(startingFrom: translation.x)
            
        } else if panUnwrapped.state == UIGestureRecognizerState.ended {
            
            // print("Recognizer state ended")
            let newContentViewOriginX: CGFloat =  translation.x < -sumOfActionViewWidths/3 ? -sumOfActionViewWidths : 0.0
            setViewFrames(startingFrom: newContentViewOriginX)
        }
    }
    
    public func setupPanView() {
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        
        guard let panUnwrapped = pan else {
            print("Could not initialize pan gesture")
            return
        }
        
        panUnwrapped.delegate = self
        self.addGestureRecognizer(panUnwrapped)
    }
    
    fileprivate func animateLayout(for duration: Double) {
        UIView.animate(withDuration: duration, animations: {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        })
    }
    
    @objc
    public func onPan(_ pan: UIPanGestureRecognizer) {
        
        switch pan.state {
        
        case .changed:
            let duration = pan.translation(in: self).x < 0.0 ? 0.0 : 0.5
            animateLayout(for: duration)
            
        case .ended, .began:
            animateLayout(for: 0.5)
            
        default:
            break
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
