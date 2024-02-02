import Cocoa
import Foundation
import AppKit

var greeting = "Hello, playground"

print("---Algorithm 1--")
/*
 Each day, to enter their building, employees
 of an e-commerce company have to type a
 string or numbers into a console using a 3 x
 3 numeric keypad. Every day, the numbers
 on the keypad are mixed up
 Use the following rules to calculate the total
 amount of time it takes to type a string:
 It takes O seconds to move their finger to the
 first kev, and It takes U seconds to press the
 key where their finger is located any numbe
 or times.
 They can move their Tingel
 from one
 location to any adjacent key in one second
 Adjacent keys Include those on a diagonal.
 Moving to a non-adjacent key is done as ¿
 series of moves to adiacent keys
 
 This diagram depicts the minimum amount
 of time it takes to move from the current
 location to all other locations on the keypad.
    
    Function Description
 Comolete the function entrytime in the
 editor below.
 
 entryTime has the following parameter(s):
  - string S: the string to type
  - string keypad: a string of 9 digits where
 each group of 3 digits represents a row on
 the keypad of the day, in order
 
    • Returns
 int: integer denoting the minimum
 amount of time it takes to type the string s.
    
    Constraints
 1 <= S <= 10^5
 |keypad| =9
 keypad[i] € [1-9]
 */

func entryTime(s: String, keypad: String) -> Int {
    let range = 1...Int(1.0e5)
    let digits = CharacterSet.decimalDigits
    let keypadSet = CharacterSet(charactersIn: keypad)
    let stringSet = CharacterSet(charactersIn: s)
    
    guard range.contains(s.count),
          keypad.count == 9,
          digits.isSuperset(of: keypadSet),
          digits.isSuperset(of: stringSet) else {
        print("input overflow")
        return 0
    }
    
    var result: Int = 0
    
    var keypadMatrix = [Character : (Int, Int)]()
    let dimension = 3
    
    for (i, cur) in keypad.enumerated() {
        let x: Int = abs(i / dimension)
        let y: Int = i % dimension
        keypadMatrix[cur] = (x, y)
        print("\(cur) on \(x) \(y)")
    }
    
    var index = s.startIndex

    var startTime = CFAbsoluteTimeGetCurrent()

    repeat { // less efficient by time 0.0008159875869750977
        let nextIndex = s.index(index, offsetBy: 1)

        guard let curXY = keypadMatrix[s[index]],
              let nextXY = keypadMatrix[s[nextIndex]] else {
            break }

        print("cur: \(curXY), next: \(nextXY)")

        if abs(curXY.0 - nextXY.0) == 2 || abs(curXY.1 - nextXY.1) == 2 {
            result += 2
            print(2)
        } else if abs(curXY.0 - nextXY.0) == 1 || abs(curXY.1 - nextXY.1) == 1 {
            result += 1
            print(1)
        } else if curXY.0 == nextXY.0 || curXY.1 == nextXY.1 {
            result += 0
            print(0)
        }

        index = s.index(after: index)
    } while (s.index(index, offsetBy: 1) != s.endIndex)

    var elapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("time: \(elapsed)")

    startTime = CFAbsoluteTimeGetCurrent()
    
    for index in s.indices { // MORE efficient by time 0.0006819963455200195
        let nextIndex = s.index(index, offsetBy: 1)
        
        if nextIndex == s.endIndex { break }
        
        guard let curXY = keypadMatrix[s[index]],
              let nextXY = keypadMatrix[s[nextIndex]] else {
            break }

        print("cur: \(curXY), next: \(nextXY)")
        
        if abs(curXY.0 - nextXY.0) == 2 || abs(curXY.1 - nextXY.1) == 2 {
            result += 2
            print(2)
        } else if abs(curXY.0 - nextXY.0) == 1 || abs(curXY.1 - nextXY.1) == 1 {
            result += 1
            print(1)
        } else if curXY.0 == nextXY.0 || curXY.1 == nextXY.1 {
            result += 0
            print(0)
        }
    }
    
    elapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("time 2: \(elapsed)")

    return result
}

