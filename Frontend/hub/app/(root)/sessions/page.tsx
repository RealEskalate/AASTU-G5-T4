"use client"

import { useState } from "react"
import { MoreHorizontal } from "lucide-react"
import { Button } from "@/components/ui/button"
import { useGetSessionsQuery } from "@/lib/redux/api/sessionApiSlice"
import { Badge } from "@/components/ui/badge"

export default function SessionsPage() {
  const [filter, setFilter] = useState("All")

  // Fetch sessions data
  const { data: sessionsResponse, isLoading, error } = useGetSessionsQuery()

  // Format date and time
  const formatDate = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleDateString("en-US", { weekday: "short", month: "short", day: "numeric" })
  }

  const formatTime = (dateString: string) => {
    const date = new Date(dateString)
    return date.toLocaleTimeString("en-US", { hour: "2-digit", minute: "2-digit" })
  }

  // Calculate time ago
  const getTimeAgo = (dateString: string) => {
    const date = new Date(dateString)
    const now = new Date()
    const diffMs = now.getTime() - date.getTime()

    const diffDays = Math.floor(diffMs / (1000 * 60 * 60 * 24))
    const diffHours = Math.floor((diffMs % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
    const diffMinutes = Math.floor((diffMs % (1000 * 60 * 60)) / (1000 * 60))
    const diffSeconds = Math.floor((diffMs % (1000 * 60)) / 1000)

    return `${diffDays}d ${diffHours}h ${diffMinutes}m ${diffSeconds}s ago`
  }

  // Determine session status
  const getSessionStatus = (startTime: string, endTime: string) => {
    const now = new Date()
    const start = new Date(startTime)
    const end = new Date(endTime)

    if (now < start) return "Upcoming"
    if (now >= start && now <= end) return "Ongoing"
    return "Ended"
  }

  if (isLoading) {
    return (
      <div className="p-4 md:p-6 max-w-5xl mx-auto">
        <div className="mb-6">
          <h1 className="text-2xl font-bold dark:text-white">Sessions</h1>
          <div className="text-sm text-slate-500 dark:text-slate-400">{filter}</div>
        </div>

        <div className="space-y-4">
          {[1, 2, 3].map((i) => (
            <div key={i} className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 animate-pulse">
              <div className="flex flex-col md:flex-row gap-4">
                <div className="flex-1">
                  <div className="flex items-center gap-3 mb-2">
                    <div className="h-6 w-20 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                    <div className="h-6 w-40 bg-slate-200 dark:bg-slate-700 rounded"></div>
                  </div>
                  <div className="h-4 w-full max-w-md bg-slate-200 dark:bg-slate-700 rounded mb-4"></div>
                  <div className="flex flex-wrap gap-2 mb-4">
                    <div className="h-6 w-24 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                    <div className="h-6 w-24 bg-slate-200 dark:bg-slate-700 rounded-full"></div>
                  </div>
                </div>
                <div className="text-right">
                  <div className="h-6 w-32 bg-slate-200 dark:bg-slate-700 rounded ml-auto mb-2"></div>
                  <div className="h-4 w-24 bg-slate-200 dark:bg-slate-700 rounded ml-auto mb-1"></div>
                  <div className="h-4 w-24 bg-slate-200 dark:bg-slate-700 rounded ml-auto"></div>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="p-4 md:p-6 max-w-5xl mx-auto">
        <div className="mb-6">
          <h1 className="text-2xl font-bold dark:text-white">Sessions</h1>
          <div className="text-sm text-slate-500 dark:text-slate-400">{filter}</div>
        </div>

        <div className="bg-white dark:bg-slate-800 rounded-lg p-8 text-center">
          <h2 className="text-xl font-bold mb-2 dark:text-white">Error loading sessions</h2>
          <p className="text-slate-500 dark:text-slate-400">
            There was a problem loading the sessions. Please try again later.
          </p>
          <Button className="mt-4" onClick={() => window.location.reload()}>
            Retry
          </Button>
        </div>
      </div>
    )
  }

  const sessions = sessionsResponse?.data || []

  return (
    <div className="p-4 md:p-6 max-w-5xl mx-auto">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Sessions</h1>
        <div className="text-sm text-slate-500 dark:text-slate-400">{filter}</div>
      </div>

      <div className="space-y-4">
        {sessions.length === 0 ? (
          <div className="bg-white dark:bg-slate-800 rounded-lg p-8 text-center">
            <h2 className="text-xl font-bold mb-2 dark:text-white">No sessions found</h2>
            <p className="text-slate-500 dark:text-slate-400">There are no sessions available at the moment.</p>
          </div>
        ) : (
          sessions.map((session) => {
            const status = getSessionStatus(session.StartTime, session.EndTime)
            const timeAgo = getTimeAgo(session.CreatedAt)
            const startDate = formatDate(session.StartTime)
            const startTime = formatTime(session.StartTime)
            const endTime = formatTime(session.EndTime)

            return (
              <div key={session.ID} className="relative bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4">
                <div className="flex flex-col md:flex-row gap-4">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <Badge
                        className={
                          status === "Ongoing" ? "bg-green-500" : status === "Upcoming" ? "bg-blue-500" : "bg-slate-500"
                        }
                      >
                        {status}
                      </Badge>
                      <h2 className="text-lg font-semibold dark:text-white">{session.Name}</h2>
                    </div>
                    {session.Description && (
                      <p className="text-sm text-slate-600 dark:text-slate-300 mb-4">{session.Description}</p>
                    )}
                    <div className="flex flex-wrap gap-2 mb-4">
                      {session.ResourceLink && (
                        <Badge variant="outline" className="text-xs">
                          Resources available
                        </Badge>
                      )}
                      {session.MeetLink && (
                        <Badge variant="outline" className="text-xs">
                          Meet link available
                        </Badge>
                      )}
                      {session.RecordingLink && (
                        <Badge variant="outline" className="text-xs">
                          Recording available
                        </Badge>
                      )}
                    </div>
                  </div>
                  <div className="text-right">
                    <div className="text-sm text-slate-500 dark:text-slate-400 mb-2">{timeAgo}</div>
                    <div className="text-sm font-medium dark:text-white">{startDate}</div>
                    <div className="text-sm text-slate-500 dark:text-slate-400">
                      {startTime} - {endTime}
                    </div>
                  </div>
                </div>
                <Button
                  variant="ghost"
                  size="icon"
                  className="absolute top-4 right-4 h-8 w-8 rounded-full bg-white dark:bg-slate-800 shadow-sm"
                >
                  <MoreHorizontal className="h-4 w-4" />
                  <span className="sr-only">More options</span>
                </Button>
              </div>
            )
          })
        )}
      </div>
    </div>
  )
}
