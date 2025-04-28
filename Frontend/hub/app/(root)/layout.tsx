import type React from "react"
import { Sidebar } from "@/components/layout/sidebar"
import { Navbar } from "@/components/layout/navbar"
import { ThemeProvider } from "@/components/theme/theme-provider"
import { SettingsPanel } from "@/components/theme/settings-panel"
import { SettingsToggle } from "@/components/theme/settings-toggle"
import { ReduxProvider } from "@/lib/redux/provider"


export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <ReduxProvider>
      <ThemeProvider>
        <div className={`flex min-h-screen `}>
          {/* Desktop sidebar - hidden on mobile */}
          <div className="hidden md:block w-[220px] shrink-0">
            <Sidebar />
          </div>

          {/* Main content area */}
          <div className="flex-1 flex flex-col min-h-screen">
            <Navbar />
            <main className="flex-1 overflow-auto bg-slate-50 dark:bg-slate-900">{children}</main>
          </div>
        </div>
        <SettingsToggle />
        <SettingsPanel />
      </ThemeProvider>
    </ReduxProvider>
  )
}
