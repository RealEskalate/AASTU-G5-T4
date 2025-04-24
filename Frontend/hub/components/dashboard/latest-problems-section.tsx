import Link from "next/link"
import { ArrowUpRight } from "lucide-react"
import { Button } from "@/components/ui/button"

interface Problem {
  difficulty: string
  name: string
  tag: string
  added: string
  vote: number
}

interface LatestProblemsSectionProps {
  problems: Problem[]
}

export function LatestProblemsSection({ problems }: LatestProblemsSectionProps) {
  return (
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
            {problems.map((problem, index) => (
              <tr key={index} className={index < problems.length - 1 ? "border-b dark:border-slate-700" : ""}>
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
  )
}
