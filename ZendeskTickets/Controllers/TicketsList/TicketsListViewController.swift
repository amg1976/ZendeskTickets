//
//  TicketsListViewController.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

extension TicketsListViewController {
    
    fileprivate func createCollectionView(_ superView: UIView, viewModel: TicketsListViewModel) -> UICollectionView {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: TicketsListViewCollectionFlowLayout())
        collectionView.register(TicketsListCollectionViewCell.self, forCellWithReuseIdentifier: TicketsListCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = viewModel.collectionViewBackgroundColor
        superView.addSubview(collectionView)
        
        let dictViews: [String:AnyObject] = ["collection":collectionView, "layoutGuide":self.topLayoutGuide]
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
        superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[layoutGuide]-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            collectionView.contentInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
        return collectionView
        
    }
    
}

class TicketsListViewController: UIViewController {
    
    fileprivate var collectionView: UICollectionView?
    fileprivate var activityView: UIActivityIndicatorView?
    fileprivate var viewModel: TicketsListViewModel!
    fileprivate var apiService: ZendeskApiService!
    
    init(apiService: ZendeskApiService) {
        self.apiService = apiService
        self.viewModel = TicketsListViewModel(apiService: apiService)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override func loadView() {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = viewModel.viewBackgroundColor
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        view.addSubview(activityView)
        view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))
        
        self.view = view
        self.collectionView = createCollectionView(view, viewModel: viewModel)
        self.activityView = activityView
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        activityView?.startAnimating()
        viewModel.getTickets { [unowned self] (error) -> Void in
            if error == nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.activityView?.stopAnimating()
                    self.collectionView?.reloadData()
                })
            } else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: { [unowned self] (action) -> Void in
                    self.dismiss(animated: true, completion: nil)
                }))
                DispatchQueue.main.async(execute: { () -> Void in
                    self.activityView?.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.reloadData()
    }
    
}

extension TicketsListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionViewNumberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewNumberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as! TicketsListCollectionViewCell
        if let model = viewModel.cellViewModel(forIndexPath: indexPath) {
            cell.update(model)
        }
        return cell
    }
    
}
