//
//  ViewController.swift
//  StretchySnacks
//
//  Created by ruijia lin on 5/22/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // array for default food images
    let imageArray = [#imageLiteral(resourceName: "oreos"), #imageLiteral(resourceName: "pizza_pockets"), #imageLiteral(resourceName: "pop_tarts"), #imageLiteral(resourceName: "popsicle"), #imageLiteral(resourceName: "ramen")]
    
    // container array to store food name and display in collection view
    var collectionViewArray = [UIImage]()
    
    // stack view to display food items
    let foodStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    // adding nav bar title to nav bar center
    let navBarTitle: UILabel = {
        let title = UILabel()
        title.text = "Snacks"
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    @IBOutlet weak var navBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navBar: UIView!
    @IBOutlet weak var fingerCrossed: UIButton!
    @IBOutlet weak var navBarHeightConstraint: NSLayoutConstraint!
    var animator: UIViewPropertyAnimator!
    var navBarHeightConstant: CGFloat = 66
    var navBarTitleCenterYConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add UIImage to stackview
        var index = 0
        for image in imageArray{
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
            let imageView = UIImageView.init(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.tag = index
            imageView.addGestureRecognizer(tap)
            foodStackView.addArrangedSubview(imageView)
            index += 1
        }
        
        navBar.addSubview(navBarTitle)
        navBar.addSubview(foodStackView)
        
        
//         register collection view
//                if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
//                    flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
//                }
//
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        setupConstraint()
        
    }
    
    private func setupConstraint(){
        
        navBarTitleCenterYConstraint = navBarTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor)
        navBarTitleCenterYConstraint.isActive = true
        navBarTitle.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
        //        navBarTitle.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
        //        navBarTitle.topAnchor.constraint(equalTo: navBar.topAnchor, constant: 30).isActive = true
        
        foodStackView.bottomAnchor.constraint(equalTo: navBar.bottomAnchor, constant: -10).isActive = true
        foodStackView.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 10).isActive = true
        foodStackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -10).isActive = true
        foodStackView.heightAnchor.constraint(equalTo: navBar.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    @objc private func imageTapped(sender: UITapGestureRecognizer){
        guard let index = sender.view?.tag else {return}
        let image = imageArray[index]
        
        collectionViewArray.append(image)
        //collectionView.reloadData()
        
        let indexPath = IndexPath(item: collectionViewArray.count - 1, section: 0)
        //collectionView.performBatchUpdates({
            collectionView.insertItems(at: [indexPath])
        //}, completion: nil)
    }
    
    @IBAction func animateNavBarStopped(_ sender: UIButton) {
        if navBarHeightConstant == 200 {
            navBarHeightConstant = 66
        }else if navBarHeightConstant == 66{
            navBarHeightConstant = 200
        }
        
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            self.fingerCrossed.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 180.0 / 180.0))
            let transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 180.0 / 180.0))
            self.fingerCrossed.transform = self.fingerCrossed.transform.concatenating(transform)
            self.navBarHeightConstraint.constant = self.navBarHeightConstant
            
            // change title based on nav bar status
            self.navBarTitle.text = self.navBarTitle.text == "Snacks" ? "Add a Snack" : "Snacks"
            self.navBarTitleCenterYConstraint.constant = self.navBarTitleCenterYConstraint.constant == 0 ? -40 : 0
            
            self.view.layoutIfNeeded()
            
            // toggle between showing stackView
            self.foodStackView.isHidden = !(self.foodStackView.isHidden)
            
        }, completion: nil)
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let image  = collectionViewArray[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? ImageCollectionViewCell else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            return cell
        }
        
        cell.foodImageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    
}

