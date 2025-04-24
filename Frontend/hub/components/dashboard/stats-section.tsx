import { MiniBarChart } from "@/components/mini-chart"

interface StatsSectionProps {
  stats: {
    solutions: number
    timeSpent: number
    rating: number
  }
}

export function StatsSection({ stats }: StatsSectionProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
      <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
        <div className="flex items-center justify-between mb-2">
          <span className="text-xs text-green-500">↑ 0.0%</span>
        </div>
        <div className="text-3xl font-bold dark:text-white">{stats.solutions}</div>
        <div className="text-sm text-slate-500 dark:text-slate-400">Solutions</div>
      </div>

      <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
        <div className="flex items-center justify-between mb-2">
          <span className="text-xs text-green-500">↑ 0.0%</span>
        </div>
        <div>
          <div className="text-3xl font-bold dark:text-white">
            {stats.timeSpent.toLocaleString()}
            <span className="text-xs text-slate-500 dark:text-slate-400 ml-1">(min)</span>
          </div>
          <div className="text-xs text-slate-500 dark:text-slate-400">That's 7 Days</div>
        </div>
        <div className="text-sm text-slate-500 dark:text-slate-400">Time Spent</div>
      </div>

      <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
        <div className="flex items-center justify-between mb-2">
          <span className="text-xs text-green-500">↑ 0.0%</span>
          <div className="h-6 w-12 bg-red-100 dark:bg-red-900/20 rounded">
            <MiniBarChart color="red" />
          </div>
        </div>
        <div className="text-3xl font-bold dark:text-white">{stats.rating.toLocaleString()}</div>
        <div className="text-sm text-slate-500 dark:text-slate-400">Rating</div>
      </div>
    </div>
  )
}
