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

  // Mock data for latest problems
  const latestProblems = [
    {
      difficulty: "Hard",
      name: "F - White Collar - Au revoir (goodbye until we meet again.)",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "E - Naruto - Hidden Leaf Story: The Perfect Day for a Wedding",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "D - Impostors - See You Soon, Macaroon",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "C - The big bang theory - The Stockholm Syndrome",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "B - Friends - The Last One",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
  ]

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

      {/* Latest problems */}
      <LatestProblemsSection problems={latestProblems} />
    </div>
  )
}
