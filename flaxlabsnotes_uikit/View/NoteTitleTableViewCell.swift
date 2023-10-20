//
//  NoteTableViewCell.swift
//  flaxlabsnotes_uikit
//
//  Created by Lucas French on 10/19/23.
//

import UIKit

class NoteTitleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    let cellIconImageView: UIImageView = {
        let cellIconImageView = UIImageView()
        cellIconImageView.translatesAutoresizingMaskIntoConstraints = false
        return cellIconImageView
    }()
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    func setupSubviews() {
        setupCellIconImageView()
        setupTitleLabel()
    }
    
    let xOffset: CGFloat = 15.0
    func setupCellIconImageView() {
        let height: CGFloat = 10.0
        contentView.addSubview(cellIconImageView)
        cellIconImageView.contentMode = .scaleAspectFill
        cellIconImageView.tintColor = UIColor.black
        cellIconImageView.image = UIImage(systemName: "play")
        cellIconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: xOffset).isActive = true
        cellIconImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        cellIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        cellIconImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Avenir-Heavy", size: 17.5)
        titleLabel.textAlignment = .left
        titleLabel.leftAnchor.constraint(equalTo: cellIconImageView.rightAnchor, constant: 10.0).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -xOffset).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
    }
    
    var note: Note? {
        didSet {
            titleLabel.text = note?.title
        }
    }
    
    
}
