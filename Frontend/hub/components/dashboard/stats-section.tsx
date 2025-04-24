import { MiniBarChart } from "@/components/mini-chart"
import { StatsCard } from "@/components/stats-card"

interface StatsSectionProps {
  stats: {
    solutions: number
    timeSpent: number
    rating: number
  }
}

export function StatsSection({ stats }: StatsSectionProps) {
  return (
    <>
      {/* Stats cards - desktop view */}
      <div className="hidden md:grid grid-cols-3 gap-6 mb-8">
        <StatsCard
          title="Solutions"
          value={stats.solutions}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="blue" />}
        />
        <StatsCard
          title="Time Spent"
          value={stats.timeSpent}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="blue" />}
        />
        <StatsCard
          title="Rating"
          value={stats.rating}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="red" />}
        />
      </div>

      {/* Stats cards - mobile view */}
      <div className="md:hidden space-y-4 mb-8">
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Solutions</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">{stats.solutions.toLocaleString()}</span>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Time Spent</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">
              {stats.timeSpent.toLocaleString()}
              <span className="text-xs text-slate-500 dark:text-slate-400 ml-1">(min)</span>
            </span>
          </div>
          <div className="text-xs text-slate-500 dark:text-slate-400">
            That's {Math.floor(stats.timeSpent / 1440)} Days
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Rating</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">{stats.rating.toLocaleString()}</span>
          </div>
        </div>
      </div>
    </>
  )
}
