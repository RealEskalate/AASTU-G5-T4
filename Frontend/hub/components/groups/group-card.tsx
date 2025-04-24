import Link from "next/link"

interface Group {
  id: string
  name: string
  code: string
  members: number
  timeSpent: string
  avgRating: string
}

interface GroupCardProps {
  group: Group
}

export function GroupCard({ group }: GroupCardProps) {
  return (
    <Link
      href={`/groups/${group.id}`}
      className="bg-white dark:bg-slate-800 rounded-lg shadow-sm p-4 hover:shadow-md transition-shadow"
    >
      <div className="mb-4">
        <h3 className="text-lg font-medium dark:text-white">{group.name}</h3>
        <p className="text-sm text-slate-500 dark:text-slate-400">
          {group.code} • {group.members} Members
        </p>
      </div>
      <div className="grid grid-cols-2 gap-2">
        <div>
          <p className="text-xs text-slate-500 dark:text-slate-400">Time Spent</p>
          <p className="font-medium dark:text-white">{group.timeSpent}</p>
        </div>
        <div>
          <p className="text-xs text-slate-500 dark:text-slate-400">Avg. Rating</p>
          <p className="font-medium dark:text-white">{group.avgRating}</p>
        </div>
      </div>
    </Link>
  )
}
