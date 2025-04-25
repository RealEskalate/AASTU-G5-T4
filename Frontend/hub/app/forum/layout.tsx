import type React from "react"
import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Forum | A2SV Hub",
  description: "Discussion forum on A2SV Hub Platform",
}

export default function ForumLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
