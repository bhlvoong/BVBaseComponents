//
//  ViewController.swift
//  BVBaseComponents
//
//  Created by Brian Voong on 11/16/2016.
//  Copyright (c) 2016 Brian Voong. All rights reserved.
//

import UIKit
import BVBaseComponents

class SimpleDatasource: Datasource {
    
    override init() {
        super.init()
        objects = ["Hello", "these", "are", "basic", "useful", "components"]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [SimpleCell.self]
    }
    
    override func headerClasses() -> [AnyClass] {
        return [SimpleHeader.self]
    }
    
    override func footerClasses() -> [AnyClass] {
        return [SimpleFooter.self]
    }

}

class SimpleCell: DatasourceCell {
    
    override var datasourceItem: Any? {
        didSet {
            wordlabel.text = datasourceItem as? String
        }
    }
    
    let wordlabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        addSubview(wordlabel)
        wordlabel.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
}

class SimpleHeader: DatasourceCell {
    let textlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Collection Header"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textlabel)
        textlabel.fillSuperview()
    }
}

class SimpleFooter: DatasourceCell {
    let textlabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Footer"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(textlabel)
        textlabel.fillSuperview()
    }
}

class SimpleCollectionViewController: DatasourceController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Basic Components & Helpers"
        collectionView?.backgroundColor = .white
        datasource = SimpleDatasource()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }

}

