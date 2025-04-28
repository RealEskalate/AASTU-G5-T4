import Link from "next/link"
import Image from "next/image"
import { DataTable } from "@/components/data-table"

interface User {
  id: string
  name: string
  problems: number
  dedicatedTime: string
  rating?: number
  image: string
}

interface UserListViewProps {
  users: User[]
}

export function UserListView({ users }: UserListViewProps) {
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
                    src={user.image || "/images/profile-pic.png"}
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
            key: "problems",
            title: "Solved",
            align: "right",
          },
          {
            key: "dedicatedTime",
            title: "Time spent",
            align: "right",
          },
          {
            key: "rating",
            title: "Rating",
            align: "right",
          },
        ]}
        data={users.map((user) => ({
          person: user,
          problems: user.problems,
          dedicatedTime: user.dedicatedTime,
          rating: user.rating || "-",
          image: user.image,
          name: user.name,
          id: user.id,
        }))}
      />
    </div>
  )
}
