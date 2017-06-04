//
//  ChatViewController.swift
//  iOS_LINE_UI
//
//  Created by 森健太 on 2017/06/03.
//  Copyright © 2017年 Kenta Mori. All rights reserved.
//

import UIKit

final class OptionViewItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .red
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
}

final class OptionView: UIView {
    
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/4, height: 200/3)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OptionViewItemCell.self, forCellWithReuseIdentifier: "OptionViewItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OptionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionViewItemCell", for: indexPath) as! OptionViewItemCell
        
        return cell
    }
}

extension OptionView: UICollectionViewDelegate {
    
}


final class ChatViewController: UIViewController {

    // MARK: - Properties

    var isDisplayOptionView: Bool = false
    
    // MARK: - UI
    
    fileprivate lazy var callButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tapCallButton(_:)))
        return barButtonItem
    }()
    
    fileprivate lazy var optionButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(tapOptionButton(_:)))
        return barButtonItem
    }()
    
    fileprivate lazy var optionMaskView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOptionMaskView(_:))))
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    fileprivate let optionView: OptionView = {
//        let view = UIView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 200))
        let view = OptionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.transform = CGAffineTransform(translationX: 0, y: -200)
        return view
    }()

    // MARK: - Initialization

    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Private Functions

extension ChatViewController {
    
    
    fileprivate func setupView() {
        title = "Title"
        view.backgroundColor = .white

        navigationItem.rightBarButtonItems = [optionButton, callButton]
        
        view.addSubview(optionMaskView)
        view.addSubview(optionView)

        optionMaskView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        optionMaskView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        optionMaskView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        optionMaskView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        optionView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        optionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        optionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        optionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    fileprivate func toggleOptionView() {
        let y: CGFloat = isDisplayOptionView ? -optionView.bounds.height : 0
        let alpha: CGFloat = isDisplayOptionView ? 0 : 0.2
        UIView.animate(withDuration: 0.2) {
            self.optionView.transform = CGAffineTransform(translationX: 0, y: y)
            self.optionMaskView.alpha = alpha
        }
        self.isDisplayOptionView = !self.isDisplayOptionView
    }
    
    @objc fileprivate func tapCallButton(_ sender: UIBarButtonItem) {
        print("tapCallButton")
    }
    
    @objc fileprivate func tapOptionButton(_ sender: UIBarButtonItem) {
        toggleOptionView()
    }
    
    @objc fileprivate func tapOptionMaskView(_ sender: UIGestureRecognizer) {
        toggleOptionView()
    }
}
