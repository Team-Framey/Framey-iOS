import ResoureKit
import SwiftUI

extension AppBar {
  public init(
    center: () -> Center,
    trailing: () -> Trailing
  ) where Leading == EmptyView {
    self.init(
      leading: { EmptyView() },
      center: center,
      trailing: trailing
    )
  }

  public init(
    leading: () -> Leading,
    trailing: () -> Trailing
  ) where Center == EmptyView {
    self.init(
      leading: leading,
      center: { EmptyView() },
      trailing: trailing
    )
  }

  public init(
    leading: () -> Leading,
    center: () -> Center
  ) where Trailing == EmptyView {
    self.init(
      leading: leading,
      center: center,
      trailing: { EmptyView() }
    )
  }

  public init(
    leading: () -> Leading
  ) where Center == EmptyView, Trailing == EmptyView {
    self.init(
      leading: leading,
      center: { EmptyView() },
      trailing: { EmptyView() }
    )
  }

  public init(
    center: () -> Center
  ) where Leading == EmptyView, Trailing == EmptyView {
    self.init(
      leading: { EmptyView() },
      center: center,
      trailing: { Trailing() }
    )
  }

  public init(
    title: String,
    leading: () -> Leading,
    trailing: () -> Trailing
  ) where Center == AppBarTitle {
    self.init(
      leading: leading,
      center: { AppBarTitle(title) },
      trailing: trailing
    )
  }

  public init(
    title: String,
    subtitle: String,
    leading: () -> Leading,
    trailing: () -> Trailing
  ) where Center == AppBarTitle {
    self.init(
      leading: leading,
      center: { AppBarTitle(title, subtitle: subtitle) },
      trailing: trailing
    )
  }

  public init(
    title: String,
    back: @escaping () -> Void,
    trailing: () -> Trailing
  ) where Center == AppBarTitle, Leading == AppBarIconButton {
    self.init(
      leading: { AppBarIconButton(icon: .chevronLeft, action: back) },
      center: { AppBarTitle(title) },
      trailing: trailing
    )
  }

  public init(
    title: String,
    back: @escaping () -> Void
  ) where Center == AppBarTitle, Leading == AppBarIconButton, Trailing == EmptyView {
    self.init(
      leading: { AppBarIconButton(icon: .chevronLeft, action: back) },
      center: { AppBarTitle(title) },
      trailing: { EmptyView() }
    )
  }

  public init(
    back: @escaping () -> Void,
    center: () -> Center,
    trailing: () -> Trailing
  ) where Leading == AppBarIconButton {
    self.init(
      leading: { AppBarIconButton(icon: .chevronLeft, action: back) },
      center: center,
      trailing: trailing
    )
  }

  public init(
    back: @escaping () -> Void,
    center: () -> Center
  ) where Leading == AppBarIconButton, Trailing == EmptyView {
    self.init(
      leading: { AppBarIconButton(icon: .chevronLeft, action: back) },
      center: center,
      trailing: { EmptyView() }
    )
  }
}
