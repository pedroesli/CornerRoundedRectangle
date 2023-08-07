import SwiftUI

/// A rounded rectangle where you are able to choose which corners to apply the round corner.
public struct CornerRoundedRectangle: Shape {
    
    public struct CornerSet: OptionSet {
        public var rawValue: Int8
        
        public static let topLeft = CornerSet(rawValue: 1 << 0)
        public static let topRight = CornerSet(rawValue: 1 << 1)
        public static let bottomLeft = CornerSet(rawValue: 1 << 2)
        public static let bottomRight = CornerSet(rawValue: 1 << 3)
        public static let top = CornerSet([.topLeft, .topRight])
        public static let bottom = CornerSet([.bottomLeft, .bottomRight])
        public static let leading = CornerSet([.topLeft, .bottomLeft])
        public static let trailing = CornerSet([.topRight, .bottomRight])
        public static let all = CornerSet([.topLeft, .topRight, .bottomRight, .bottomLeft])
        
        public init(rawValue: Int8) {
            self.rawValue = rawValue
        }
    }
    
    public let cornerRadius: CGFloat
    /// The edges to apply round corner
    public var edges: CornerSet = .all
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        let radius = min(min(cornerRadius, height / 2), width / 2)
        
        path.move(to: CGPoint(x: width / 2.0, y: 0))
        // Top Right
        if edges.contains(.topRight) {
            path.addLine(to: CGPoint(x: width - radius, y: 0))
            path.addArc(
                center: CGPoint(x: width - radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: -90),
                endAngle: Angle(degrees: 0),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        
        // Bottom Right
        if edges.contains(.bottomRight) {
            path.addLine(to: CGPoint(x: width, y: height - radius))
            path.addArc(
                center: CGPoint(x: width - radius, y: height - radius),
                radius: radius,
                startAngle: Angle(degrees: 0),
                endAngle: Angle(degrees: 90),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: width, y: height))
        }
        
        // Bottom Left
        if edges.contains(.bottomLeft) {
            path.addLine(to: CGPoint(x: radius, y: height))
            path.addArc(
                center: CGPoint(x: radius, y: height - radius),
                radius: radius,
                startAngle: Angle(degrees: 90),
                endAngle: Angle(degrees: 180),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: 0, y: height))
        }
        
        // Top Left
        if edges.contains(.topLeft) {
            path.addLine(to: CGPoint(x: 0, y: radius))
            path.addArc(
                center: CGPoint(x: radius, y: radius),
                radius: radius,
                startAngle: Angle(degrees: 180),
                endAngle: Angle(degrees: 270),
                clockwise: false
            )
        } else {
            path.addLine(to: CGPoint(x: 0, y: 0))
        }
        
        path.closeSubpath()
        return path
    }
}
