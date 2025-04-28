"use client"

import { useState } from "react"
import { Search, Grid, List } from "lucide-react"
import { Button } from "@/components/ui/button"
import { Input } from "@/components/ui/input"
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs"
import { useTheme } from "@/components/theme/theme-provider"
import { UserGridView } from "@/components/users/user-grid-view"
import { UserListView } from "@/components/users/user-list-view"
import { CountryCard } from "@/components/users/country-card"
import { GroupList } from "@/components/groups/group-list"
import { useGetCountriesQuery } from "@/lib/redux/api/countryApiSlice"

// Mock data for users
const usersData = [
  {
    id: "1",
    name: "Asegid Shegaw",
    group: "G5D",
    problems: 355,
    submissions: 389,
    dedicatedTime: "9.24k",
    image: "/images/profile-pic.png",
  },
  {
    id: "2",
    name: "Sifan Fita Hika",
    group: "G52",
    problems: 334,
    submissions: 337,
    dedicatedTime: "8.73k",
    image: "/images/profile-pic.png",
  },
  {
    id: "3",
    name: "Eyasu Getaneh",
    group: "G63",
    problems: 231,
    submissions: 243,
    dedicatedTime: "4.74k",
    image: "/images/profile-pic.png",
  },
  {
    id: "4",
    name: "Yigerem Bisrat Yemata",
    group: "G56",
    problems: 466,
    submissions: 470,
    dedicatedTime: "14.29k",
    rating: 1400,
    image: "/images/profile-pic.png",
  },
  {
    id: "5",
    name: "Tinsae Tadesse Anteneh",
    group: "G56",
    problems: 461,
    submissions: 465,
    dedicatedTime: "10.96k",
    rating: 1400,
    image: "/images/profile-pic.png",
  },
  {
    id: "6",
    name: "Melkishi Tesfaye Angassa",
    group: "G56",
    problems: 448,
    submissions: 450,
    dedicatedTime: "11.11k",
    rating: 1400,
    image: "/images/profile-pic.png",
  },
]

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
]

// Mock data for countries
const countriesData = [
  {
    id: "ethiopia",
    name: "Ethiopia",
    members: 996,
    problemsSolved: "1,407",
    timeSpent: "5,437,325",
    avgRating: "1,407",
    flag: "/images/flags/ethiopia.png",
    expanded: false,
    users: [
      {
        id: "e1",
        name: "Abel Gebeyehu",
        problems: 571,
        timeSpent: "12,112",
        rating: "2,284",
        image: "/images/profile-pic.png",
      },
      {
        id: "e2",
        name: "Kenenisa Alemayehu",
        problems: 156,
        timeSpent: "3,050",
        rating: "2,256",
        image: "/images/profile-pic.png",
      },
      {
        id: "e3",
        name: "Abel Ayalew",
        problems: 106,
        timeSpent: "1,747",
        rating: "2,168",
        image: "/images/profile-pic.png",
      },
      {
        id: "e4",
        name: "Kibrnew Gedamu",
        problems: 465,
        timeSpent: "13,212",
        rating: "2,150",
        image: "/images/profile-pic.png",
      },
      {
        id: "e5",
        name: "Eba Adisu Kenga",
        problems: 495,
        timeSpent: "10,815",
        rating: "2,118",
        image: "/images/profile-pic.png",
      },
    ],
  },
  {
    id: "sudan",
    name: "Sudan",
    members: 12,
    problemsSolved: "731",
    timeSpent: "154,234",
    avgRating: "1,766",
    flag: "/images/flags/sudan.png",
    expanded: false,
    users: [],
  },
  {
    id: "egypt",
    name: "Egypt",
    members: 47,
    problemsSolved: "743",
    timeSpent: "119,610",
    avgRating: "1,447",
    flag: "/images/flags/egypt.png",
    expanded: false,
    users: [],
  },
]

