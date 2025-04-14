"use client"

import { useState } from "react"
import { useTheme } from "@/components/theme/theme-provider"

interface ConsistencyCalendarProps {
  year?: number
}

export function ConsistencyCalendar({ year = new Date().getFullYear() }: ConsistencyCalendarProps) {
  const [selectedYear, setSelectedYear] = useState(year)
  const { theme } = useTheme()

  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  const days = ["Mon", "Wed", "Fri"]

  return (
    <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
      <div className="flex justify-between items-center mb-4">
        <h2 className="text-lg font-semibold dark:text-white">Consistency</h2>
        <select
          className="border rounded px-2 py-1 text-sm dark:bg-slate-700 dark:border-slate-600 dark:text-white"
          value={selectedYear}
          onChange={(e) => setSelectedYear(Number(e.target.value))}
        >
          <option value={2025}>2025</option>
          <option value={2024}>2024</option>
        </select>
      </div>

      {/* Placeholder for consistency calendar */}
      <div className="h-40 bg-slate-50 dark:bg-slate-800 rounded flex items-center justify-center">
        <div className="relative w-full">
          {/* Month labels */}
          <div className="flex mb-2">
            <div className="w-8"></div> {/* Space for day labels */}
            <div className="flex-1 grid grid-cols-12 gap-1">
              {months.map((month, i) => (
                <div key={i} className="text-xs text-slate-500 dark:text-slate-400 text-center">
                  {month}
                </div>
              ))}
            </div>
          </div>

          {/* Calendar grid with day labels */}
          <div className="flex">
            {/* Day labels */}
            <div className="w-8 flex flex-col justify-between pr-2">
              {days.map((day, i) => (
                <div key={i} className="text-xs text-slate-500 dark:text-slate-400 h-4 flex items-center">
                  {day}
                </div>
              ))}
            </div>

            {/* Calendar cells placeholder */}
            <div className="flex-1 h-32"></div>
          </div>
        </div>
      </div>

      {/* Legend */}
      <div className="mt-4 flex items-center gap-1">
        <div className="h-3 w-3 bg-slate-200 dark:bg-slate-700 rounded-sm"></div>
        <div className="h-3 w-3 bg-green-200 dark:bg-green-900/30 rounded-sm"></div>
        <div className="h-3 w-3 bg-green-300 dark:bg-green-800/40 rounded-sm"></div>
        <div className="h-3 w-3 bg-green-500 dark:bg-green-700/60 rounded-sm"></div>
        <div className="h-3 w-3 bg-green-700 dark:bg-green-600/80 rounded-sm"></div>
      </div>
    </div>
  )
}
