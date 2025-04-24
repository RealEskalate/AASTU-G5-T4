"use client"

import { useState } from "react"
import Image from "next/image"
import Link from "next/link"
import { MapPin, Mail, Code, Users, Building, ArrowUp, ArrowDown } from "lucide-react"
import { Button } from "@/components/ui/button"
import { AttendanceGrid } from "@/components/attendance-grid"
import { ConsistencyCalendar } from "@/components/consistency-calendar"
import { ProfileLinks } from "@/components/profile-links"
import { DataTable, DifficultyBadge, ExternalLinkButton } from "@/components/data-table"
import { useTheme } from "@/components/theme/theme-provider"

// Mock data for users
const usersData = {
  "1": {
    id: "1",
    name: "Asegid Shegaw",
    title: "Student",
    group: "G5D",
    problems: 355,
    submissions: 389,
    dedicatedTime: "9.24k",
    image: "/placeholder.svg?height=80&width=80",
    about:
      "Hi, I'm Asegid Shegaw, a 4th-year Software Engineering student at AASTU (Addis Ababa Science and Technology University). I am a hardworking and resilient individual with a passion for technology and problem solving.",
    location: "Ethiopia",
    email: "asegid.shegaw@a2sv.org",
    language: "Python",
    university: "Addis Ababa Science and Technology University (AASTU)",
    rating: 1609,
    division: "Knight III",
    nextDivision: "Knight II",
    links: [
      { platform: "LinkedIn", url: "https://www.linkedin.com/in/asegid-shegaw/", icon: null },
      { platform: "Telegram", url: "https://t.me/asegid", icon: null },
      { platform: "Leetcode", url: "https://leetcode.com/asegid", icon: null },
      { platform: "Codeforces", url: "https://codeforces.com/profile/asegid", icon: null },
      { platform: "Github", url: "https://github.com/asegid", icon: null },
    ],
  },
  "2": {
    id: "2",
    name: "Sifan Fita Hika",
    title: "Student",
    group: "G52",
    problems: 334,
    submissions: 337,
    dedicatedTime: "8.73k",
    image: "/placeholder.svg?height=80&width=80",
    about:
      "Hi, I'm Sifan Fita, a 3rd-year Computer Science student. I enjoy competitive programming and solving algorithmic challenges.",
    location: "Ethiopia",
    email: "sifan.fita@a2sv.org",
    language: "C++",
    university: "Addis Ababa University",
    rating: 1520,
    division: "Knight II",
    nextDivision: "Knight I",
    links: [
      { platform: "LinkedIn", url: "https://www.linkedin.com/in/sifan-fita/", icon: null },
      { platform: "Telegram", url: "https://t.me/sifan", icon: null },
      { platform: "Leetcode", url: "https://leetcode.com/sifan", icon: null },
      { platform: "Github", url: "https://github.com/sifan", icon: null },
    ],
  },
}

// Mock data for attendance
const generateMockAttendanceData = () => {
  const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  const data = []

  for (let i = 0; i < 100; i++) {
    const month = months[Math.floor(Math.random() * 12)]
    const day = Math.floor(Math.random() * 28) + 1
    const hour = Math.floor(Math.random() * 12) + 1
    const minute = Math.floor(Math.random() * 60)
    const ampm = Math.random() > 0.5 ? "AM" : "PM"

    data.push({
      date: `${day} ${month}`,
      time: `${hour}:${minute.toString().padStart(2, "0")} ${ampm}`,
      status: Math.random() > 0.98 ? "absent" : Math.random() > 0.95 ? "excused" : "present",
    })
  }

  return data
}

// Mock data for problems
const problemsData = [
  {
    difficulty: "Easy",
    name: "Insertion Sort",
    tag: "Sorting",
    solved: "-",
    added: "1y",
    vote: 1,
    link: "#",
  },
  {
    difficulty: "Easy",
    name: "Sorting the Sentence",
    tag: "Sorting",
    solved: "-",
    added: "1y",
    vote: 6,
    link: "#",
  },
  {
    difficulty: "Easy",
    name: "How Many Numbers Are Smaller Than the Current Number",
    tag: "Array, Hash Table",
    solved: "-",
    added: "1y",
    vote: 0,
    link: "#",
  },
  {
    difficulty: "Easy",
    name: "Find Target Indices After Sorting Array",
    tag: "Sorting",
    solved: "-",
    added: "1y",
    vote: 3,
    link: "#",
  },
  {
    difficulty: "Medium",
    name: "Sort Colors",
    tag: "Sorting",
    solved: "-",
    added: "1y",
    vote: 2,
    link: "#",
  },
]

