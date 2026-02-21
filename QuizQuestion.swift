import Foundation

struct QuizQuestion: Identifiable {
    let id = UUID()
    let scenario: String
    let options: [String]
    let correctIndex: Int
    let explanation: String
    
    static let allQuestions: [QuizQuestion] = [
        QuizQuestion(
            scenario: "You're walking home alone at night and notice someone has been behind you for several blocks.",
            options: [
                "Ignore them and keep walking the same route",
                "Cross the street, change direction, and head toward a well-lit public place",
                "Turn around and confront them",
                "Start running immediately"
            ],
            correctIndex: 1,
            explanation: "Changing your path and heading toward a well-lit, populated area helps you confirm if you're being followed while moving to safety."
        ),
        QuizQuestion(
            scenario: "A stranger in a parking lot offers to help carry your bags to your car.",
            options: [
                "Accept — they seem friendly",
                "Politely decline and stay aware of your surroundings",
                "Ignore them completely",
                "Leave your bags and run"
            ],
            correctIndex: 1,
            explanation: "Politely declining maintains your control of the situation. Most people mean well, but trusting your instincts and maintaining boundaries keeps you safe."
        ),
        QuizQuestion(
            scenario: "You're at a coffee shop and need to use the restroom. Your laptop and bag are at your table.",
            options: [
                "Leave everything — you'll only be a minute",
                "Ask a stranger to watch your things",
                "Pack up your valuables and take them with you",
                "Just take your phone and leave the rest"
            ],
            correctIndex: 2,
            explanation: "Always take your valuables with you. It only takes seconds for items to be stolen, and asking strangers creates a false sense of security."
        ),
        QuizQuestion(
            scenario: "You're using a rideshare app. The car arrives but the license plate doesn't match the app.",
            options: [
                "Get in anyway — the driver probably just switched cars",
                "Ask the driver to confirm your name",
                "Do not get in. Verify all details match before entering any rideshare",
                "Call a friend while getting in the car"
            ],
            correctIndex: 2,
            explanation: "Never enter a rideshare that doesn't match your app details. Always verify the driver's name, photo, car model, and license plate before getting in."
        ),
        QuizQuestion(
            scenario: "You're at a party and your drink has been out of your sight for a while.",
            options: [
                "It's fine — nobody would tamper with it",
                "Smell it to check if it's been tampered with",
                "Don't drink it. Get a fresh drink and keep it with you",
                "Ask a friend to taste it first"
            ],
            correctIndex: 2,
            explanation: "If your drink has been unattended, always get a new one. Drink tampering is often undetectable by smell or taste."
        ),
        QuizQuestion(
            scenario: "Someone you recently met online wants to meet in person for the first time.",
            options: [
                "Meet at their place — it's more comfortable",
                "Meet at a public place, tell a friend your plans, and arrange your own transport",
                "Let them pick you up from home",
                "Meet wherever they suggest"
            ],
            correctIndex: 1,
            explanation: "Always meet in a public place for first meetings. Share your plans with someone you trust and maintain control of your own transportation."
        ),
        QuizQuestion(
            scenario: "You're jogging with earphones and someone approaches you aggressively.",
            options: [
                "Keep your earphones in and run faster",
                "Remove earphones, face the person, and use a firm voice to set boundaries",
                "Pretend you didn't notice them",
                "Look down and walk away quickly"
            ],
            correctIndex: 1,
            explanation: "Removing earphones shows awareness. Facing someone with confident body language and a firm voice can deter many aggressors."
        ),
        QuizQuestion(
            scenario: "You're staying at a hotel alone and someone knocks on your door claiming to be room service — but you didn't order anything.",
            options: [
                "Open the door — it might be a complimentary service",
                "Open the door slightly with the chain on",
                "Do not open. Call the front desk to verify before opening",
                "Ignore it completely"
            ],
            correctIndex: 2,
            explanation: "Always verify unexpected visitors through the hotel front desk. Never open your door to unverified people."
        ),
        QuizQuestion(
            scenario: "You notice your location is being shared with someone you don't recognize on your phone.",
            options: [
                "It's probably a glitch — ignore it",
                "Immediately turn off location sharing, review your app permissions, and change your passwords",
                "Delete the social media app",
                "Ask friends if they share your location"
            ],
            correctIndex: 1,
            explanation: "Unauthorized location sharing is a serious privacy concern. Immediately revoke access, review all app permissions, and update your security settings."
        ),
        QuizQuestion(
            scenario: "You're in an elevator and someone enters who makes you uncomfortable.",
            options: [
                "Stand in the corner and avoid eye contact",
                "Get off at the next floor, even if it's not yours",
                "Press all the buttons",
                "It's just an elevator — ignore your feelings"
            ],
            correctIndex: 1,
            explanation: "Trust your instincts. Exiting at the next floor is a simple, safe action. Your gut feeling exists to protect you — never dismiss it."
        )
    ]
    
    static func randomQuiz(count: Int = 5) -> [QuizQuestion] {
        Array(allQuestions.shuffled().prefix(count))
    }
}
