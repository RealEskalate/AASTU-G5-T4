import Image from "next/image"
import Link from "next/link"
import { DataTable } from "@/components/data-table"

interface Student {
  id: string
  name: string
  problems: number
  timeSpent: string
  rating: string
  lastSeen: string
  image?: string
}

interface GroupStudentsTabProps {
  students: Student[]
}

export function GroupStudentsTab({ students }: GroupStudentsTabProps) {
  return (
    <DataTable
      columns={[
        {
          key: "name",
          title: "Name",
          render: (_, student) => (
            <div className="flex items-center gap-3">
              <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700 overflow-hidden">
                <Image
                  src={student.image || "/placeholder.svg?height=32&width=32"}
                  alt={student.name}
                  width={32}
                  height={32}
                  className="object-cover"
                />
              </div>
              <Link href={`/profile/${student.id}`} className="font-medium dark:text-white hover:text-theme">
                {student.name}
              </Link>
            </div>
          ),
        },
        {
          key: "problems",
          title: "Problems",
          align: "right",
        },
        {
          key: "timeSpent",
          title: "Time Spent",
          align: "right",
        },
        {
          key: "rating",
          title: "Rating",
          align: "right",
        },
        {
          key: "lastSeen",
          title: "Last Seen",
          align: "right",
        },
      ]}
      data={students}
    />
  )
}
