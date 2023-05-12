//
//  LatestMock.swift
//  converterTests
//
//  Created by Frqnck  on 12/05/2023.
//

import Foundation

enum ExchangeMock {
    
    static var data = """
    {
      "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
      "license": "https://openexchangerates.org/license",
      "timestamp": 1683889200,
      "base": "USD",
      "rates": {
        "AED": 3.672095,
        "AFN": 88.264648,
        "ALL": 101.312986,
        "AMD": 388.221442,
        "ANG": 1.802375,
        "AOA": 509.24,
        "ARS": 228.9918,
        "AUD": 1.495682,
        "AWG": 1.8025,
        "AZN": 1.7,
        "BAM": 1.790763,
        "BBD": 2,
        "BDT": 107.401845,
        "BGN": 1.792012,
        "BHD": 0.376962,
        "BIF": 2082.284762,
        "BMD": 1,
        "BND": 1.328456,
        "BOB": 6.91016,
        "BRL": 4.930799,
        "BSD": 1,
        "BTC": 0.000037932454,
        "BTN": 82.117353,
        "BWP": 13.44217,
        "BYN": 2.524275,
        "BZD": 2.015923,
        "CAD": 1.349281,
        "CDF": 2045,
        "CHF": 0.893376,
        "CLF": 0.028816,
        "CLP": 795.13,
        "CNH": 6.9608,
        "CNY": 6.9496,
        "COP": 4556.995218,
        "CRC": 536.272126,
        "CUC": 1,
        "CUP": 25.75,
        "CVE": 100.955928,
        "CZK": 21.6534,
        "DJF": 178.06994,
        "DKK": 6.830581,
        "DOP": 54.570263,
        "DZD": 135.873,
        "EGP": 30.9058,
        "ERN": 15,
        "ETB": 54.554762,
        "EUR": 0.916986,
        "FJD": 2.21295,
        "FKP": 0.797843,
        "GBP": 0.797843,
        "GEL": 2.575,
        "GGP": 0.797843,
        "GHS": 11.781241,
        "GIP": 0.797843,
        "GMD": 59.8,
        "GNF": 8595.823751,
        "GTQ": 7.801055,
        "GYD": 211.51655,
        "HKD": 7.841575,
        "HNL": 24.571795,
        "HRK": 6.907184,
        "HTG": 146.506523,
        "HUF": 339.936498,
        "IDR": 14812.796902,
        "ILS": 3.644433,
        "IMP": 0.797843,
        "INR": 82.175045,
        "IQD": 1310.06177,
        "IRR": 42275,
        "ISK": 137.63,
        "JEP": 0.797843,
        "JMD": 154.511049,
        "JOD": 0.7094,
        "JPY": 134.663,
        "KES": 137,
        "KGS": 87.3042,
        "KHR": 4122.03762,
        "KMF": 451.149989,
        "KPW": 900,
        "KRW": 1335.611428,
        "KWD": 0.306612,
        "KYD": 0.833486,
        "KZT": 444.632497,
        "LAK": 17529.709771,
        "LBP": 15136.378432,
        "LKR": 311.981675,
        "LRD": 166.74998,
        "LSL": 19.002435,
        "LYD": 4.763976,
        "MAD": 10.081856,
        "MDL": 17.800024,
        "MGA": 4395.862009,
        "MKD": 56.402306,
        "MMK": 2100.150786,
        "MNT": 3519,
        "MOP": 8.074275,
        "MRU": 34.382926,
        "MUR": 45.35,
        "MVR": 15.36,
        "MWK": 1026.577737,
        "MXN": 17.600415,
        "MYR": 4.479,
        "MZN": 63.850001,
        "NAD": 19.17,
        "NGN": 462.569179,
        "NIO": 36.578555,
        "NOK": 10.670832,
        "NPR": 131.38704,
        "NZD": 1.604338,
        "OMR": 0.384912,
        "PAB": 1,
        "PEN": 3.655966,
        "PGK": 3.536079,
        "PHP": 55.826498,
        "PKR": 296.274508,
        "PLN": 4.158328,
        "PYG": 7195.780992,
        "QAR": 3.641,
        "RON": 4.523,
        "RSD": 107.521277,
        "RUB": 77.260003,
        "RWF": 1118.063249,
        "SAR": 3.750556,
        "SBD": 8.334311,
        "SCR": 13.119428,
        "SDG": 600,
        "SEK": 10.310295,
        "SGD": 1.334015,
        "SHP": 0.797843,
        "SLL": 17665,
        "SOS": 568.50852,
        "SRD": 37.5,
        "SSP": 130.26,
        "STD": 22823.990504,
        "STN": 22.432405,
        "SVC": 8.750549,
        "SYP": 2512.53,
        "SZL": 18.98623,
        "THB": 33.99,
        "TJS": 10.920927,
        "TMT": 3.51,
        "TND": 3.045,
        "TOP": 2.348432,
        "TRY": 19.589,
        "TTD": 6.792961,
        "TWD": 30.7768,
        "TZS": 2358,
        "UAH": 36.936832,
        "UGX": 3725.663926,
        "USD": 1,
        "UYU": 38.947242,
        "UZS": 11466.138371,
        "VES": 25.147676,
        "VND": 23460.413462,
        "VUV": 118.979,
        "WST": 2.72551,
        "XAF": 601.503554,
        "XAG": 0.04189974,
        "XAU": 0.00049843,
        "XCD": 2.70255,
        "XDR": 0.741185,
        "XOF": 601.503554,
        "XPD": 0.00063809,
        "XPF": 109.425568,
        "XPT": 0.00091845,
        "YER": 250.350066,
        "ZAR": 19.215874,
        "ZMW": 18.27671,
        "ZWL": 322
      }
    }
    """.data(using: .utf8)
    
