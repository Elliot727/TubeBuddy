import SwiftUI

enum TubeLine: String, CaseIterable, Identifiable {

    var id: String { rawValue }

    case circle
    case central
    case piccadilly
    case jubilee
    case victoria
    case district
    case northern
    case bakerloo
    case metropolitan
    case hammersmithCity = "hammersmith-city"
    case waterlooCity = "waterloo-city"
    case elizabeth

    case lioness
    case mildmay
    case windrush
    case weaver
    case suffragette
    case liberty
    case dlr

    var string: String {
        switch self {
        case .circle: return "Circle"
        case .central: return "Central"
        case .piccadilly: return "Piccadilly"
        case .jubilee: return "Jubilee"
        case .victoria: return "Victoria"
        case .district: return "District"
        case .northern: return "Northern"
        case .bakerloo: return "Bakerloo"
        case .metropolitan: return "Metropolitan"
        case .hammersmithCity: return "Hammersmith & City"
        case .waterlooCity: return "Waterloo & City"
        case .elizabeth: return "Elizabeth"
        case .lioness: return "Lioness"
        case .mildmay: return "Mildmay"
        case .windrush: return "Windrush"
        case .weaver: return "Weaver"
        case .suffragette: return "Suffragette"
        case .liberty: return "Liberty"
        case .dlr: return "DLR"
        }
    }

    var color: Color {
        switch self {
        case .bakerloo: return Color(hex: "#B26300")
        case .central: return Color(hex: "#DC241F")
        case .hammersmithCity: return Color(hex: "#F589A6")
        case .jubilee: return Color(hex: "#838D93")
        case .piccadilly: return Color(hex: "#0019A8")
        case .victoria: return Color(hex: "#039BE5")
        case .circle: return Color(hex: "#FFC80A")
        case .metropolitan: return Color(hex: "#9B0058")
        case .waterlooCity: return Color(hex: "#76D0BD")
        case .district: return Color(hex: "#007D32")
        case .northern: return Color(hex: "#000000")
        case .elizabeth: return Color(hex: "#6950A1")
        case .liberty: return Color(hex: "#5D6061")
        case .mildmay: return Color(hex: "#0077AD")
        case .weaver: return Color(hex: "#823A62")
        case .lioness: return Color(hex: "#FAA61A")
        case .suffragette: return Color(hex: "#5BBD72")
        case .windrush: return Color(hex: "#ED1B00")
        case .dlr: return Color(hex: "#00AFAD")
        }
    }

    var textColor: Color {
        switch self {
        case .circle, .hammersmithCity, .waterlooCity, .lioness:
            return .black
        default:
            return .white
        }
    }
}

