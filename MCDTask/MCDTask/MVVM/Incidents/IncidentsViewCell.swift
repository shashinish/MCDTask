//
//  IncidentsViewCell.swift
//  MCDTask
//
//  Created by Shashi Nishantha on 7/23/25.
//

import UIKit
import SnapKit
import SDWebImage

class IncidentsViewCell: UITableViewCell {
    
    
    private lazy var incidentTypeIconImageView: UIImageView = {
        let imageView = UIImageView.init(frame: .zero)
        return imageView
    }()
    
    
    private lazy var incidentLastUpdatedDateLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
        
    private lazy var incidentTitleLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var incidentStatusLabel: UILabel = {
        let label = UILabel.init(frame: .zero)
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private lazy var statusView: UIView = {
        var view = UIView(frame: .zero)
        view.addSubview(incidentStatusLabel)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var statusOuterView: UIView = {
        var view = UIView(frame: .zero)
        view.addSubview(statusView)
        return view
    }()
    
    private lazy var verticalStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [incidentLastUpdatedDateLabel, incidentTitleLabel, statusOuterView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [incidentTypeIconImageView, verticalStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(horizontalStackView)
        
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        incidentTypeIconImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
        
        incidentStatusLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        statusView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
        }
    }
    
    func configureCell(incident: Incident){
        
        incidentLastUpdatedDateLabel.text = incident.lastUpdatedDateString
        incidentTitleLabel.text = incident.title
        incidentStatusLabel.text = incident.IncidentStatus.rawValue
        statusView.backgroundColor = incident.IncidentStatus.labelBackgroundColor
        
        guard let imageUrl = URL.init(string: incident.typeIcon) else { return }
        incidentTypeIconImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        incidentTypeIconImageView.sd_setImage(with: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

