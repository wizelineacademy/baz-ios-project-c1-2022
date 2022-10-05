//
//  CarouselMenu.swift
//  BAZProjectC1
//
//  Created by 1044336 on 23/09/22.
//

import UIKit

class CarouselMenu: UIView {
    public weak var delegate: CarouselMenuDelegate?
    private(set) var itemBackgroundColor: UIColor = .clear
    private(set) var itemBorderBackgroundColor: UIColor = .clear
    private(set) var itemSelectedBackgroundColor: UIColor = .clear
    private(set) var itemSelectedBorderBackgroundColor: UIColor = .clear
    private(set) var itemBorder: Double = 10.0
    private(set) lazy var menuOptions: [String] = {
        return []
    }()
    
    private(set) var optionSelected: Int = 0 {
        didSet {
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
        menu.register(OptionMenuCell.self,forCellWithReuseIdentifier: OptionMenuCell.reuseIdentifier)
        return menu
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    convenience init(with model: CarouselMenuConfiguration) {
        self.init(frame: model.frame)
        self.configure(with: model)
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
    
    func configure(with model: CarouselMenuConfiguration) {
        self.itemBackgroundColor = model.itemBackgroundColor
        self.itemBorderBackgroundColor = model.itemBorderBackgroundColor
        self.itemSelectedBackgroundColor = model.itemSelectedBackgroundColor
        self.itemSelectedBorderBackgroundColor = model.itemSelectedBorderBackgroundColor
        self.itemBorder = model.itemBorder
        self.setDataInfo(infoMenu: model.optionsTitles)
    }
    internal func setOptionSelected(row: Int) {
        optionSelected = row
    }
}
