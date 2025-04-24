import { GroupList } from "@/components/groups/group-list"

// Mock data for groups
const groupsData = [
  {
    id: "g56",
    name: "AASTU Group 56",
    code: "G56",
    members: 23,
    timeSpent: "246,672",
    avgRating: "1,220",
  },
  {
    id: "g6r",
    name: "Group 6 Remote Ramadan Group",
    code: "G6R",
    members: 0,
    timeSpent: "0",
    avgRating: "0",
  },
  {
    id: "g60",
    name: "Ghana Group 60",
    code: "G60",
    members: 37,
    timeSpent: "54,602",
    avgRating: "1,415",
  },
  {
    id: "g6l",
    name: "Remote Group 6L",
    code: "G6L",
    members: 13,
    timeSpent: "37,196",
    avgRating: "1,398",
  },
  {
    id: "g6k",
    name: "Remote Group 6K",
    code: "G6K",
    members: 12,
    timeSpent: "33,969",
    avgRating: "1,309",
  },
  {
    id: "g6j",
    name: "Remote Group 6J",
    code: "G6J",
    members: 14,
    timeSpent: "45,105",
    avgRating: "1,359",
  },
  {
    id: "g6i",
    name: "Remote Group 6I",
    code: "G6I",
    members: 0,
    timeSpent: "0",
    avgRating: "0",
  },
  {
    id: "g6h",
    name: "Remote Group 6H",
    code: "G6H",
    members: 17,
    timeSpent: "42,500",
    avgRating: "1,320",
  },
  {
    id: "g6g",
    name: "Remote Group 6G",
    code: "G6G",
    members: 12,
    timeSpent: "38,750",
    avgRating: "1,290",
  },
]

export default function GroupsPage() {
  return (
    <div className="p-4 md:p-6 w-full">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Groups</h1>
        <div className="text-sm text-slate-500 dark:text-slate-400">All</div>
      </div>

      <GroupList groups={groupsData} />
    </div>
  )
}