    static var dateOutdated = """
    {
      "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
      "license": "https://openexchangerates.org/license",
      "timestamp": 0,
      "base": "USD",
      "rates": {
        "AED": 3.672095,
        "AFN": 88.264648,
        "ALL": 101.312986,
        "AMD": 388.221442,
        "ANG": 1.802375,
        "AOA": 509.24,
        "ARS": 228.9918,
        "AUD": 1.495682,
        "AWG": 1.8025,
        "AZN": 1.7,
        "BAM": 1.790763,
        "BBD": 2,
        "BDT": 107.401845,
        "BGN": 1.792012,
        "BHD": 0.376962,
        "BIF": 2082.284762,
        "BMD": 1,
        "BND": 1.328456,
        "BOB": 6.91016,
        "BRL": 4.930799,
        "BSD": 1,
        "BTC": 0.000037932454,
        "BTN": 82.117353,
        "BWP": 13.44217,
        "BYN": 2.524275,
        "BZD": 2.015923,
        "CAD": 1.349281,
        "CDF": 2045,
        "CHF": 0.893376,
        "CLF": 0.028816,
        "CLP": 795.13,
        "CNH": 6.9608,
        "CNY": 6.9496,
        "COP": 4556.995218,
        "CRC": 536.272126,
        "CUC": 1,
        "CUP": 25.75,
        "CVE": 100.955928,
        "CZK": 21.6534,
        "DJF": 178.06994,
        "DKK": 6.830581,
        "DOP": 54.570263,
        "DZD": 135.873,
        "EGP": 30.9058,
        "ERN": 15,
        "ETB": 54.554762,
        "EUR": 0.916986,
        "FJD": 2.21295,
        "FKP": 0.797843,
        "GBP": 0.797843,
        "GEL": 2.575,
        "GGP": 0.797843,
        "GHS": 11.781241,
        "GIP": 0.797843,
        "GMD": 59.8,
        "GNF": 8595.823751,
        "GTQ": 7.801055,
        "GYD": 211.51655,
        "HKD": 7.841575,
        "HNL": 24.571795,
        "HRK": 6.907184,
        "HTG": 146.506523,
        "HUF": 339.936498,
        "IDR": 14812.796902,
        "ILS": 3.644433,
        "IMP": 0.797843,
        "INR": 82.175045,
        "IQD": 1310.06177,
        "IRR": 42275,
        "ISK": 137.63,
        "JEP": 0.797843,
        "JMD": 154.511049,
        "JOD": 0.7094,
        "JPY": 134.663,
        "KES": 137,
        "KGS": 87.3042,
        "KHR": 4122.03762,
        "KMF": 451.149989,
        "KPW": 900,
        "KRW": 1335.611428,
        "KWD": 0.306612,
        "KYD": 0.833486,
        "KZT": 444.632497,
        "LAK": 17529.709771,
        "LBP": 15136.378432,
        "LKR": 311.981675,
        "LRD": 166.74998,
        "LSL": 19.002435,
        "LYD": 4.763976,
        "MAD": 10.081856,
        "MDL": 17.800024,
        "MGA": 4395.862009,
        "MKD": 56.402306,
        "MMK": 2100.150786,
        "MNT": 3519,
        "MOP": 8.074275,
        "MRU": 34.382926,
        "MUR": 45.35,
        "MVR": 15.36,
        "MWK": 1026.577737,
        "MXN": 17.600415,
        "MYR": 4.479,
        "MZN": 63.850001,
        "NAD": 19.17,
        "NGN": 462.569179,
        "NIO": 36.578555,
        "NOK": 10.670832,
        "NPR": 131.38704,
        "NZD": 1.604338,
        "OMR": 0.384912,
        "PAB": 1,
        "PEN": 3.655966,
        "PGK": 3.536079,
        "PHP": 55.826498,
        "PKR": 296.274508,
        "PLN": 4.158328,
        "PYG": 7195.780992,
        "QAR": 3.641,
        "RON": 4.523,
        "RSD": 107.521277,
        "RUB": 77.260003,
        "RWF": 1118.063249,
        "SAR": 3.750556,
        "SBD": 8.334311,
        "SCR": 13.119428,
        "SDG": 600,
        "SEK": 10.310295,
        "SGD": 1.334015,
        "SHP": 0.797843,
        "SLL": 17665,
        "SOS": 568.50852,
        "SRD": 37.5,
        "SSP": 130.26,
        "STD": 22823.990504,
        "STN": 22.432405,
        "SVC": 8.750549,
        "SYP": 2512.53,
        "SZL": 18.98623,
        "THB": 33.99,
        "TJS": 10.920927,
        "TMT": 3.51,
        "TND": 3.045,
        "TOP": 2.348432,
        "TRY": 19.589,
        "TTD": 6.792961,
        "TWD": 30.7768,
        "TZS": 2358,
        "UAH": 36.936832,
        "UGX": 3725.663926,
        "USD": 1,
        "UYU": 38.947242,
        "UZS": 11466.138371,
        "VES": 25.147676,
        "VND": 23460.413462,
        "VUV": 118.979,
        "WST": 2.72551,
        "XAF": 601.503554,
        "XAG": 0.04189974,
        "XAU": 0.00049843,
        "XCD": 2.70255,
        "XDR": 0.741185,
        "XOF": 601.503554,
        "XPD": 0.00063809,
        "XPF": 109.425568,
        "XPT": 0.00091845,
        "YER": 250.350066,
        "ZAR": 19.215874,
        "ZMW": 18.27671,
        "ZWL": 322
      }
    }
    """.data(using: .utf8)
    
    static var smallList = """
    {
      "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
      "license": "https://openexchangerates.org/license",
      "timestamp": 0,
      "base": "USD",
      "rates": {
        "GMD": 59.8,
        "ZWL": 322,
        "AED": 3.672095,
      }
    }
    """.data(using: .utf8)
}