let input1 = "5111"
let keypad1 = "752961348"
print(entryTime(s: input1, keypad: keypad1))

let input2 = "91566165"
let keypad2 = "639485712"
print(entryTime(s: input2, keypad: keypad2))

let input3 = "423692"
let keypad3 = "923857614"
print(entryTime(s: input3, keypad: keypad3))

let input5 = "rydik3"
let keypad5 = "923857614"
print(entryTime(s: input5, keypad: keypad5))

let input4 = "423692"
let keypad4 = "92385761455"
print(entryTime(s: input4, keypad: keypad4))

let input6 = "423692423692423692238931401830"
let keypad6 = "923857614"
print(entryTime(s: input6, keypad: keypad6))

print("---Algorithm 2--")

/* Two strings are anagrams if they are
permutations of each other. In other words,
both strings have the same size and the
same characters. For example, 'aaagmnrs" IS
an anagram of "anagrams". Given an array
of strings, remove each string that is an
anagram of an earlier string, then return the
remaining array in sorted order.
    Example:
str = ['code', 'doce', 'ecod', 'framer', 'frame']
 
 - "code and doce" are anagrams. Remove
"doce" trom the arrav and keep the first
occurrence "code" in the arrav.
 - "code" and "ecod" are anagrams. Remove
"ecod" from the array and keep the Tirst
occurrence "code"' in the array.
 - "code" and "framer" are not anagrams. Keep
both strings in the array.
 - "framer" and "frame" are not anagrams due
to the extra r in tramer. Keeo both strings
in the arrav.
 
• Order the remaining strings In ascending
order: ["code" "frame" "framer").
 
    Function Description
Complete the function fun WithAnagrams in the editor below.
funWithAnagrams has the following parameters:
 
 string text[n]: an array of strings
 
    Returns:
 string[m]: an array of the remaining
 strings in ascending alphabetical order
 
    Constraints:
 0 <= n <= 1000
 0 <= m <= n
 1 < length of text[i] < 1000
 Each string text[i] is made up of characters in the range ascii[a-z].
*/

func funwithAnagrams (text: [String]) -> [String] {
    let range = 1...1000
    let res: Bool = text.reduce(true, { result, str in
        result && CharacterSet.lowercaseLetters.isSuperset(of: CharacterSet(charactersIn: str))
    })
    
    guard range.contains(text.count),
          res,
          var first = text.first
    else {
        print("input error")
        return []
    }
    
    var startTime = CFAbsoluteTimeGetCurrent()

    var result: [String] = [first]
    var letterCount = first.reduce(into: [:]) { counts, letter in
        counts[letter, default: 0] += 1
    }
    
    for index in 1..<text.count { // MORE efficient by time 0.0015670061111450195
        let anagram = text[index]
        
        let anagramLetterCount = anagram.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
        }

        if !(anagramLetterCount == letterCount) {
            first = anagram
            letterCount = anagramLetterCount
            result.append(anagram)
        }
    }
    
    var elapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("time: \(elapsed)")

    first = text.first!
    startTime = CFAbsoluteTimeGetCurrent()
    // ALMOST SAME less efficient by time 0.0015790462493896484

    result = [first]

    letterCount = first.reduce(into: [:]) { counts, letter in
        counts[letter, default: 0] += 1
    }
    result.append(contentsOf: text.compactMap { anagram in
        
        let anagramLetterCount = anagram.reduce(into: [:]) { counts, letter in
            counts[letter, default: 0] += 1
        }

        if !(anagramLetterCount == letterCount) {
            first = anagram
            letterCount = anagramLetterCount
            return anagram
        }
        return nil
    })
    
    elapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("time 2: \(elapsed)")
    
    return result.sorted()
}

let testStr = ["code", "doce", "ecod", "framer", "frame"]
print(funwithAnagrams(text: testStr))

let testStr1 = ["code", "aaagmnrs","anagrams", "doce"]
print(funwithAnagrams(text: testStr1))

print(funwithAnagrams(text: []))

let testStr3 = ["code23", "aaagmnrs","anagrams", "doce"]
print(funwithAnagrams(text: testStr3))

