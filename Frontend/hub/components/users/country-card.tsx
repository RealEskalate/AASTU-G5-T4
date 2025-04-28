"use client"
import Image from "next/image"
import Link from "next/link"
import { ChevronDown, ChevronRight } from "lucide-react"
import { DataTable } from "@/components/data-table"

interface CountryUser {
  id: string
  name: string
  problems: number
  timeSpent: string
  rating: string
  image: string
}

interface Country {
  id: string
  name: string
  members: number
  problemsSolved: string
  timeSpent: string
  avgRating: string
  flag: string
  users: CountryUser[]
}

interface CountryCardProps {
  country: Country
  isExpanded: boolean
  onToggle: () => void
}

export function CountryCard({ country, isExpanded, onToggle }: CountryCardProps) {
  // Map country ID to flag image
  const getFlagImage = (countryId: string) => {
    switch (countryId) {
      case "ethiopia":
        return "/images/flags/ethiopia.png"
      case "sudan":
        return "/images/flags/sudan.png"
      case "egypt":
        return "/images/flags/egypt.png"
      default:
        return "/placeholder.svg?height=60&width=120"
    }
  }

  return (
    <div className="space-y-4">
      <div
        className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden cursor-pointer"
        onClick={onToggle}
      >
        <div className="relative">
          <div className="h-24 bg-slate-100 dark:bg-slate-700 relative overflow-hidden">
            <Image
              src={getFlagImage(country.id) || "/placeholder.svg"}
              alt={country.name}
              fill
              className="object-cover opacity-30"
            />
          </div>
          <div className="absolute inset-0 p-4 flex flex-col justify-between">
            <div className="flex justify-between items-start">
              <div>
                <h3 className="text-lg font-medium dark:text-white">{country.name}</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">{country.members} Members</p>
              </div>
              <div>
                {isExpanded ? (
                  <ChevronDown className="h-5 w-5 text-slate-500 dark:text-slate-400" />
                ) : (
                  <ChevronRight className="h-5 w-5 text-slate-500 dark:text-slate-400" />
                )}
              </div>
            </div>
            <div className="grid grid-cols-3 gap-4">
              <div className="text-center">
                <p className="text-lg font-bold text-green-500 dark:text-green-400">{country.problemsSolved}</p>
                <p className="text-xs text-slate-500 dark:text-slate-400">Problems Solved</p>
              </div>
              <div className="text-center">
                <p className="text-lg font-bold text-green-500 dark:text-green-400">{country.timeSpent}</p>
                <p className="text-xs text-slate-500 dark:text-slate-400">Total time spent</p>
              </div>
              <div className="text-center">
                <p className="text-lg font-bold text-green-500 dark:text-green-400">{country.avgRating}</p>
                <p className="text-xs text-slate-500 dark:text-slate-400">Average rating</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      {isExpanded && country.users.length > 0 && (
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
              key: "timeSpent",
              title: "Time spent",
              align: "right",
            },
            {
              key: "rating",
              title: "Rating",
              align: "right",
            },
          ]}
          data={country.users}
        />
      )}
    </div>
  )
}