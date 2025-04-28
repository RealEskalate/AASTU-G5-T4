import type React from "react"
import type { Metadata } from "next"

export const metadata: Metadata = {
  title: "Roadmap | A2SV Hub",
  description: "Learning roadmap on A2SV Hub Platform",
}

export default function RoadmapLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return children
}
