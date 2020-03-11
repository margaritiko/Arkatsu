//
//  CardColorScheme.swift
//  Arkatsu
//
//  Created by Маргарита Коннова on 13/10/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

struct CardColorScheme {
  let aColor: UIColor
  let bColor: UIColor
  let cColor: UIColor
  let othersColor: UIColor
  let backgroundColor: UIColor
  let overallColor: UIColor

  let aTextColor: UIColor
  let bTextColor: UIColor
  let cTextColor: UIColor
  let othersTextColor: UIColor

  let cardBackgroundColor: UIColor

  func getBackgroundColor(for index: Int) -> UIColor {
    switch index {
    case 0:
      return aColor
    case 1:
      return bColor
    case 2:
      return cColor
    case 3:
        return othersColor
    default:
      return othersColor
    }
  }

  func getTextColor(for index: Int) -> UIColor {
    switch index {
    case 0:
      return aTextColor
    case 1:
      return bTextColor
    case 2:
      return cTextColor
    case 3:
      return othersTextColor
    default:
      return othersTextColor
    }
  }

  static let `withRedComponent` = CardColorScheme(
    aColor: UIColor(rgb: 0x5FA8F8),
    bColor: UIColor(rgb: 0xFBE840),
    cColor: UIColor(rgb: 0xFC5AFF),
    othersColor: UIColor(rgb: 0xB0B0B0),
    backgroundColor: UIColor(red: 214, green: 214, blue: 214, alpha: 70),
    overallColor: UIColor(rgb: 0xFBE840),
    aTextColor: UIColor.white,
    bTextColor: UIColor(rgb: 0xFF4F4F),
    cTextColor: UIColor.white,
    othersTextColor: UIColor.white,
    cardBackgroundColor: UIColor(rgb: 0xD6333C)
  )

  static let `withVioletComponent` = CardColorScheme(
    aColor: UIColor(rgb: 0xFF6849),
    bColor: UIColor(rgb: 0x099a97),
    cColor: UIColor(rgb: 0xff5d9e),
    othersColor: UIColor(rgb: 0xB0B0B0),
    backgroundColor: UIColor(red: 214, green: 214, blue: 214, alpha: 70),
    overallColor: UIColor(rgb: 0xFF6849),
    aTextColor: UIColor.white,
    bTextColor: UIColor.white,
    cTextColor: UIColor.white,
    othersTextColor: UIColor.white,
    cardBackgroundColor: UIColor(rgb: 0x5849B8)
  )

  static let `withYellowComponent` = CardColorScheme(
    aColor: UIColor(rgb: 0xFBE840),
    bColor: UIColor(rgb: 0x099a97),
    cColor: UIColor(rgb: 0xff5d9e),
    othersColor: UIColor(rgb: 0xB0B0B0),
    backgroundColor: UIColor(red: 255, green: 255, blue: 255, alpha: 94),
    overallColor: UIColor(rgb: 0x55BD3B),
    aTextColor: UIColor.white,
    bTextColor: UIColor(rgb: 0x5849B8),
    cTextColor: UIColor.white,
    othersTextColor: UIColor.white,
    cardBackgroundColor: UIColor(red:0.97, green:0.80, blue:0.00, alpha:1.0)
  )

  static let `withGreenComponent` = CardColorScheme(
    aColor: UIColor(rgb: 0xFBE840),
    bColor: UIColor(rgb: 0x099a97),
    cColor: UIColor(rgb: 0xff5d9e),
    othersColor: UIColor(rgb: 0xB0B0B0),
    backgroundColor: UIColor(red: 214, green: 214, blue: 214, alpha: 70),
    overallColor: UIColor(rgb: 0xFBE840),
    aTextColor: UIColor(rgb: 0x5849B8),
    bTextColor: UIColor.white,
    cTextColor: UIColor.white,
    othersTextColor: UIColor.white,
    cardBackgroundColor: UIColor(rgb: 0x55BD3B)
  )
}
