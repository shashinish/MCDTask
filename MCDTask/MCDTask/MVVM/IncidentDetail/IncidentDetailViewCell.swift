//
//  IncidentDetailViewCell.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/25/25.
//

import UIKit


class IncidentDetailViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var verticalStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubview(verticalStackView)
        
        verticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func configureCell(title: String, description: String){
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
