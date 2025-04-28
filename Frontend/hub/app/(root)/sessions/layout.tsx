import type React from "react"
import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Sessions | A2SV Hub",
  description: "View all sessions on A2SV Learning Hub Platform",
}

export default function SessionsLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
