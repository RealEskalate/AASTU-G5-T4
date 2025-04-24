import Image from "next/image"
import { Button } from "@/components/ui/button"
import { ArrowUpRight, Info } from "lucide-react"
import Link from "next/link"

export default function Dashboard() {
  // Mock data for stats
  const statsData = {
    solutions: 438,
    timeSpent: 10354,
    rating: 1609,
  }

  // Mock data for daily problem
  const dailyProblem = {
    title: "Find Median From Data Stream",
    platform: "LeetCode",
    difficulty: "Hard",
    tag: "Heap",
    solvedCount: 335,
  }

  // Mock data for latest problems
  const latestProblems = [
    {
      difficulty: "Hard",
      name: "F - White Collar - Au revoir (goodbye until we meet again.)",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "E - Naruto - Hidden Leaf Story: The Perfect Day for a Wedding",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "D - Impostors - See You Soon, Macaroon",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "C - The big bang theory - The Stockholm Syndrome",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
    {
      difficulty: "Medium",
      name: "B - Friends - The Last One",
      tag: "Contest",
      added: "19h",
      vote: 0,
    },
  ]

  return (
    <div className="p-4 md:p-6 max-w-7xl mx-auto">
      {/* Companion notification */}
      <div className="bg-yellow-50 border border-yellow-200 rounded-lg p-4 mb-6 dark:bg-yellow-900/20 dark:border-yellow-800">
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
          <Button className="bg-green-500 hover:bg-green-600 text-white whitespace-nowrap">Install</Button>
        </div>
      </div>

      {/* Hero section */}
      <div className="bg-green-50 dark:bg-green-900/10 rounded-lg p-6 mb-8 relative overflow-hidden">
        <div className="flex flex-col md:flex-row gap-8 relative z-10">
          <div className="flex-1">
            <h1 className="text-2xl font-bold mb-2 dark:text-white">
              Be the change that you want to see in the world.
            </h1>
            <p className="text-slate-600 mb-4 dark:text-slate-400">— Mahatma Gandhi</p>
            <div className="mb-6">
              <p className="text-slate-700 dark:text-slate-300">Welcome back,</p>
              <p className="text-slate-700 font-medium dark:text-slate-300">Natnael!</p>
            </div>
            <Button className="bg-green-500 hover:bg-green-600 text-white">Problems</Button>
          </div>
          <div className="flex-1 flex justify-center items-center">
            <div className="relative w-full h-40 md:h-auto">
              <Image src="/images/home-illustration.png" alt="Dashboard illustration" fill className="object-contain" />
            </div>
          </div>
        </div>
        <div className="absolute top-0 right-0 p-4 text-sm text-slate-500 dark:text-slate-400">NO NEW EVENT</div>
      </div>

      {/* Stats section */}
      <div className="grid grid-cols-3 gap-6 mb-8">
        <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs text-green-500">↑ 0.0%</span>
          </div>
          <div className="text-3xl font-bold dark:text-white">{statsData.solutions}</div>
          <div className="text-sm text-slate-500 dark:text-slate-400">Solutions</div>
        </div>

        <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs text-green-500">↑ 0.0%</span>
          </div>
          <div>
            <div className="text-3xl font-bold dark:text-white">
              {statsData.timeSpent.toLocaleString()}
              <span className="text-xs text-slate-500 dark:text-slate-400 ml-1">(min)</span>
            </div>
            <div className="text-xs text-slate-500 dark:text-slate-400">That's 7 Days</div>
          </div>
          <div className="text-sm text-slate-500 dark:text-slate-400">Time Spent</div>
        </div>

        <div className="bg-white dark:bg-slate-800 rounded-lg p-4 shadow-sm">
          <div className="flex items-center justify-between mb-2">
            <span className="text-xs text-green-500">↑ 0.0%</span>
            <div className="h-6 w-12 bg-red-100 dark:bg-red-900/20 rounded">{/* Mini chart placeholder */}</div>
          </div>
          <div className="text-3xl font-bold dark:text-white">{statsData.rating.toLocaleString()}</div>
          <div className="text-sm text-slate-500 dark:text-slate-400">Rating</div>
        </div>
      </div>

      {/* Daily problem section */}
      <div className="bg-green-50 dark:bg-green-900/10 rounded-lg p-6 mb-8 relative">
        <div className="flex justify-between items-start mb-2">
          <div className="flex items-center gap-2">
            <h2 className="text-lg font-semibold dark:text-white">Daily problem</h2>
            <Info className="h-4 w-4 text-slate-400" />
          </div>
          <div className="flex items-center gap-2">
            <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
              <span className="sr-only">Upvote</span>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-slate-400"
              >
                <path d="m18 15-6-6-6 6" />
              </svg>
            </Button>
            <span className="text-sm dark:text-white">0</span>
            <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
              <span className="sr-only">Downvote</span>
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="16"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                className="text-slate-400"
              >
                <path d="m6 9 6 6 6-6" />
              </svg>
            </Button>
          </div>
        </div>
        <p className="text-sm text-slate-500 dark:text-slate-400 mb-4">
          Refreshes every 24 hours and needs to be solved today!
        </p>

        <h3 className="text-xl font-medium dark:text-white mb-1">{dailyProblem.title}</h3>
        <div className="flex items-center gap-2 text-sm text-slate-600 dark:text-slate-400 mb-4">
          <span>{dailyProblem.platform}</span>
          <span>·</span>
          <span className="text-red-500">{dailyProblem.difficulty}</span>
          <span>·</span>
          <span>{dailyProblem.tag}</span>
        </div>

        <div className="flex flex-col sm:flex-row gap-2">
          <Button className="flex-1 bg-green-500 hover:bg-green-600 text-white flex items-center justify-center gap-1">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <path d="M5 12h14" />
              <path d="m12 5 7 7-7 7" />
            </svg>
            Solve It Now
          </Button>
          <Button
            variant="outline"
            className="flex-1 dark:text-white dark:border-slate-600 flex items-center justify-center gap-1"
          >
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
            >
              <path d="M12 5v14" />
              <path d="M5 12h14" />
            </svg>
            New Solution
          </Button>
        </div>

        <div className="absolute top-6 right-6">
          <div className="text-3xl font-bold text-slate-300 dark:text-slate-700">{dailyProblem.solvedCount}</div>
          <div className="text-xs text-slate-400 dark:text-slate-600 text-right">Solved it</div>
        </div>
      </div>

      {/* Latest problems */}
      <div className="mb-8">
        <h2 className="text-lg font-semibold mb-4 dark:text-white">Latest Problems</h2>
        <div className="bg-white dark:bg-slate-800 rounded-lg shadow-sm overflow-hidden">
          <table className="w-full">
            <thead>
              <tr className="border-b dark:border-slate-700">
                <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Diff.</th>
                <th className="py-3 px-4 text-left font-medium text-sm text-slate-600 dark:text-slate-300">Name</th>
                <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Tag</th>
                <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Added</th>
                <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Vote</th>
                <th className="py-3 px-4 text-right font-medium text-sm text-slate-600 dark:text-slate-300">Link</th>
              </tr>
            </thead>
            <tbody>
              {latestProblems.map((problem, index) => (
                <tr key={index} className={index < latestProblems.length - 1 ? "border-b dark:border-slate-700" : ""}>
                  <td className="py-3 px-4">
                    <span
                      className={`inline-flex items-center px-2 py-0.5 rounded text-xs font-medium ${
                        problem.difficulty === "Hard"
                          ? "bg-red-100 text-red-800 dark:bg-red-900/30 dark:text-red-300"
                          : "bg-yellow-100 text-yellow-800 dark:bg-yellow-900/30 dark:text-yellow-300"
                      }`}
                    >
                      {problem.difficulty}
                    </span>
                  </td>
                  <td className="py-3 px-4 dark:text-slate-300">{problem.name}</td>
                  <td className="py-3 px-4 text-right dark:text-slate-300">{problem.tag}</td>
                  <td className="py-3 px-4 text-right dark:text-slate-300">{problem.added}</td>
                  <td className="py-3 px-4 text-right dark:text-slate-300">
                    <div className="flex items-center justify-end gap-1">
                      <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          width="16"
                          height="16"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth="2"
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          className="text-slate-400"
                        >
                          <path d="m18 15-6-6-6 6" />
                        </svg>
                      </Button>
                      <span>{problem.vote}</span>
                      <Button variant="ghost" size="sm" className="h-6 w-6 p-0">
                        <svg
                          xmlns="http://www.w3.org/2000/svg"
                          width="16"
                          height="16"
                          viewBox="0 0 24 24"
                          fill="none"
                          stroke="currentColor"
                          strokeWidth="2"
                          strokeLinecap="round"
                          strokeLinejoin="round"
                          className="text-slate-400"
                        >
                          <path d="m6 9 6 6 6-6" />
                        </svg>
                      </Button>
                    </div>
                  </td>
                  <td className="py-3 px-4 text-right">
                    <Link href="#" className="text-blue-500 hover:text-blue-700">
                      <ArrowUpRight className="h-4 w-4 inline" />
                    </Link>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}
