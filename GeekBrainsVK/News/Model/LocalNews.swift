//
//  LocalNews.swift
//  GeekBrainsVK
//
//  Created by Maksim Volkov on 20.02.2022.
//

import Foundation

class LocalNews {
    
    let nameAuthor: String
    let photoAuthor: String
    let textNews: String
    let photoNews: String
    
    init(nameAuthor: String, photoAuthor: String, textNews: String, photoNews: String) {
        self.nameAuthor = nameAuthor
        self.photoAuthor = photoAuthor
        self.textNews = textNews
        self.photoNews = photoNews
    }
    
    static func loadTestNews() -> [LocalNews] {
        return [LocalNews(nameAuthor: "Петруха", photoAuthor: "person.fill", textNews: "Test New 1", photoNews: "network"),
                LocalNews(nameAuthor: "Семеныч", photoAuthor: "person.fill", textNews: "Test New 2", photoNews: "airplane.arrival"),
                LocalNews(nameAuthor: "Юлька", photoAuthor: "person.fill", textNews: "Test New 3", photoNews: "car"),
                LocalNews(nameAuthor: "Жидкий шмель", photoAuthor: "person.fill", textNews: "Test New 4", photoNews: "tortoise"),
                LocalNews(nameAuthor: "Отадминистратор", photoAuthor: "person.fill", textNews: "Test New 5", photoNews: "ladybug")]
    }
//    let testNews = [LocalNews(nameAuthor: "Петруха", photoAuthor: "person.fill", textNews: "Test New 1", photoNews: "network"),
//                    LocalNews(nameAuthor: "Семеныч", photoAuthor: "person.fill", textNews: "Test New 2", photoNews: "airplane.arrival"),
//                    LocalNews(nameAuthor: "Юлька", photoAuthor: "person.fill", textNews: "Test New 3", photoNews: "car"),
//                    LocalNews(nameAuthor: "Жидкий шмель", photoAuthor: "person.fill", textNews: "Test New 4", photoNews: "tortoise"),
//                    LocalNews(nameAuthor: "Отадминистратор", photoAuthor: "person.fill", textNews: "Test New 5", photoNews: "ladybug")]
    
//    static func loadTestNews() -> [[String]] {
//        return [["Петруха", "person.fill", "Test New 1", "network"],
//                ["Семеныч", "person.fill", "Test New 2", "airplane.arrival"],
//                ["Юлька", "person.fill", "Test New 3", "car"],
//                ["Жидкий шмель", "person.fill", "Test New 4", "tortoise"],
//                ["Отадминистратор", "person.fill", "Test New 5", "ladybug"]]
//    }
    
//    let news1 = ["Петруха", "person.fill", "Test New 1", "network"]
//    let news2 = ["Семеныч", "person.fill", "Test New 2", "airplane.arrival"]
//    let news3 = ["Юлька", "person.fill", "Test New 3", "car"]
//    let news4 = ["Жидкий шмель", "person.fill", "Test New 4", "tortoise"]
//    let news5 = ["Отадминистратор", "person.fill", "Test New 5", "ladybug"]
}
