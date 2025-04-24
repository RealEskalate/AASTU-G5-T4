import { Calendar, Clock } from "lucide-react"

interface Group {
  id: string
  name: string
}

interface SessionProps {
  title: string
  description?: string
  status: "Ended" | "Ongoing" | "Upcoming"
  groups: Group[]
  timeAgo: string
  date: string
  timeRange: string
  hasFunding?: boolean
}

export function SessionCard({
  title,
  description,
  status,
  groups,
  timeAgo,
  date,
  timeRange,
  hasFunding = false,
}: SessionProps) {
  return (
    <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 mb-6 relative">
      <div className="flex flex-col md:flex-row md:items-start gap-4">
        <div className="flex-1">
          <div className="flex items-center gap-3 mb-2">
            <span
              className={`inline-flex items-center px-3 py-1 rounded-full text-sm font-medium ${
                status === "Ended"
                  ? "bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-300"
                  : status === "Ongoing"
                    ? "bg-green-100 text-green-800 dark:bg-green-900/30 dark:text-green-300"
                    : "bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300"
              }`}
            >
              {status}
            </span>
            <h3 className="text-lg font-medium dark:text-white">{title}</h3>
          </div>

          {description && <p className="text-sm text-slate-500 dark:text-slate-400 mb-3">{description}</p>}

          <div className="flex flex-wrap gap-2 mb-4">
            {groups.map((group) => (
              <span
                key={group.id}
                className="inline-flex items-center px-3 py-1 rounded-full text-sm bg-slate-100 text-slate-800 dark:bg-slate-700 dark:text-slate-200"
              >
                {group.name}
              </span>
            ))}
          </div>
        </div>

        <div className="text-right">
          <div className="text-xl font-bold text-green-600 dark:text-green-400">{timeAgo}</div>
          <div className="flex items-center justify-end gap-1 text-sm text-slate-500 dark:text-slate-400">
            <Calendar className="h-4 w-4" />
            <span>{date}</span>
          </div>
          <div className="flex items-center justify-end gap-1 text-sm text-slate-500 dark:text-slate-400">
            <Clock className="h-4 w-4" />
            <span>{timeRange}</span>
          </div>
        </div>

        {hasFunding && (
          <div className="absolute top-4 right-4 md:static">
            <div className="h-6 w-6 rounded-full bg-slate-200 dark:bg-slate-700 flex items-center justify-center">
              <span className="text-green-600 dark:text-green-400 text-sm">$</span>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
