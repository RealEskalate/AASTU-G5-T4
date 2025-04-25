"use client"

import { CompanionNotification } from "@/components/dashboard/companion-notification"
import { HeroSection } from "@/components/dashboard/hero-section"
import { StatsSection } from "@/components/dashboard/stats-section"
import { DailyProblemSection } from "@/components/dashboard/daily-problem-section"
import { LatestProblemsSection } from "@/components/dashboard/latest-problems-section"

export default function Dashboard() {
  // Mock data for stats
  const statsData = {
    solutions: 438,
    timeSpent: 10354,
    rating: 1609,
  }

  // Mock data for daily problem
  const dailyProblem = {
    title: "Find Median From Data Stream",
    platform: "LeetCode",
    difficulty: "Hard",
    tag: "Heap",
    solvedCount: 335,
  }

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      {/* Companion notification */}
      <CompanionNotification />

      {/* Hero section */}
      <HeroSection userName="Natnael" />

      {/* Stats section */}
      <StatsSection stats={statsData} />

      {/* Daily problem section */}
      <DailyProblemSection problem={dailyProblem} />

      {/* Latest problems - now using RTK Query */}
      <LatestProblemsSection />
    </div>
  )
}
