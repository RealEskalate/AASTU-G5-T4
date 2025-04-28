"use client"

import { useState } from "react"
import { MoreHorizontal } from "lucide-react"
import { Button } from "@/components/ui/button"
import { SessionCard } from "@/components/sessions/session-card"

// Mock data for sessions
const sessionsData = [
  {
    id: "1",
    title: "uytutr",
    description: "giufyytd",
    status: "Ended" as const,
    groups: [
      { id: "g55", name: "AASTU Group 55" },
      { id: "g56", name: "AASTU Group 56" },
      { id: "g57", name: "AASTU Group 57" },
    ],
    timeAgo: "12d 22h 59m 51s ago",
    date: "Fri Apr 11",
    timeRange: "05:30 - 08:00",
    hasFunding: true,
  },
  {
    id: "2",
    title: "Camp II <> Fun Contest",
    status: "Ended" as const,
    groups: [
      { id: "g51", name: "AAIT Group 51" },
      { id: "g52", name: "AAIT Group 52" },
      { id: "g53", name: "AAIT Group 53" },
      { id: "g54", name: "AAIT Group 54" },
      { id: "g55", name: "AASTU Group 55" },
      { id: "g56", name: "AASTU Group 56" },
      { id: "g57", name: "AASTU Group 57" },
      { id: "g58", name: "ASTU Group 58" },
      { id: "g59", name: "ASTU Group 59" },
    ],
    timeAgo: "166d 23h 39s ago",
    date: "Fri Nov 08",
    timeRange: "05:30 - 08:00",
  },
  {
    id: "3",
    title: "Camp II <> Practice Session and Internal Interview Contest",
    status: "Ended" as const,
    groups: [
      { id: "g51", name: "AAIT Group 51" },
      { id: "g52", name: "AAIT Group 52" },
      { id: "g53", name: "AAIT Group 53" },
      { id: "g54", name: "AAIT Group 54" },
      { id: "g55", name: "AASTU Group 55" },
      { id: "g56", name: "AASTU Group 56" },
      { id: "g57", name: "AASTU Group 57" },
      { id: "g58", name: "ASTU Group 58" },
      { id: "g59", name: "ASTU Group 59" },
    ],
    timeAgo: "167d 22h 58m 19s ago",
    date: "Thu Nov 07",
    timeRange: "05:30 - 08:00",
  },
]

export default function SessionsPage() {
  const [filter, setFilter] = useState("All")

  return (
    <div className="p-4 md:p-6 max-w-5xl mx-auto">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Sessions</h1>
        <div className="text-sm text-slate-500 dark:text-slate-400">{filter}</div>
      </div>

      <div className="space-y-4">
        {sessionsData.map((session) => (
          <div key={session.id} className="relative">
            <SessionCard
              title={session.title}
              description={session.description}
              status={session.status}
              groups={session.groups}
              timeAgo={session.timeAgo}
              date={session.date}
              timeRange={session.timeRange}
              hasFunding={session.hasFunding}
            />
            <Button
              variant="ghost"
              size="icon"
              className="absolute top-4 right-4 h-8 w-8 rounded-full bg-white dark:bg-slate-800 shadow-sm"
            >
              <MoreHorizontal className="h-4 w-4" />
              <span className="sr-only">More options</span>
            </Button>
          </div>
        ))}
      </div>
    </div>
  )
}
