//
//  SettingsTableViewCell.swift
//  omniscient
//
//  Created by DAVIDE RISI on 24/04/22.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let identifier = "SettingsTableViewCell"
    
    //definisco il container dell'immagine
    private let iconContainer: UIView = {
        let view = UIView()
        //arrotonda i bordi
        view.clipsToBounds = true //si applica al frame
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true //si applica al layer
        return view
    }()
    
    //definisco l'immagine dell'opzione del setting
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator //freccetta a destra della cella
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        iconContainer.frame = CGRect(x: 15, y: 6, width: size, height: size)
        
        let imageSize: CGFloat = size/1.5
        iconImageView.frame = CGRect(x: (size-imageSize)/2, y: (size-imageSize)/2, width: imageSize, height: imageSize)
        
        label.frame = CGRect(x: 25 + iconContainer.frame.size.width,
                             y: 0,
                             width: contentView.frame.size.width - 20 - iconContainer.frame.size.width,
                             height: contentView.frame.size.height)
    }
    
    //quando vuoi riusare una cellView, ti resetta il contenuto
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        iconContainer.backgroundColor = nil
    }
    
    public func configure(with model: SettingsOption){
        
        label.text = model.title
        iconImageView.image = model.icon
        iconContainer.backgroundColor = model.iconBackgroundColor
        
    }
}
