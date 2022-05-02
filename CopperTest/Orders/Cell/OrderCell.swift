//
//  OrderCell.swift
//  CopperTest
//
//  Created by Vadim Chistiakov on 26.04.2022.
//

import UIKit

final class OrderCell: UICollectionViewCell {
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x86939E)
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x86939E)
        label.textAlignment = .right
        label.font = UIFont(name: "IBMPlexSans-Regular", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .clear
        let border = UIView()
        border.translatesAutoresizingMaskIntoConstraints = false
        border.backgroundColor = .white.withAlphaComponent(0.05)
        
        contentView.addSubviews([currencyLabel, dateLabel, amountLabel, statusLabel, border])
        [currencyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
         currencyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
         currencyLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
        
         dateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
         dateLabel.topAnchor.constraint(equalTo: currencyLabel.bottomAnchor, constant: 4),
         dateLabel.rightAnchor.constraint(equalTo: contentView.centerXAnchor),
        
         amountLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor),
         amountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
         amountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -17),
        
         statusLabel.leftAnchor.constraint(equalTo: contentView.centerXAnchor),
         statusLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
         statusLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
        
         border.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
         border.rightAnchor.constraint(equalTo: contentView.rightAnchor),
         border.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
         border.heightAnchor.constraint(equalToConstant: 1)].forEach { $0.isActive = true }
    }
    
    func configure(with viewModel: OrderCellViewModel) {
        currencyLabel.text = viewModel.currency
        dateLabel.text = viewModel.date
        amountLabel.text = viewModel.amount
        statusLabel.text = viewModel.status
    }
}
