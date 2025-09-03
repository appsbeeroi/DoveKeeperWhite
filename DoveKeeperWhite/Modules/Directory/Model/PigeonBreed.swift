import Foundation

struct PigeonBreed: Identifiable, Hashable {
    let id: String
    let img: ImageResource
    let name: String
    let description: String
    let features: [String]
    var isFavorite: Bool
    
    var uuid: UUID {
        UUID.from(string: id)
    }
    
    init(id: String, img: ImageResource, name: String, description: String, features: [String], isFavorite: Bool) {
        self.id = id
        self.img = img
        self.name = name
        self.description = description
        self.features = features
        self.isFavorite = isFavorite
    }
    
    init() {
        self.id = ""
        self.img = .Images.Pigeons.img1
        self.name = "Name"
        self.description = "The Fantail pigeon is one of the most admired fancy pigeon breeds. Its iconic fan-shaped tail, usually with 30–40 feathers, creates a stunning visual effect similar to that of a peacock. White Fantails are particularly elegant, as their pure coloration emphasizes the bird’s silhouette and graceful movements. They are calm, docile, and easy to manage, which makes them popular among both beginners and experienced fanciers. Historically, Fantails have been bred for centuries as exhibition birds and often symbolize peace, love, and purity in various traditions."
        self.features = [
            "Fan-shaped tail with 30–40 feathers spread wide",
            "Elegant and upright posture with raised chest",
            "Smooth, rounded head and gentle expression",
            "Docile temperament, adapts well to aviaries",
            "Hardy and beginner-friendly",
            "Frequently used in ceremonial releases"
        ]
        self.isFavorite = false
    }
    
    static let allBreeds: [PigeonBreed] = [
        PigeonBreed(
            id: "fantail-white",
            img: .Images.Pigeons.img1,
            name: "Fantail",
            description: "The Fantail pigeon is one of the most admired fancy pigeon breeds. Its iconic fan-shaped tail, usually with 30–40 feathers, creates a stunning visual effect similar to that of a peacock. White Fantails are particularly elegant, as their pure coloration emphasizes the bird’s silhouette and graceful movements. They are calm, docile, and easy to manage, which makes them popular among both beginners and experienced fanciers. Historically, Fantails have been bred for centuries as exhibition birds and often symbolize peace, love, and purity in various traditions.",
            features: [
                "Fan-shaped tail with 30–40 feathers spread wide",
                "Elegant and upright posture with raised chest",
                "Smooth, rounded head and gentle expression",
                "Docile temperament, adapts well to aviaries",
                "Hardy and beginner-friendly",
                "Frequently used in ceremonial releases"
            ],
            isFavorite: false
        ),
        PigeonBreed(
            id: "jacobin-white",
            img: .Images.Pigeons.img2,
            name: "Jacobin",
            description: "The Jacobin pigeon is a unique and eye-catching breed known for its feathered 'hood' or collar that surrounds the head and neck. White Jacobins are especially striking, as their clean plumage enhances the dramatic appearance of their feather hood. This breed is elegant and regal but also requires extra attention to feather care due to its dense plumage. Jacobins have been bred since the 16th century and were once highly valued in royal courts. They are mostly ornamental and are cherished for their beauty rather than performance.",
            features: [
                "Dramatic feather 'hood' encircling the head and neck",
                "Graceful body and upright stance",
                "Shy and sensitive temperament",
                "Requires careful grooming and feather maintenance",
                "Historic breed with origins in Asia and Europe",
                "Primarily ornamental and exhibition-focused"
            ],
            isFavorite: false
        ),
        PigeonBreed(
            id: "king-white",
            img: .Images.Pigeons.img3,
            name: "King",
            description: "The King pigeon is a large, powerful breed developed in the United States in the late 19th century. It was originally bred for utility purposes but quickly gained popularity as a show bird due to its robust build and calm disposition. White Kings are highly sought after for exhibitions because their bright plumage highlights their muscular body and strong presence. Despite their size, they are gentle and adapt well to mixed lofts, making them suitable for both fanciers and hobbyists.",
            features: [
                "Large body with broad chest and muscular build",
                "Bright white plumage enhances their exhibition value",
                "Strong immune system and good resilience",
                "Gentle and calm nature, easy to keep",
                "Originated in the United States as a dual-purpose breed",
                "Adaptable to both aviaries and loft systems"
            ],
            isFavorite: false
        ),
        PigeonBreed(
            id: "modena-white",
            img: .Images.Pigeons.img4,
            name: "Modena",
            description: "The Modena pigeon is an Italian breed with a history that traces back centuries. Known for its proud stance and compact body, it has been bred in many color varieties, but the white Modena stands out for its clean and refined look. With a lively temperament and elegant posture, Modenas are popular in pigeon shows across Europe. They require clean housing and careful selection for exhibition standards, but their energetic and stylish presence makes them a favorite among breeders and collectors.",
            features: [
                "Compact body with upright, proud stance",
                "Striking white coloration with a sleek look",
                "Active and alert temperament",
                "Requires cleanliness in lofts for feather health",
                "Ancient Italian breed with rich history",
                "Highly valued in exhibitions and collections"
            ],
            isFavorite: false
        ),
        PigeonBreed(
            id: "oriental-frill-satinette-white",
            img: .Images.Pigeons.img5,
            name: "Oriental Frill Satinette",
            description: "The Oriental Frill is a highly decorative breed originally developed in the Middle East and further refined in Europe. The Satinette variety is particularly prized for its intricate feather patterns and delicate frills on the chest. White base Satinette pigeons are especially attractive, as the pure background color highlights the contrast of their markings. These pigeons are delicate and require attentive care, especially for their feathers, but they are among the most cherished exhibition breeds in the world.",
            features: [
                "Elegant frilled feathers on the chest",
                "Short beak and rounded head with a refined profile",
                "White base coloration with contrasting patterns",
                "Requires delicate feather care and maintenance",
                "Ornamental breed with strong exhibition value",
                "Originated in the Middle East, refined in Europe"
            ],
            isFavorite: false
        ),
        PigeonBreed(
            id: "texan-white",
            img: .Images.Pigeons.img6,
            name: "Texan",
            description: "The Texan pigeon, developed in the United States, is known for its excellent health, fertility, and calm temperament. Originally created as a utility breed, Texans are also appreciated as ornamental pigeons because of their striking appearance. White Texans are valued for their clean and bright plumage, which emphasizes their solid build. They are easy to breed, adapt well to different conditions, and are very friendly, making them a favorite choice for both utility breeders and hobbyists.",
            features: [
                "Strong resistance to climate changes and diseases",
                "Friendly, calm, and easy to tame",
                "Low maintenance in feeding and housing",
                "High fertility and good breeding capabilities",
                "Developed in the United States as a utility breed",
                "Popular among hobbyists for their gentle nature"
            ],
            isFavorite: false
        )
    ]
}
