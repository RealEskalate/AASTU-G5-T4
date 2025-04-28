import Link from "next/link"
import { CalendarIcon, UsersIcon } from "lucide-react"

interface ContestCardProps {
  id: number
  index: number
  name: string
  problemCount: number
  timeAgo: string
  isRated?: boolean
}

export function ContestCard({ id, index, name, problemCount, timeAgo, isRated = true }: ContestCardProps) {
  return (
    <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 mb-4 border border-slate-200 dark:border-slate-700 hover:border-blue-300 dark:hover:border-blue-700 transition-colors">
      <div className="flex justify-between items-start">
        <div>
          <Link
            href={`/contests/${id}`}
            className="text-lg font-semibold text-blue-600 dark:text-blue-400 hover:underline"
          >
            {index}. {name}
          </Link>
          <div className="flex items-center gap-4 mt-2 text-sm text-slate-600 dark:text-slate-400">
            <div className="flex items-center gap-1">
              <UsersIcon className="h-4 w-4" />
              <span>{problemCount} problems</span>
            </div>
            <div className="flex items-center gap-1">
              <CalendarIcon className="h-4 w-4" />
              <span>{timeAgo}</span>
            </div>
            {!isRated && <span className="text-amber-600 dark:text-amber-400">unrated</span>}
          </div>
        </div>
      </div>
    </div>
  )
}
