/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Result : Codable {
	let resource_id : String?
	let fields : [Fields]?
	let records : [Records]?
//	let _links : _links?
	let limit : Int?
	let total : Int?

	enum CodingKeys: String, CodingKey {

		case resource_id = "resource_id"
		case fields = "fields"
		case records = "records"
//		case _links = "_links"
		case limit = "limit"
		case total = "total"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		resource_id = try values.decodeIfPresent(String.self, forKey: .resource_id)
		fields = try values.decodeIfPresent([Fields].self, forKey: .fields)
		records = try values.decodeIfPresent([Records].self, forKey: .records)
//		_links = try values.decodeIfPresent(_links.self, forKey: ._links)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
	}

}
