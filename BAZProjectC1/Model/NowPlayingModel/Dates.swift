//  Dates.swift
//  BAZProjectC1
//  Created by 291732 on 21/09/22.

import Foundation

struct Dates : Codable {
	let maximum : String?
	let minimum : String?

	enum CodingKeys: String, CodingKey {
		case maximum = "maximum"
		case minimum = "minimum"
	}

}