// Mock data for submissions
const submissionsData = [
  {
    name: "F-OR Encryption",
    time_spent: 8,
    tries: 1,
    language: "Python",
    in_contest: 1,
    added: "2mo",
  },
  {
    name: "My Calendar I",
    time_spent: 19,
    tries: 3,
    language: "Python",
    in_contest: 0,
    added: "5mo",
  },
  {
    name: "Reach a Number",
    time_spent: 45,
    tries: 2,
    language: "Python",
    in_contest: 0,
    added: "5mo",
  },
  {
    name: "Set Matrix Zeroes",
    time_spent: 11,
    tries: 2,
    language: "Python",
    in_contest: 0,
    added: "5mo",
  },
  {
    name: "Number of Good Leaf Nodes Pairs",
    time_spent: 19,
    tries: 1,
    language: "Python",
    in_contest: 0,
    added: "5mo",
  },
]

// Mock data for contests
const contestsData = [
  {
    id: 110,
    name: "A2SV Remote Contest #32",
    problems: 5,
    time_ago: "6mo",
    status: "unrated",
  },
  {
    id: 108,
    name: "A2SV Remote G5 Contest #31",
    problems: 5,
    time_ago: "7mo",
    status: "unrated",
  },
]

export default function UserProfilePage({ params }: { params: { id: string } }) {
  const [activeTab, setActiveTab] = useState("profile")
  const { colorPreset } = useTheme()

  // Get user data based on ID
  const userData = usersData[params.id as keyof typeof usersData] || usersData["1"]

  // Mock data
  const attendanceData = generateMockAttendanceData()
  const attendanceStats = { absent: 0, excused: 1, present: 294, percentage: 99 }

  // Column definitions for problems tab
  const problemsColumns = [
    {
      key: "difficulty",
      title: "Diff.",
      render: (value: string) => <DifficultyBadge level={value} />,
    },
    {
      key: "name",
      title: "Name",
    },
    {
      key: "tag",
      title: "Tag",
      align: "right" as const,
    },
    {
      key: "solved",
      title: "Solved",
      align: "right" as const,
    },
    {
      key: "added",
      title: "Added",
      align: "right" as const,
    },
    {
      key: "vote",
      title: "Vote",
      align: "right" as const,
      render: (value: number) => (
        <div className="flex items-center justify-end gap-1">
          <ArrowUp className="h-4 w-4 text-slate-400 dark:text-slate-500" />
          <span>{value}</span>
          <ArrowDown className="h-4 w-4 text-slate-400 dark:text-slate-500" />
        </div>
      ),
    },
    {
      key: "link",
      title: "Link",
      align: "right" as const,
      render: (value: string) => <ExternalLinkButton href={value} />,
    },
  ]

  // Column definitions for submissions tab
  const submissionsColumns = [
    {
      key: "name",
      title: "Name",
    },
    {
      key: "time_spent",
      title: "Time spent",
      align: "right" as const,
    },
    {
      key: "tries",
      title: "Tries",
      align: "center" as const,
    },
    {
      key: "language",
      title: "Language",
      align: "right" as const,
    },
    {
      key: "in_contest",
      title: "In contest",
      align: "right" as const,
    },
    {
      key: "added",
      title: "Added",
      align: "right" as const,
    },
  ]

  const getHeaderBgClass = () => {
    switch (colorPreset) {
      case "purple":
        return "bg-purple-800 dark:bg-purple-900"
      case "blue":
        return "bg-blue-800 dark:bg-blue-900"
      case "orange":
        return "bg-orange-800 dark:bg-orange-900"
      case "red":
        return "bg-red-800 dark:bg-red-900"
      case "indigo":
        return "bg-indigo-800 dark:bg-indigo-900"
      default:
        return "bg-teal-800 dark:bg-teal-900"
    }
  }

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      {/* Breadcrumb - desktop only */}
      <div className="mb-4 hidden md:flex items-center gap-2 text-sm">
        <Link
          href="/users"
          className="text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-300"
        >
          Users
        </Link>
        <span className="text-slate-400 dark:text-slate-600">›</span>
        <span className="text-slate-700 dark:text-slate-300">{userData.name}</span>
      </div>

      {/* Profile header */}
      <div className={`${getHeaderBgClass()} rounded-lg overflow-hidden mb-8`}>
        <div className="pt-16 pb-6 px-6 relative">
          <div className="absolute bottom-0 left-1/2 transform -translate-x-1/2 translate-y-1/2 md:left-6 md:transform-none md:translate-x-0">
            <div className="h-20 w-20 rounded-full border-4 border-white dark:border-slate-800 overflow-hidden">
              <Image
                src={userData.image || "/placeholder.svg"}
                alt="Profile"
                width={80}
                height={80}
                className="object-cover"
              />
            </div>
          </div>
          <div className="mt-10 text-center md:mt-0 md:ml-24 md:text-left text-white">
            <h1 className="text-xl font-bold">{userData.name}</h1>
            <div className="flex items-center justify-center md:justify-start gap-2">
              <span>{userData.title}</span>
              <span className="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-500 text-white">
                online
              </span>
            </div>
          </div>
        </div>
      </div>

      {/* Profile tabs */}
      <div className="flex border-b mb-8 overflow-x-auto dark:border-slate-700">
        <Button
          variant="ghost"
          className={`text-slate-${activeTab === "profile" ? "900 dark:text-white" : "500 dark:text-slate-400"} ${activeTab === "profile" ? "border-b-2 border-theme" : ""} rounded-none`}
          onClick={() => setActiveTab("profile")}
        >
          Profile
        </Button>
        <Button
          variant="ghost"
          className={`text-slate-${activeTab === "problems" ? "900 dark:text-white" : "500 dark:text-slate-400"} ${activeTab === "problems" ? "border-b-2 border-theme" : ""} rounded-none`}
          onClick={() => setActiveTab("problems")}
        >
          Problems
        </Button>
        <Button
          variant="ghost"
          className={`text-slate-${activeTab === "submissions" ? "900 dark:text-white" : "500 dark:text-slate-400"} ${activeTab === "submissions" ? "border-b-2 border-theme" : ""} rounded-none`}
          onClick={() => setActiveTab("submissions")}
        >
          Submissions
        </Button>
        <Button
          variant="ghost"
          className={`text-slate-${activeTab === "contests" ? "900 dark:text-white" : "500 dark:text-slate-400"} ${activeTab === "contests" ? "border-b-2 border-theme" : ""} rounded-none`}
          onClick={() => setActiveTab("contests")}
        >
          Contests
        </Button>
      </div>

      {/* Profile tab content */}
      {activeTab === "profile" && (
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {/* Left column */}
          <div className="md:col-span-2 space-y-8">
            {/* Consistency section */}
            <ConsistencyCalendar year={2025} />

            {/* Attendance section */}
            <AttendanceGrid data={attendanceData} stats={attendanceStats} />

            {/* Stats section */}
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-white rounded-lg shadow-sm p-4 text-center dark:bg-slate-800 dark:border dark:border-slate-700">
                <h3 className="text-3xl font-bold dark:text-white">{userData.rating || "1,609"}</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">Rating</p>
              </div>
              <div className="bg-white rounded-lg shadow-sm p-4 text-center dark:bg-slate-800 dark:border dark:border-slate-700">
                <h3 className="text-3xl font-bold dark:text-white">{userData.problems}</h3>
                <p className="text-sm text-slate-500 dark:text-slate-400">Problems</p>
              </div>
            </div>
          </div>

          {/* Right column */}
          <div className="space-y-8">
            {/* Division badge */}
            <div className="bg-white rounded-lg shadow-sm p-4 text-center dark:bg-slate-800 dark:border dark:border-slate-700">
              <h3 className="text-xl font-bold dark:text-white">{userData.division || "Div 3"}</h3>
              <p className="text-sm text-slate-500 dark:text-slate-400">
                Next: {userData.nextDivision || "Division II"}
              </p>
            </div>

            {/* About section */}
            <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
              <h2 className="text-lg font-semibold mb-4 dark:text-white">About</h2>
              <p className="text-sm mb-4 dark:text-slate-300">{userData.about}</p>
              <div className="space-y-3">
                <div className="flex items-center gap-2 text-sm dark:text-slate-300">
                  <MapPin className="h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <span>{userData.location}</span>
                </div>
                <div className="flex items-center gap-2 text-sm dark:text-slate-300">
                  <Mail className="h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <span>{userData.email}</span>
                </div>
                <div className="flex items-center gap-2 text-sm dark:text-slate-300">
                  <Code className="h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <span>{userData.language}</span>
                </div>
                <div className="flex items-center gap-2 text-sm dark:text-slate-300">
                  <Users className="h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <span>Student at {userData.group}</span>
                </div>
                <div className="flex items-center gap-2 text-sm dark:text-slate-300">
                  <Building className="h-4 w-4 text-slate-500 dark:text-slate-400" />
                  <span>Studied at {userData.university}</span>
                </div>
              </div>
            </div>

            {/* Badge section */}
            <div className="bg-white rounded-lg shadow-sm p-4 text-center dark:bg-slate-800 dark:border dark:border-slate-700">
              <div className="flex justify-center mb-4">
                <Image
                  src="/placeholder.svg?height=120&width=120"
                  alt="Knight Badge"
                  width={120}
                  height={120}
                  className="object-contain"
                />
              </div>
              <h3 className="text-lg font-semibold dark:text-white">
                {userData.division} : {userData.rating}
              </h3>
              <p className="text-sm text-slate-500 dark:text-slate-400">Next: {userData.nextDivision}</p>
            </div>

            {/* Links section */}
            <ProfileLinks links={userData.links} />
          </div>
        </div>
      )}

      {/* Problems tab content */}
      {activeTab === "problems" && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <div className="flex items-center gap-2">
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Columns
              </Button>
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Filters
              </Button>
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Export
              </Button>
            </div>
          </div>
          <DataTable columns={problemsColumns} data={problemsData} />
        </div>
      )}

      {/* Submissions tab content */}
      {activeTab === "submissions" && (
        <div>
          <div className="flex justify-between items-center mb-4">
            <div className="flex items-center gap-2">
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Columns
              </Button>
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Filters
              </Button>
              <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                Export
              </Button>
            </div>
          </div>
          <DataTable columns={submissionsColumns} data={submissionsData} />
        </div>
      )}

      {/* Contests tab content */}
      {activeTab === "contests" && (
        <div className="space-y-8">
          <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
            <h2 className="text-lg font-semibold mb-4 dark:text-white">Contest Progress</h2>
            {/* Placeholder for contest progress chart */}
            <div className="h-64 bg-slate-50 dark:bg-slate-800 rounded flex items-center justify-center mb-4">
              <p className="text-slate-500 dark:text-slate-400">Contest progress chart visualization</p>
            </div>
            <div className="flex flex-wrap gap-2">
              <div className="flex items-center gap-1">
                <div className="h-3 w-3 rounded-full bg-blue-500"></div>
                <span className="text-xs dark:text-slate-300">Coder</span>
              </div>
              <div className="flex items-center gap-1">
                <div className="h-3 w-3 rounded-full bg-green-500"></div>
                <span className="text-xs dark:text-slate-300">Solver</span>
              </div>
              <div className="flex items-center gap-1">
                <div className="h-3 w-3 rounded-full bg-red-500"></div>
                <span className="text-xs dark:text-slate-300">Strategist</span>
              </div>
              <div className="flex items-center gap-1">
                <div className="h-3 w-3 rounded-full bg-purple-500"></div>
                <span className="text-xs dark:text-slate-300">Knight</span>
              </div>
              <div className="flex items-center gap-1">
                <div className="h-3 w-3 rounded-full bg-yellow-500"></div>
                <span className="text-xs dark:text-slate-300">Ninja</span>
              </div>
            </div>
          </div>

          <div className="space-y-4">
            {contestsData.map((contest) => (
              <div
                key={contest.id}
                className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700"
              >
                <div className="flex justify-between items-center">
                  <div>
                    <h3 className="font-medium dark:text-white">
                      {contest.id}. {contest.name}
                    </h3>
                    <p className="text-sm text-slate-500 dark:text-slate-400">
                      {contest.problems} problems • {contest.time_ago} ago • {contest.status}
                    </p>
                  </div>
                  <div className="flex items-center gap-2">
                    <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                      <ArrowUp className="h-4 w-4" />
                    </Button>
                    <Button variant="outline" size="sm" className="dark:border-slate-700 dark:text-white">
                      <ExternalLinkButton href="#" />
                    </Button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      )}
    </div>
  )
}