export default function UsersPage() {
  const [viewMode, setViewMode] = useState<"grid" | "list">("grid")
  const [activeTab, setActiveTab] = useState("users")
  const [searchQuery, setSearchQuery] = useState("")
  const [expandedCountries, setExpandedCountries] = useState<Record<string, boolean>>({})
  const { colorPreset, theme } = useTheme()

  // Fetch countries from the API
  const { data: countries, isLoading: isLoadingCountries, error: countriesError } = useGetCountriesQuery()

  const toggleCountryExpansion = (countryId: string) => {
    setExpandedCountries((prev) => ({
      ...prev,
      [countryId]: !prev[countryId],
    }))
  }

  const filteredUsers = usersData.filter((user) => user.name.toLowerCase().includes(searchQuery.toLowerCase()))

  return (
    <div className="p-4 md:p-6 w-full">
      <div className="mb-6">
        <h1 className="text-2xl font-bold dark:text-white">Groups & Users</h1>
        <div className="text-sm text-slate-500 dark:text-slate-400">All</div>
      </div>

      <Tabs defaultValue="users" className="w-full" onValueChange={setActiveTab}>
        <TabsList className="w-full justify-start mb-6 bg-transparent border-b dark:border-slate-700">
          <TabsTrigger
            value="users"
            className={`${
              activeTab === "users"
                ? "border-b-2 border-theme text-slate-900 dark:text-white"
                : "text-slate-500 dark:text-slate-400"
            } rounded-none px-4 py-2 font-medium`}
          >
            Users
          </TabsTrigger>
          <TabsTrigger
            value="groups"
            className={`${
              activeTab === "groups"
                ? "border-b-2 border-theme text-slate-900 dark:text-white"
                : "text-slate-500 dark:text-slate-400"
            } rounded-none px-4 py-2 font-medium`}
          >
            Groups
          </TabsTrigger>
          <TabsTrigger
            value="countries"
            className={`${
              activeTab === "countries"
                ? "border-b-2 border-theme text-slate-900 dark:text-white"
                : "text-slate-500 dark:text-slate-400"
            } rounded-none px-4 py-2 font-medium`}
          >
            Countries
          </TabsTrigger>
        </TabsList>

        <TabsContent value="users" className="mt-0">
          <div className="flex justify-between mb-4">
            <div className="flex gap-2">
              <div className="flex border dark:border-slate-700 rounded-md overflow-hidden">
                <Button
                  variant={viewMode === "grid" ? "default" : "ghost"}
                  size="icon"
                  className={`h-10 w-10 rounded-none ${
                    viewMode === "grid" ? "bg-theme text-white" : "bg-transparent text-slate-500 dark:text-slate-400"
                  }`}
                  onClick={() => setViewMode("grid")}
                >
                  <Grid className="h-5 w-5" />
                </Button>
                <Button
                  variant={viewMode === "list" ? "default" : "ghost"}
                  size="icon"
                  className={`h-10 w-10 rounded-none ${
                    viewMode === "list" ? "bg-theme text-white" : "bg-transparent text-slate-500 dark:text-slate-400"
                  }`}
                  onClick={() => setViewMode("list")}
                >
                  <List className="h-5 w-5" />
                </Button>
              </div>
              <div className="relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-4 w-4 text-slate-400" />
                <Input
                  type="text"
                  placeholder="Search user..."
                  className="w-full pl-9 pr-4 h-10 dark:bg-slate-800 dark:border-slate-700"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                />
              </div>
            </div>
            <div>
              <select className="border rounded-md px-3 py-2 bg-transparent dark:bg-slate-800 dark:border-slate-700 dark:text-white">
                <option>All</option>
                <option>Active</option>
                <option>Inactive</option>
              </select>
            </div>
          </div>

          {viewMode === "grid" ? <UserGridView users={filteredUsers} /> : <UserListView users={filteredUsers} />}
        </TabsContent>

        <TabsContent value="groups" className="mt-0">
          <GroupList groups={groupsData} />
        </TabsContent>

        <TabsContent value="countries" className="mt-0">
          <div className="space-y-6">
            {isLoadingCountries ? (
              <div>Loading countries...</div>
            ) : countriesError ? (
              <div>Error loading countries. Please try again later.</div>
            ) : (
              countries.map((country) => (
                <CountryCard
                  key={country.ID}
                  country={{
                    id: country.ID.toString(),
                    name: country.Name,
                    members: Math.floor(Math.random() * 1000), // Random member count
                    problemsSolved: Math.floor(Math.random() * 5000).toString(), // Random problems solved
                    timeSpent: Math.floor(Math.random() * 10000).toString(), // Random time spent
                    avgRating: (Math.random() * 1000 + 1000).toFixed(0), // Random average rating
                    flag: `/images/flags/${country.ShortCode.toLowerCase()}.png`,
                    users: [
                      {
                        id: "dummy1",
                        name: "Dummy User 1",
                        problems: 100,
                        timeSpent: "10h",
                        rating: "1500",
                        image: "/images/profile-pic.png",
                      },
                      {
                        id: "dummy2",
                        name: "Dummy User 2",
                        problems: 200,
                        timeSpent: "20h",
                        rating: "1600",
                        image: "/images/profile-pic.png",
                      },
                    ], // Dummy users for expanded data
                  }}
                  isExpanded={!!expandedCountries[country.ID]}
                  onToggle={() => toggleCountryExpansion(country.ID.toString())}
                />
              ))
            )}
          </div>
        </TabsContent>
      </Tabs>
    </div>
  )
}
