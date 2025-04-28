import type React from "react"
import { Inter } from "next/font/google"
import { ThemeProvider } from "@/components/theme/theme-provider"
import { SettingsPanel } from "@/components/theme/settings-panel"
import { SettingsToggle } from "@/components/theme/settings-toggle"
import { ReduxProvider } from "@/lib/redux/provider"
import { Navbar } from "@/components/layout/navbar"
import { Sidebar } from "@/components/layout/sidebar"

const inter = Inter({ subsets: ["latin"] })

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <ReduxProvider>
      <ThemeProvider>
        <div className={inter.className} style={{ display: "flex", minHeight: "100vh" }}>
          <aside style={{ width: "250px", flexShrink: 0, backgroundColor: "#f8f9fa" }}>
            <Sidebar className="w-64 flex-shrink-0" />
          </aside>
          <main style={{ flexGrow: 1, padding: "20px" }}>
            <Navbar />
            {children}
          </main>
          <SettingsPanel />
          <SettingsToggle />
        </div>
      </ThemeProvider>
    </ReduxProvider>
  )
}
