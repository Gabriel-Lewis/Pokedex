//
//  PokeCell.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
	@IBOutlet weak var thumbImg: UIImageView!
	@IBOutlet weak var nameLbl: UILabel!
	
	var pokemon: Pokemon!
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		//layer.cornerRadius = 1.0
	}
	
	func configureCell(pokemon: Pokemon) {
		self.pokemon = pokemon
		
		nameLbl.text = self.pokemon.name.capitalizedString
		thumbImg.image = UIImage(named:"\(self.pokemon.pokedexID)")
		
	}
}
