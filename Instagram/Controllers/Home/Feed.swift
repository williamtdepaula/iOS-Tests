//
//  Feed.swift
//  Instagram
//
//  Created by William Tristão de Pauloa on 19/10/21.
//

import Foundation

struct Feed {
    let userName: String
    let userProfilePic: String
    let posts: [PostContent]
    let description: String
    var liked: Bool
}

struct PostContent {
    let file: String
    var height: Double
}

let dataToUse: [Feed] = [
    Feed(
        userName: "William Tristão",
        userProfilePic: "will",
        posts: [
            PostContent(file: "post2", height: 500),
            PostContent(file: "post3", height: 250)
        ],
        description: "Que lugar maravilhoso de se estar",
        liked: false
    ),
    Feed(
        userName: "Afonso de Mendes pires",
        userProfilePic: "will",
        posts: [
            PostContent(file: "post1", height: 350),
            PostContent(file: "post2", height: 500)
        ],
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pulvinar vehicula libero, ut imperdiet ante tincidunt sed. Nulla vitae massa eu nisi eleifend facilisis. Vestibulum vitae convallis quam. Phasellus euismod porta erat ac pharetra. Etiam at tempor diam. Nunc et accumsan neque. Fusce ut massa felis. Curabitur vel semper dui.",
        liked: false
    ),
    Feed(
        userName: "Joana de Paula",
        userProfilePic: "will",
        posts: [
            PostContent(file: "post1", height: 350)
        ],
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec pulvinar vehicula libero, ut imperdiet ante tincidunt sed.",
        liked: false
    )
]
