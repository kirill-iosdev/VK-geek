//
//  TextNewsTableViewCell.swift
//  VK-Launcher
//
//  Created by Kirill on 29.05.2022.
//

import UIKit

class TextNewsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var textNewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure() {
        textNewsLabel.text = """
IT-специалист — это представитель одной из более чем 500 цифровых профессий, связанных с разработкой программ и использованием компьютерной техники. Глобализация сделала сферу IT одной из самых высокооплачиваемых: российским компаниям приходится конкурировать с зарубежными за хороших специалистов. Экономика и повседневная жизнь все больше переходит в «цифру», поэтому у IT-сферы многообещающие перспективы.
"""
    }
}
