//
//  ViewController.swift
//  BVBaseComponents
//
//  Created by Brian Voong on 11/16/2016.
//  Copyright (c) 2016 Brian Voong. All rights reserved.
//

import UIKit
import BVBaseComponents

class SimpleDatasource: BVDatasource {
    
    override init() {
        super.init()
        objects = ["Hello", "these", "are", "basic", "useful", "components"]
    }
    
    override func cellClasses() -> [BVDatasourceCell.Type] {
        return [SimpleCell.self]
    }
}

class SimpleCell: BVDatasourceCell {
    
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

class SimpleCollectionViewController: BVDatasourceController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Basic Components & Helpers"
        collectionView?.backgroundColor = .white
        datasource = SimpleDatasource()
    }

}

