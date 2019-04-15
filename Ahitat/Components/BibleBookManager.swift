//
//  BibleBook.swift
//  Ahitat
//
//  Created by Daniel Szasz on 4/14/19.
//  Copyright © 2019 Daniel Szasz. All rights reserved.
//

import Foundation

class BibleBookManager {
    class func getAbbreviation(book: String) -> String {
        switch book {
        case "1Móz":
            return "GEN"
        case "2Móz":
            return "EXO"
        case "3Móz":
            return "LEV"
        case "4Móz":
            return "NUM"
        case "5Móz":
            return "DEU"
        case "Józs":
            return "JOS"
        case "Bír":
            return "JDG"
        case "Rúth":
            return "RUT"
        case "1Sám":
            return "1SA"
        case "2Sám":
            return "2SA"
        case "1Kir":
            return "1KI"
        case "2Kir":
            return "2KI"
        case "1Krón":
            return "1CH"
        case "2Krón":
            return "2CH"
        case "Ezsd":
            return "EZR"
        case "Neh":
            return "NEH"
        case "Eszt":
            return "EST"
        case "Jób":
            return "JOB"
        case "Zsolt":
            return "PSA"
        case "Péld":
            return "PRO"
        case "Préd":
            return "ECC"
        case "ÉnÉn", "Énekek":
            return "SNG"
        case "Ézs":
            return "ISA"
        case "Jer":
            return "JER"
        case "JSir":
            return "LAM"
        case "Ez":
            return "EZK"
        case "Dán":
            return "DAN"
        case "Hós":
            return "HOS"
        case "Jóel":
            return "JOL"
        case "Ám":
            return "AMO"
        case "Abd":
            return "OBA"
        case "Jón":
            return "JON"
        case "Mik":
            return "MIC"
        case "Náh":
            return "NAM"
        case "Hab":
            return "HAB"
        case "Zof":
            return "ZEP"
        case "Hag":
            return "HAG"
        case "Zak":
            return "ZEC"
        case "Mal":
            return "MAL"

        case "Mt":
            return "MAT"
        case "Mk":
            return "MRK"
        case "Lk":
            return "LUK"
        case "Jn":
            return "JHN"
        case "ApCsel":
            return "ACT"
        case "Róm":
            return "ROM"
        case "1Kor":
            return "1CO"
        case "2Kor":
            return "2CO"
        case "Gal":
            return "GAL"
        case "Ef":
            return "EPH"
        case "Fil":
            return "PHP"
        case "Kol":
            return "COL"
        case "1Thessz":
            return "1TH"
        case "2Thessz":
            return "2TH"
        case "1Tim":
            return "1TI"
        case "2Tim":
            return "2TI"
        case "Tit":
            return "TIT"
        case "Filem":
            return "PHM"
        case "Zsid":
            return "HEB"
        case "Jak":
            return "JAS"
        case "1Pt":
            return "1PE"
        case "2Pt":
            return "2PE"
        case "1Jn":
            return "1JN"
        case "2Jn":
            return "2JN"
        case "3Jn":
            return "3JN"
        case "Júd":
            return "JUD"
        case "Jel":
            return "REV"
        default:
            return ""
        }
    }
}
