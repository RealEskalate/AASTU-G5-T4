import type React from "react"
import type { Metadata } from "next"
import { Inter } from "next/font/google"
import "./globals.css"
import { CollapsibleSidebar } from "@/components/layout/collapsible-sidebar"
import { Navbar } from "@/components/layout/navbar"
import { ThemeProvider } from "@/components/theme/theme-provider"
import { SettingsPanel } from "@/components/theme/settings-panel"
import { SettingsToggle } from "@/components/theme/settings-toggle"
import "./main-content-adjuster"

const inter = Inter({ subsets: ["latin"] })

export const metadata: Metadata = {
  title: "A2SV Hub",
  description: "A2SV Learning Hub Platform",
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en">
      <body className={inter.className}>
        <ThemeProvider>
          <div className="flex h-screen">
            <CollapsibleSidebar />
            <div
              className="flex-1 flex flex-col h-screen overflow-hidden transition-all duration-300"
              id="main-content"
            >
              <Navbar notificationCount={14} />
              <main className="flex-1 overflow-auto bg-slate-50 dark:bg-slate-900">
                <div className="stretch-container">{children}</div>
              </main>
            </div>
          </div>
          <SettingsToggle />
          <SettingsPanel />
        </ThemeProvider>
      </body>
    </html>
  )
}
