//
//  DatasourceController.swift
//  BVBaseComponents
//
//  Created by Brian Voong on 11/16/16.
//  Copyright © 2016 Lets Build That App. All rights reserved.
//

import UIKit

open class DatasourceCell: UICollectionViewCell {
    
    open var datasourceItem: Any?
    open var controller: DatasourceController?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    open func setupViews() {
        clipsToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

open class Datasource: NSObject {
    
    public var objects: [Any]?
    
    open func cellClasses() -> [DatasourceCell.Type] {
        return []
    }
    
    open func headerClasses() -> [AnyClass] {
        return []
    }
    
    open func numberOfItems(section: Int) -> Int {
        return objects?.count ?? 0
    }
    
    open func numberOfSections() -> Int {
        return 1
    }
    
    open func item(indexPath: IndexPath) -> Any? {
        return objects?[indexPath.item]
    }
    
    open func headerItem(indexPath: IndexPath) -> Any? {
        return nil
    }
    
}

open class DatasourceController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    open let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.hidesWhenStopped = true
        aiv.color = .black
        return aiv
    }()
    
    open var datasource: Datasource? {
        didSet {
            if let cellClasses = datasource?.cellClasses() {
                for cellClass in cellClasses {
                    collectionView?.register(cellClass, forCellWithReuseIdentifier: NSStringFromClass(cellClass))
                }
            }
            
            if let headerClasses = datasource?.headerClasses() {
                for headerClass in headerClasses {
                    collectionView?.register(headerClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: NSStringFromClass(headerClass))
                }
            }
            
            collectionView?.reloadData()
        }
    }
    
    public init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        
        layout?.minimumLineSpacing = 0
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.anchorCenterXToSuperview()
        activityIndicatorView.anchorCenterYToSuperview()
    }
    
    override open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.numberOfSections() ?? 0
    }
    
    override open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource?.numberOfItems(section: section) ?? 0
    }
    
    //need to override this otherwise size doesn't get called
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    override open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cellClass = datasource?.cellClasses()[indexPath.section] {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(cellClass), for: indexPath) as! DatasourceCell
            cell.controller = self
            cell.datasourceItem = datasource?.item(indexPath: indexPath)
            return cell
        }
        //this causes a crash when not properly setting up Datasource
        return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    }
    
    override open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerClass = datasource?.headerClasses()[indexPath.section] else { return UICollectionViewCell() }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: NSStringFromClass(headerClass), for: indexPath) as! DatasourceCell
        header.datasourceItem = datasource?.headerItem(indexPath: indexPath)
        header.controller = self
        
        return header
    }
    
    open func getRefreshControl() -> UIRefreshControl {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }
    
    open func handleRefresh() {
        
    }
    
    open var layout: UICollectionViewFlowLayout? {
        get {
            return collectionViewLayout as? UICollectionViewFlowLayout
        }
    }
}
