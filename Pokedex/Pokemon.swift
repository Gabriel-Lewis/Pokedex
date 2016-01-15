//
//  Pokemon.swift
//  Pokedex
//
//  Created by Gabriel Benbow on 1/15/16.
//  Copyright © 2016 Gabriel Benbow. All rights reserved.
//

import Foundation

class Pokemon {
	private var _name: String!
	private var _pokedexID: Int!


	var name: String {

		return _name
	}

	var pokedexID: Int {
		return _pokedexID
	}

	init(name: String, pokedexID: Int) {
		_name = name
		_pokedexID = pokedexID
	}
}