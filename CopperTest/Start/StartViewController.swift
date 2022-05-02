//
//  StartViewController.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit

final class StartViewController: UIViewController {

    private let viewModel: StartViewModel
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "cristal")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transactions"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSans-Semibold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Click “Download” to view transaction history"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: 0x86939E)
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hex: 0x6AEAD4)        
        let attributed = NSAttributedString(
            string: "Download",
            attributes: [NSAttributedString.Key.font: UIFont(name: "IBMPlexSans-SemiBold", size: 16)!,
                         NSAttributedString.Key.foregroundColor : UIColor.black])
        button.setAttributedTitle(attributed, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.withAlphaComponent(0.05).cgColor
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    init(viewModel: StartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let centerView = UIView()
        centerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerView)
        
        NSLayoutConstraint.activate([
            centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            centerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            centerView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        centerView.addSubviews([imageView, titleLabel, descriptionLabel, button])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: centerView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 88),
            imageView.heightAnchor.constraint(equalToConstant: 88)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28),
            titleLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            descriptionLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: centerView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: centerView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 215),
            button.heightAnchor.constraint(equalToConstant: 56)
        ])
         
    }
    
    @objc private func didTapButton() {
        viewModel.routeToOrders()
    }

}

