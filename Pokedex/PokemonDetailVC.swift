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
	@IBOutlet weak var mainIMG: UIImageView!
	@IBOutlet weak var descriptionLbl: UILabel!
	@IBOutlet weak var typeLbl: UILabel!
	@IBOutlet weak var defenseLbl: UILabel!
	@IBOutlet weak var attackLbl: UILabel!
	@IBOutlet weak var weightLbl: UILabel!
	@IBOutlet weak var heightLbl: UILabel!
	@IBOutlet weak var currentEvoImage: UIImageView!
	@IBOutlet weak var nextEvoImage: UIImageView!
	@IBOutlet weak var pokedexIDLbl: UILabel!
	@IBOutlet weak var evoLabel: UILabel!
	
	var pokemon: Pokemon!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		nameLbl.text = pokemon.name
		mainIMG.image = UIImage(named: "\(pokemon.pokedexID)")
		
		pokemon.downloadPokemonDetails { () -> () in
		}
	}
	@IBAction func backBtnPressed(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
}
