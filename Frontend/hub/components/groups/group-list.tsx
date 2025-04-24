import { GroupCard } from "@/components/groups/group-card"

interface Group {
  id: string
  name: string
  code: string
  members: number
  timeSpent: string
  avgRating: string
}

interface GroupListProps {
  groups: Group[]
}

export function GroupList({ groups }: GroupListProps) {
  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
      {groups.map((group) => (
        <GroupCard key={group.id} group={group} />
      ))}
    </div>
  )
}
