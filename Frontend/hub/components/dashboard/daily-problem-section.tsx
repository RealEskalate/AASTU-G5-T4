import { Button } from "@/components/ui/button"
import { Info } from "lucide-react"

interface DailyProblemProps {
  problem: {
    title: string
    platform: string
    difficulty: string
    tag: string
    solvedCount: number
  }
}

export function DailyProblemSection({ problem }: DailyProblemProps) {
  return (
    <div className="bg-green-50 dark:bg-green-900/10 rounded-lg p-6 mb-8 relative">
      <div className="flex justify-between items-start mb-2">
        <div className="flex items-center gap-2">
          <h2 className="text-lg font-semibold dark:text-white">Daily problem</h2>
          <Info className="h-4 w-4 text-slate-400" />
        </div>
        <div className="flex items-center gap-2">
          <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
            <span className="sr-only">Upvote</span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="text-slate-400"
            >
              <path d="m18 15-6-6-6 6" />
            </svg>
          </Button>
          <span className="text-sm dark:text-white">0</span>
          <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
            <span className="sr-only">Downvote</span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              className="text-slate-400"
            >
              <path d="m6 9 6 6 6-6" />
            </svg>
          </Button>
        </div>
      </div>
      <p className="text-sm text-slate-500 dark:text-slate-400 mb-4">
        Refreshes every 24 hours and needs to be solved today!
      </p>

      <h3 className="text-xl font-medium dark:text-white mb-1">{problem.title}</h3>
      <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400 mb-4">
        <span>{problem.platform}</span>
        <span>·</span>
        <span className="text-red-500">{problem.difficulty}</span>
        <span>·</span>
        <span>{problem.tag}</span>
      </div>

      <div className="flex flex-col sm:flex-row gap-2">
        <Button className="flex-1 bg-green-500 hover:bg-green-600 text-white flex items-center justify-center gap-1">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <path d="M5 12h14" />
            <path d="m12 5 7 7-7 7" />
          </svg>
          Solve It Now
        </Button>
        <Button
          variant="outline"
          className="flex-1 dark:text-white dark:border-slate-600 flex items-center justify-center gap-1"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <path d="M12 5v14" />
            <path d="M5 12h14" />
          </svg>
          New Solution
        </Button>
      </div>

      <div className="absolute top-6 right-6">
        <div className="text-3xl font-bold text-slate-300 dark:text-slate-700">{problem.solvedCount}</div>
        <div className="text-xs text-slate-400 dark:text-slate-600 text-right">Solved it</div>
      </div>
    </div>
  )
}
