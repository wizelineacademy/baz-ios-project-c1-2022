//
//  CarosuelMenu.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import UIKit

struct CarosuelMenuConfiguration {
    let frame: CGRect
    let optionsTitles: [String]
    let itemBackgroundColor: UIColor
    let itemBorderBackgroundColor: UIColor
    let itemSelectedBackgroundColor: UIColor
    let itemSelectedBorderBackgroundColor: UIColor
    let itemBorder: Double
    
    init(frame:CGRect,
         optionsTitles:[String] = [],
         itemBackgroundColor: UIColor = .clear,
         itemBorderBackgroundColor: UIColor = .clear,
         itemSelectedBackgroundColor: UIColor = .clear,
         itemSelectedBorderBackgroundColor: UIColor = .clear,
         itemBorder: Double = 10.0) {
        
        self.frame = frame
        self.optionsTitles = optionsTitles
        self.itemBackgroundColor = itemBackgroundColor
        self.itemBorderBackgroundColor = itemBorderBackgroundColor
        self.itemSelectedBackgroundColor = itemSelectedBackgroundColor
        self.itemSelectedBorderBackgroundColor = itemSelectedBorderBackgroundColor
        self.itemBorder = itemBorder
    }
}

class CarosuelMenu: UIView {
    public weak var delegate: CarosuelMenuDelegate?
    private(set) var itemBackgroundColor: UIColor = .clear
    private(set) var itemBorderBackgroundColor: UIColor = .clear
    private(set) var itemSelectedBackgroundColor: UIColor = .clear
    private(set) var itemSelectedBorderBackgroundColor: UIColor = .clear
    private(set) var itemBorder: Double = 10.0
    private(set) lazy var menuOptions: [String] = {
        return []
    }()
    
    public var optionSelected: Int = 0{
        didSet{
            menu.reloadData()
        }
    }
    
    public lazy var menu: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let menu = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        menu.backgroundColor = UIColor.clear
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.delegate = self
        menu.dataSource = self
        menu.showsHorizontalScrollIndicator = false
        menu.showsVerticalScrollIndicator = false
        menu.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        menu.register(optionMenuCell.self,forCellWithReuseIdentifier: optionMenuCell.reuseIdentifier)
        return menu
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(with model: CarosuelMenuConfiguration){
        self.init(frame: model.frame)
        self.itemBackgroundColor = model.itemBackgroundColor
        self.itemBorderBackgroundColor = model.itemBorderBackgroundColor
        self.itemSelectedBackgroundColor = model.itemSelectedBackgroundColor
        self.itemSelectedBorderBackgroundColor = model.itemSelectedBorderBackgroundColor
        self.itemBorder = model.itemBorder
        self.setDataInfo(infoMenu: model.optionsTitles)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(menu)
        NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: self.layer.frame.height ),
                                     widthAnchor.constraint(equalToConstant: self.layer.frame.width),
                                     menu.heightAnchor.constraint(equalToConstant: self.layer.frame.height ),
                                     menu.widthAnchor.constraint(equalToConstant: self.layer.frame.width),
                                     menu.topAnchor.constraint(equalTo: self.topAnchor),
                                     menu.leftAnchor.constraint(equalTo: self.leftAnchor),
                                     menu.rightAnchor.constraint(equalTo: self.rightAnchor),
                                     menu.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
        let contentOffset = menu.contentOffset
        menu.setContentOffset(contentOffset, animated: false)
    }
    
    public func setDataInfo(infoMenu: [String]) {
        menuOptions = infoMenu
        optionSelected = 0
        menu.reloadData()
    }
}
