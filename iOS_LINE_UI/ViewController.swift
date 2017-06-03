//
//  ViewController.swift
//  iOS_LINE_UI
//
//  Created by 森健太 on 2017/06/03.
//  Copyright © 2017年 Kenta Mori. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI
    
    fileprivate lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("chat", for: .normal)
        button.addTarget(self, action: #selector(tapButton(_:)), for: .touchUpInside)
        return button
    }()
    
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
extension ViewController {
    
    fileprivate func setupView() {
        title = "Main"
        
        view.backgroundColor = .white

        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @objc fileprivate func tapButton(_ sender: UIButton) {
        let vc = ChatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