let testStr4 = ["codeAF", "aaagmnrs"]
print(funwithAnagrams(text: testStr4))

print("---Algorithm 3---")
/*
 Bucket fill
 
 Digital graphics tools often make available a
 "bucket fill" tool that will only paint adjacent
 cels. In one fill a moditied bucket tool
 recolors adjacent cells (connected
 horizontally or vertically but not diagonally)
 that have the same color. Given a picture
 reoresented as a 2-dimensional arrav or
 letters representing colors, find the
 minimum number of fills to completely
 
    Example
 picture= ["abba", "abba", "aaacb"]
 
 Each string represents a row of the picture
 and each letter represents a cell's color. The
 diagram below shows the 5 fills needed to
 repaint the picture. It takes two fills each for
 a and b, and one for c. The array picture is
 shown below
 
    Function Description
 Complete the function strokesRequired in
 the editor below.
 
 strokesRequired has the following
 parameter(s):
 
 string picture[h]: an array of strings where
 each string represents one row of the
 picture to be painted
 
    Output:
 int: the minimum number of fills required to repaint the picture
 
    Constraints
 h and w refer to height and width of the graph
 1 <= h <= 10^5
 1 <= w <= 10^5
 1 <= h * w <= 10^5
 length(picture[i]) = w (where O <= i < h)
 picture[i][j] is in the set {'a', 'b', 'c'}
 where 0 <= i < h , 0 <= j < w
 
 */
func strokesRequired(picture: [String]) -> Int {
    let h = picture.count
    let range = 1...Int(1.0e5)
    let charSet = CharacterSet.lowercaseLetters
    
    guard let w = picture.first?.count,
          range.contains(h),
          range.contains(w),
          range.contains(h * w),
          picture.reduce(true, { $0 && $1.count == w && charSet.isSuperset(of: CharacterSet(charactersIn: $1)) })
    else {
        print("input error")
        return 0
    }
    
    let row: [Character] = .init(repeating: " ", count: w)
    var pic: [[Character]] = .init(repeating: row, count: h)
    for (row, str) in picture.enumerated() {
        let charArray = Array(str)
        print(charArray.count)
        for pos in 0..<w {
            pic[row][pos] = charArray[pos]
        }
    }
    print(pic)

    var visited: [[Bool]] = .init(repeating: .init(repeating: false, count: w), count: h)

    func isSafe(row: Int, position: Int) -> Bool {
        // check if correct indexes and if already visited element
        row >= 0 && row < h && position >= 0 && position < w &&
        visited[row][position] == false
    }
    
    func BFS(row: Int, position: Int, char: Character) {
        
        if isSafe(row: row, position: position) {
            print(char)
            // mark current as visited
            if pic[row][position] == char {
                visited[row][position] = true
                print("\(row), \(position)")
                
                let neighbours = [(0, 1), (1, 0), (0, -1), (-1,0)] // check right, below, left, up
                
                // check neighbours
                for (i, j) in neighbours {
                    BFS(row: row + i, position: position + j, char: char)
                }
            }
        }
    }
    
    //countIslands
    var result = 0
    var currentChar: Character
    for row in 0..<h {
        for position in 0..<w {
            currentChar = pic[row][position]
            // find connected area
            if !visited[row][position] {
                BFS(row: row, position: position, char:currentChar)
                result += 1
            }
        }
    }
    
    return result
}

let picture = ["aabba", "aabba", "aaacb"]
assert(strokesRequired(picture: picture) == 5)
print(strokesRequired(picture: picture))

let picture2 = ["bbba", "abba", "acaa", "aaac"]
assert(strokesRequired(picture: picture2) == 4)
print(strokesRequired(picture: picture2))

let picture3 = ["23bbba", "abba", "acaa", "aaac"]
print(strokesRequired(picture: picture3))

let picture4 = ["Bbba", "abba", "acaa", "aaac"]
print(strokesRequired(picture: picture4))

print(strokesRequired(picture: []))

print(strokesRequired(picture: ["a"]))
