//
//  emojiClass.swift
//  Concentration X
//
//  Created by Pranav Patil on 2/9/19.
//  Copyright © 2019 Pranav Patil. All rights reserved.
//

import Foundation

class ChoicesOfEmoji{
    
    var emojiThemeName: String = ""
    
    /*
     YOU CAN ADD NEW EMOJI THEME BY ADDING TO THE DICTIONARY USING THE FOLLOWING:
     
     dictionaryStore["NAMEOFEMOJI"] = "" //put the emoji in the string
     */
    
    var dictionaryStore = ["Food": ["🍆", "🥕", "🍒", "🍌", "🥭", "🍏", "🍎", "🍐", "🍊", "🍋", "🍉", "🍇", "🍑"], "Faces": ["😀", "😂", "😇", "😍", "😆", "😅", "🤣", "🙂", "😜", "😚", "😉", "🙃", "😏"], "Activity": ["🚴🏻‍♂️", "⛳️", "🏑", "⚽️", "🏀", "🏈", "🥎", "🎾", "🏐", "🏉", "🥏", "🏋️‍♀️", "🎿"], "Objects": ["🧭", "📺", "📸", "☎️", "🖨", "📱", "💻", "⌚️", "🎥", "⌨️", "💰", "💵", "💳"], "Flags": ["🇧🇷", "🇦🇷", "🇩🇪", "🇺🇸", "🇬🇧", "🇷🇺", "🇮🇳", "🇯🇵", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇦🇪", "🇪🇸", "🇵🇹", "🇵🇪"]]
    //Each category above has 13 emojis
}
