import Foundation

struct AffirmationEngine {
    
    private static let affirmations = [
        "Awareness grows every time you practice.",
        "Confidence is built before the moment arrives.",
        "You noticed — that matters.",
        "Preparation changes outcomes.",
        "Calm thinking is a trained skill.",
        "You are learning to trust your instincts.",
        "Safety begins with attention.",
        "Small awareness becomes real strength.",
        "You reacted thoughtfully — good.",
        "Your mind is becoming sharper each day.",
        "Every practice session makes you stronger.",
        "Trust your gut — it knows before you do.",
        "Being prepared is the ultimate form of self-care.",
        "You are building habits that protect you.",
        "Awareness is your superpower.",
        "The calm mind sees clearly.",
        "You are more capable than you think.",
        "Practice today, confidence tomorrow."
    ]
    
    static func get() -> String {
        affirmations.randomElement() ?? "Stay aware. Stay calm."
    }
}
