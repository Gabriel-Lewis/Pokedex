//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

	@IBOutlet weak var nameLbl: UILabel!
	
	var pokemon: Pokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nameLbl.text = pokemon.name
	}
}
