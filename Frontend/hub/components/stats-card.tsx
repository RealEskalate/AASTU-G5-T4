import type React from "react"
import { ArrowUp, ArrowDown } from "lucide-react"

interface StatsCardProps {
  title: string
  value: string | number
  change?: {
    value: number
    isPositive: boolean
  }
  chart?: React.ReactNode
}

export function StatsCard({ title, value, change, chart }: StatsCardProps) {
  return (
    <div className="bg-white p-4 rounded-lg shadow-sm dark:bg-slate-800 dark:border dark:border-slate-700">
      <div className="flex justify-between items-start mb-4">
        <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">{title}</h3>
        {change && (
          <div
            className={`flex items-center text-xs font-medium ${change.isPositive ? "text-green-500" : "text-red-500"}`}
          >
            {change.isPositive ? <ArrowUp className="h-3 w-3 mr-1" /> : <ArrowDown className="h-3 w-3 mr-1" />}
            {change.value.toFixed(1)}%
          </div>
        )}
      </div>
      <div className="flex justify-between items-end">
        <div className="text-3xl font-bold dark:text-white">{value.toLocaleString()}</div>
        {chart && <div className="h-10">{chart}</div>}
      </div>
    </div>
  )
}
