import Link from "next/link"
import Image from "next/image"
import { DataTable } from "@/components/data-table"
import type { User } from "@/lib/redux/api/types"

interface UserListViewProps {
  users: User[]
  isLoading?: boolean
}

export function UserListView({ users, isLoading = false }: UserListViewProps) {
  if (isLoading) {
    return (
      <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
        <div className="p-4 animate-pulse">
          <div className="h-8 bg-slate-200 dark:bg-slate-700 rounded mb-4"></div>
          {[...Array(5)].map((_, i) => (
            <div key={i} className="flex items-center gap-3 mb-4">
              <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700"></div>
              <div className="h-6 w-40 bg-slate-200 dark:bg-slate-700 rounded"></div>
              <div className="ml-auto flex gap-4">
                <div className="h-6 w-16 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-24 bg-slate-200 dark:bg-slate-700 rounded"></div>
                <div className="h-6 w-16 bg-slate-200 dark:bg-slate-700 rounded"></div>
              </div>
            </div>
          ))}
        </div>
      </div>
    )
  }

  if (!users || users.length === 0) {
    return (
      <div className="bg-white dark:bg-slate-800 rounded-lg p-8 text-center">
        <p className="text-slate-500 dark:text-slate-400">No users found.</p>
      </div>
    )
  }

  return (
    <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
      <DataTable
        columns={[
          {
            key: "person",
            title: "Person",
            render: (_, user) => (
              <div className="flex items-center gap-3">
                <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden">
                  <Image
                    src={user.AvatarURL || "/images/profile-pic.png"}
                    alt={user.name}
                    width={32}
                    height={32}
                    className="object-cover"
                  />
                </div>
                <Link href={`/profile/${user.id}`} className="font-medium dark:text-white hover:text-theme">
                  {user.name}
                </Link>
              </div>
            ),
          },
          {
            key: "university",
            title: "University",
            render: (_, user) => <span>{user.university || "N/A"}</span>,
          },
          {
            key: "language",
            title: "Language",
            align: "right" as const,
            render: (_, user) => <span>{user.preferred_language || "N/A"}</span>,
          },
          {
            key: "group",
            title: "Group",
            align: "right" as const,
            render: (_, user) => <span>Group {user.group_id || "N/A"}</span>,
          },
        ]}
        data={users}
      />
    </div>
  )
}
