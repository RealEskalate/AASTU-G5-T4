import Image from "next/image"
import { Button } from "@/components/ui/button"
import { SessionCountdown } from "@/components/session-countdown"
import { StatsCard } from "@/components/stats-card"
import { MiniBarChart } from "@/components/mini-chart"
import { DataTable, DifficultyBadge, ExternalLinkButton } from "@/components/data-table"

export default function Dashboard() {
  // Mock data for latest problems
  const latestProblems = [
    {
      difficulty: "Hard",
      name: "F - The Triumphant Empress",
      tag: "Contest",
      added: "2d",
      vote: 0,
      link: "#",
    },
    {
      difficulty: "Medium",
      name: "E - Machine Testing",
      tag: "Contest",
      added: "2d",
      vote: 0,
      link: "#",
    },
    {
      difficulty: "Medium",
      name: "D - Final Strength",
      tag: "Contest",
      added: "2d",
      vote: 0,
      link: "#",
    },
  ]

  // Mock data for latest submissions
  const latestSubmissions = [
    {
      name: "Amy Andrianaina",
      problem: "3. Longest Substring Without",
      time_spent: 3,
      language: "Python",
      added: "14m",
    },
    {
      name: "Emran",
      problem: "Max Area of Island",
      time_spent: 50,
      language: "Python",
      added: "14m",
    },
    {
      name: "Ibrahim Muhaba",
      problem: "Find the Town Judge",
      time_spent: 28,
      language: "Python",
      added: "14m",
    },
  ]

  // Column definitions for problems table
  const problemColumns = [
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
      key: "added",
      title: "Added",
      align: "right" as const,
    },
    {
      key: "vote",
      title: "Vote",
      align: "right" as const,
    },
    {
      key: "link",
      title: "Link",
      align: "right" as const,
      render: (value: string) => <ExternalLinkButton href={value} />,
    },
  ]

  // Column definitions for submissions table
  const submissionColumns = [
    {
      key: "name",
      title: "Name",
      render: (value: string, row: any) => (
        <div className="flex items-center gap-3">
          <div className="h-8 w-8 rounded-full bg-slate-200 dark:bg-slate-700"></div>
          <span>{value}</span>
        </div>
      ),
    },
    {
      key: "problem",
      title: "Problem",
    },
    {
      key: "time_spent",
      title: "Time spent",
      align: "right" as const,
    },
    {
      key: "language",
      title: "Language",
      align: "right" as const,
    },
    {
      key: "added",
      title: "Added",
      align: "right" as const,
    },
  ]

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      {/* Hero section */}
      <div className="bg-theme-bg rounded-lg p-6 mb-8 dark:bg-slate-800 dark:border dark:border-slate-700">
        <div className="flex flex-col md:flex-row gap-8">
          <div className="flex-1">
            <h1 className="text-2xl font-bold mb-2 dark:text-white">
              Perfection is not attainable, but if we chase perfection we can catch excellence.
            </h1>
            <p className="text-slate-600 mb-4 dark:text-slate-400">— Vince Lombardi</p>
            <div className="mb-6">
              <p className="text-slate-700 dark:text-slate-300">Welcome back,</p>
              <p className="text-slate-700 font-medium dark:text-slate-300">Natnael!</p>
            </div>
            <Button className="bg-theme hover:bg-theme-dark text-white">Problems</Button>
          </div>
          <div className="flex-1 flex justify-center items-center">
            <Image
              src="/placeholder.svg?height=200&width=300"
              alt="Dashboard illustration"
              width={300}
              height={200}
              className="object-contain"
            />
          </div>
        </div>
      </div>

      {/* Companion notice */}
      <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-8 dark:bg-yellow-900/20 dark:border-yellow-800">
        <div className="flex justify-between items-center">
          <div className="flex items-start gap-2">
            <div className="mt-1">🛠️</div>
            <div>
              <h3 className="font-medium dark:text-white">Companion</h3>
              <p className="text-sm text-slate-600 dark:text-slate-300">
                A2SV Companion is not detected. The extension will help you submit problems you solve on leetcode and
                codeforces. Please install the extension and reload this page.
              </p>
            </div>
          </div>
          <Button className="bg-theme hover:bg-theme-dark text-white whitespace-nowrap">Install</Button>
        </div>
      </div>

      {/* Stats cards - desktop view */}
      <div className="hidden md:grid grid-cols-3 gap-6 mb-8">
        <StatsCard
          title="Solutions"
          value={448}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="blue" />}
        />
        <StatsCard
          title="Time Spent"
          value={10597}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="blue" />}
        />
        <StatsCard
          title="Rating"
          value={1609}
          change={{ value: 0.0, isPositive: true }}
          chart={<MiniBarChart color="red" />}
        />
      </div>

      {/* Stats cards - mobile view */}
      <div className="md:hidden space-y-4 mb-8">
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Solutions</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">448</span>
          </div>
        </div>
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Time Spent</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">
              10,597<span className="text-xs text-slate-500 dark:text-slate-400 ml-1">(min)</span>
            </span>
          </div>
          <div className="text-xs text-slate-500 dark:text-slate-400">That's 7 Days</div>
        </div>
        <div className="bg-white rounded-lg shadow-sm p-4 dark:bg-slate-800 dark:border dark:border-slate-700">
          <h3 className="text-sm font-medium text-slate-600 dark:text-slate-300">Rating</h3>
          <div className="flex items-center gap-2 mt-1">
            <span className="text-green-500 text-xs">↑ 0.0%</span>
            <span className="text-2xl font-bold dark:text-white">1,609</span>
          </div>
        </div>
      </div>

      {/* Daily problem section */}
      <div className="bg-theme-bg rounded-lg p-4 mb-8 dark:bg-slate-800 dark:border dark:border-slate-700">
        <div className="flex justify-between items-start mb-2">
          <div>
            <h2 className="text-lg font-semibold flex items-center dark:text-white">
              Daily problem
              <span className="ml-2 text-xs text-slate-500 rounded-full bg-slate-200 dark:bg-slate-700 dark:text-slate-300 h-5 w-5 flex items-center justify-center">
                ?
              </span>
            </h2>
            <p className="text-sm text-slate-500 dark:text-slate-400">
              Refreshes every 24 hours and needs to be solved today!
            </p>
          </div>
          <div className="flex items-center gap-2">
            <span className="text-2xl font-bold dark:text-white">81</span>
            <span className="text-xs text-slate-500 dark:text-slate-400">Solved it</span>
          </div>
        </div>

        <div className="mb-4">
          <h3 className="text-lg font-medium dark:text-white">Split Array Into Consecutive Subsequences</h3>
          <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400">
            <span>LeetCode</span>
            <span>·</span>
            <span>Medium</span>
            <span>·</span>
            <span>Heap</span>
          </div>
        </div>

        <div className="flex flex-col sm:flex-row gap-2">
          <Button className="flex-1 bg-theme hover:bg-theme-dark text-white">Solve it Now</Button>
          <Button variant="outline" className="flex-1 dark:text-white dark:border-slate-600">
            New Solution
          </Button>
        </div>
      </div>

      {/* Session countdown - mobile view */}
      <div className="md:hidden mb-8">
        <div className="bg-white rounded-lg shadow-sm p-4 text-center dark:bg-slate-800 dark:border dark:border-slate-700">
          <div className="flex justify-between items-center mb-2">
            <Button variant="outline" size="sm" className="h-7 w-7 p-0 dark:border-slate-600 dark:text-white">
              &lt;
            </Button>
            <span className="text-sm font-medium dark:text-white">1/1</span>
            <Button variant="outline" size="sm" className="h-7 w-7 p-0 dark:border-slate-600 dark:text-white">
              &gt;
            </Button>
          </div>
          <div className="bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300 inline-block px-2 py-1 rounded-full text-xs mb-2">
            Upcoming
          </div>
          <h3 className="text-xl font-bold dark:text-white">uytdtr</h3>
          <div className="text-2xl font-bold dark:text-white">21h 52m 38s</div>
          <p className="text-sm text-slate-500 dark:text-slate-400">Fri Apr 11 | 05:30-08:00</p>
        </div>
      </div>

      {/* Desktop layout for session countdown and groups */}
      <div className="hidden md:grid grid-cols-3 gap-6 mb-8">
        {/* Session countdown */}
        <div className="md:col-span-1">
          <SessionCountdown title="uytdtr" subtitle="Fri Apr 11 | 05:30-08:00" link="#" />
        </div>

        {/* Groups */}
        <div className="md:col-span-2">
          <div className="bg-white p-4 rounded-lg shadow-sm h-full dark:bg-slate-800 dark:border dark:border-slate-700">
            <div className="space-y-4">
              <div className="flex justify-between items-center p-2 border-b dark:border-slate-700">
                <div>
                  <h3 className="font-medium dark:text-white">A2SV Remote Group 47</h3>
                </div>
                <div className="text-sm text-slate-500 dark:text-slate-400">G47</div>
              </div>
              <div className="flex justify-between items-center p-2 border-b dark:border-slate-700">
                <div>
                  <h3 className="font-medium dark:text-white">A2SV AASTU Group 46</h3>
                </div>
                <div className="text-sm text-slate-500 dark:text-slate-400">G46</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      {/* Latest problems */}
      <div className="mb-8">
        <DataTable title="Latest Problems" columns={problemColumns} data={latestProblems} />
      </div>

      {/* Latest submissions */}
      <div className="mb-8">
        <DataTable title="Latest Submissions" columns={submissionColumns} data={latestSubmissions} />
      </div>
    </div>
  )
}
