import SwiftUI

struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(Palette.ink)
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .frame(minHeight: 44)
            .background(
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Palette.backgroundElevated.opacity(configuration.isPressed ? 0.9 : 0.75))
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Palette.ice.opacity(0.22), lineWidth: 1)
                    )
            )
            .glassEffect()
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut(duration: 0.16), value: configuration.isPressed)
    }
}

struct PlatformTile: View {
    let platform: PlatformLink

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: platform.symbolName)
                .frame(width: 28, height: 28)
                .foregroundStyle(Palette.neon)
            VStack(alignment: .leading, spacing: 4) {
                Text(platform.title)
                    .font(.headline)
                    .foregroundStyle(Palette.ink)
                Text(platform.subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Palette.muted)
            }
            Spacer()
            Image(systemName: "arrow.up.forward")
                .foregroundStyle(Palette.ice)
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 88, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Palette.backgroundElevated.opacity(0.84))
                .overlay(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .stroke(Palette.ice.opacity(0.15), lineWidth: 1)
                )
        )
        .glassEffect()
    }
}
